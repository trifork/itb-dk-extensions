package net.ihe.gazelle.cdabasic.utils;

import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import net.ihe.gazelle.validation.DocumentValidXSD;
import net.ihe.gazelle.validation.DocumentWellFormed;
import net.ihe.gazelle.validation.XSDMessage;
import net.ihe.gazelle.xmltools.xsd.ValidationException;
import net.ihe.gazelle.xmltools.xsd.XSDValidator;
import org.apache.commons.lang.StringUtils;

public class XMLValidation {

    private static final String ERROR = "error";
    private static final SAXParserFactory factoryBASIC = basicFactory();

    private XMLValidation() {}

    private static SAXParserFactory basicFactory() {
        SAXParserFactory factory = SAXParserFactory.newInstance();
        factory.setValidating(false);
        factory.setNamespaceAware(true);
        return factory;
    }

    static LoadingCache<String, SAXParserFactory> parserCache =
            CacheBuilder.newBuilder()
                    .build(
                            new CacheLoader<String, SAXParserFactory>() {

                                @Override
                                public SAXParserFactory load(final String key) throws Exception {
                                    final SAXParserFactory factoryCDA =
                                            SAXParserFactory.newInstance();
                                    factoryCDA.setNamespaceAware(true);
                                    final SchemaFactory sfactory =
                                            SchemaFactory.newInstance(
                                                    "http://www.w3.org/2001/XMLSchema");
                                    final Schema schema =
                                            sfactory.newSchema(
                                                    new File(ProjectDependencies.CDA_XSD));
                                    factoryCDA.setSchema(schema);
                                    return factoryCDA;
                                }
                            });

    /**
     * Parses the file using SAX to check that it is a well-formed XML file
     *
     * @param file
     * @return
     */
    public static DocumentWellFormed isXMLWellFormed(final String string) {
        return validateIfDocumentWellFormedXML(string, "", factoryBASIC);
    }

    private static DocumentWellFormed validateIfDocumentWellFormedXML(
            final String cdaDocument, final String xsdpath, final SAXParserFactory factory) {
        final DocumentWellFormed dv = new DocumentWellFormed();
        return validXMLUsingXSD(cdaDocument, xsdpath, factory, dv);
    }

    /**
     * @param file
     * @param xsdLocation
     * @return
     */
    private static synchronized DocumentValidXSD validXMLUsingXSD(final String xdwDocument) {

        try {
            final SAXParserFactory factoryCDA = parserCache.get(ProjectDependencies.CDA_XSD);
            if (factoryCDA == null || factoryCDA.getSchema() == null) {
                final DocumentValidXSD res = new DocumentValidXSD();
                res.setResult("FAILED");
                res.setNbOfErrors("1");
                res.getXSDMessage().add(new XSDMessage());
                res.getXSDMessage().get(0).setColumnNumber(0);
                res.getXSDMessage().get(0).setLineNumber(0);
                res.getXSDMessage().get(0).setSeverity(ERROR);
                res.getXSDMessage()
                        .get(0)
                        .setMessage(
                                "The XSD schema is not well configured on the application ! Please contact the administrator to fix this.");
                return res;
            }
            return validXMLUsingXSD(xdwDocument, ProjectDependencies.CDA_XSD, factoryCDA);
        } catch (final ExecutionException e) {
            throw new RuntimeException(e);
        }
    }

    private static DocumentValidXSD validXMLUsingXSD(
            final String cdaDocument, final String xsdpath, final SAXParserFactory factory) {
        final DocumentValidXSD dv = new DocumentValidXSD();
        return validXMLUsingXSD(cdaDocument, xsdpath, factory, dv);
    }

    private static <T extends DocumentValidXSD> T validXMLUsingXSD(
            final String cdaDocument,
            final String xsdpath,
            final SAXParserFactory factory,
            final T dv) {
        List<ValidationException> exceptions = new ArrayList<ValidationException>();
        try {
            final ByteArrayInputStream bais =
                    new ByteArrayInputStream(cdaDocument.getBytes(StandardCharsets.UTF_8));
            exceptions = XSDValidator.validateUsingFactoryAndSchema(bais, xsdpath, factory);
        } catch (final Exception e) {
            exceptions.add(handleException(e));
        }
        return extractValidationResult(exceptions, dv);
    }

    private static <T extends DocumentValidXSD> T extractValidationResult(
            final List<ValidationException> exceptions, final T dv) {
        dv.setResult("PASSED");
        if (exceptions == null || exceptions.isEmpty()) return dv;
        int errors = 0;
        int warnings = 0;
        for (ValidationException exception : exceptions) {
            if (exception.getSeverity() == null) exception.setSeverity(ERROR);
            if ("warning".equals(exception.getSeverity())) warnings++;
            else errors++;
            dv.getXSDMessage().add(toMessage(exception));
        }
        dv.setNbOfErrors(Integer.toString(errors));
        dv.setNbOfWarnings(Integer.toString(warnings));
        if (errors > 0) dv.setResult("FAILED");
        return dv;
    }

    private static XSDMessage toMessage(ValidationException exception) {
        XSDMessage message = new XSDMessage();
        message.setMessage(exception.getMessage());
        message.setSeverity(exception.getSeverity());
        if (StringUtils.isNumeric(exception.getLineNumber()))
            message.setLineNumber(Integer.valueOf(exception.getLineNumber()));
        if (StringUtils.isNumeric(exception.getColumnNumber()))
            message.setColumnNumber(Integer.valueOf(exception.getColumnNumber()));
        return message;
    }

    private static ValidationException handleException(final Exception e) {
        final ValidationException ve = new ValidationException();
        ve.setLineNumber("0");
        ve.setColumnNumber("0");
        if (e.getMessage() != null) {
            ve.setMessage("error on validating : " + e.getMessage());
        } else if (e.getCause() != null && e.getCause().getMessage() != null) {
            ve.setMessage("error on validating : " + e.getCause().getMessage());
        } else {
            ve.setMessage(
                    "error on validating. The exception generated is of kind : "
                            + e.getClass().getSimpleName());
        }
        ve.setSeverity(ERROR);
        return ve;
    }

    /**
     * Checks that the CDA document is valid (uses CDA.xsd file)
     *
     * @param file
     * @return
     */
    public static DocumentValidXSD isXSDValid(final String document) {
        if (document == null) {
            return null;
        } else {
            return validXMLUsingXSD(document);
        }
    }
}
