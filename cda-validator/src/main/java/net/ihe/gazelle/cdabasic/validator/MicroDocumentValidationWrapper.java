package net.ihe.gazelle.cdabasic.validator;

import java.awt.Desktop;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.attribute.PosixFilePermissions;
import java.util.HashMap;
import java.util.Map;
import javax.xml.bind.JAXBException;
import net.ihe.gazelle.IHEPaths;
import net.ihe.gazelle.cdabasic.utils.ProjectDependencies;
import net.ihe.gazelle.validation.DetailedResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MicroDocumentValidationWrapper {
    private MicroDocumentValidationWrapper() {}

    static Logger logger = LoggerFactory.getLogger(MicroDocumentValidationWrapper.class);

    public static DetailedResult validate(final String document, final IHEPaths paths) {

        // IHE default schemas
        ProjectDependencies.CDA_XSD = paths.getCdaXsd();
        ProjectDependencies.VALUE_SET_REPOSITORY = paths.getValueSetRepo();
        ProjectDependencies.CDA_XSL_TRANSFORMER = paths.getCdaXsl();
        return MicroDocumentValidation.validateIHE_BASIC_CDA_STRICTED(document);
    }

    public static String getDetailedResultAsString(final DetailedResult dr) {
        if (dr != null) {
            final ByteArrayOutputStream baos = new ByteArrayOutputStream();
            try {
                DetailedResultTransformer.save(baos, dr);
            } catch (final JAXBException e) {
                throw new IllegalStateException("Unable to serialize Gazelle validation result", e);
            }
            String res = baos.toString();
            res = deleteUnicodeZero(res);
            return res;
        }
        return null;
    }

    public static void showDetailedResultInBrowser(final DetailedResult dr)
            throws FileNotFoundException {
        final Map<String, Object> map = new HashMap<String, Object>();
        map.put("viewdown", false);
        map.put("constraintPath", false);
        String xml = java.util.Objects.requireNonNull(getDetailedResultAsString(dr), "result");
        try (var stylesheet = new FileInputStream(ProjectDependencies.CDA_XSL_TRANSFORMER)) {
            String htmlString =
                    GazelleCDABASICValidator.resultTransformation(
                            new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)),
                            stylesheet,
                            map);
            var temp =
                    Files.createTempFile(
                            "gazelle-result-",
                            ".html",
                            PosixFilePermissions.asFileAttribute(
                                    PosixFilePermissions.fromString("rw-------")));
            temp.toFile().deleteOnExit();
            Files.writeString(temp, htmlString, StandardCharsets.UTF_8);
            Desktop.getDesktop().browse(temp.toUri());
        } catch (FileNotFoundException e) {
            throw e;
        } catch (Exception e) {
            logger.error("Unable to display Gazelle validation result", e);
        }
    }

    private static String deleteUnicodeZero(final String s) {
        return s.replace("\u0000", "");
    }
}
