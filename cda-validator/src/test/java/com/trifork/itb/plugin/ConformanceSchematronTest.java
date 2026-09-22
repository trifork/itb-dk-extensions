package com.trifork.itb.plugin;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.file.*;
import java.util.*;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.*;
import net.sf.saxon.TransformerFactoryImpl;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import org.w3c.dom.*;

/** Execute real ISO Schematron/SVRL, including independent patterns and inherited templates. */
class ConformanceSchematronTest {
    private static final Path ROOT = Paths.get("..").toAbsolutePath().normalize();
    private static final String SVRL = "http://purl.oclc.org/dsdl/svrl";

    private static Document parse(Path file) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        return factory.newDocumentBuilder().parse(file.toFile());
    }

    private static Templates compile(String profile) throws Exception {
        TransformerFactory factory = new TransformerFactoryImpl();
        String compiler = "/external/schematron/20100710-xslt2/iso_svrl_for_xslt2.xsl";
        Transformer transform =
                factory.newTransformer(
                        new StreamSource(
                                Objects.requireNonNull(
                                                ConformanceSchematronTest.class.getResource(
                                                        compiler))
                                        .toExternalForm()));
        DOMResult xslt = new DOMResult();
        transform.transform(
                new StreamSource(
                        ROOT.resolve(
                                        "cda-validator/domain/cda-dk/sch/versions/"
                                                + profile
                                                + "-conformance.sch")
                                .toFile()),
                xslt);
        return factory.newTemplates(new DOMSource(xslt.getNode()));
    }

    private static Document validate(Templates schema, Document input) throws Exception {
        DOMResult result = new DOMResult();
        schema.newTransformer().transform(new DOMSource(input), result);
        return (Document) result.getNode();
    }

    private static Set<String> failures(Document report) {
        Set<String> ids = new TreeSet<>();
        NodeList nodes = report.getElementsByTagNameNS(SVRL, "failed-assert");
        for (int i = 0; i < nodes.getLength(); i++) {
            Element assertion = (Element) nodes.item(i);
            ids.add(assertion.getAttribute("id"));
            assertFalse(
                    assertion.getAttribute("location").isEmpty(),
                    "A finding must have an XML location");
        }
        return ids;
    }

    private static final Map<String, Templates> SCHEMAS = new HashMap<>();

    public static Collection<Object[]> cases() throws Exception {
        List<Object[]> result = new ArrayList<>();
        List<Path> files = new ArrayList<>();
        files.add(ROOT.resolve("cda-validator/src/test/resources/pro/cases.xml"));
        try (java.util.stream.Stream<Path> paths =
                Files.list(ROOT.resolve("cda-validator/src/test/resources/cda"))) {
            paths.filter(path -> path.toString().endsWith("-cases.xml"))
                    .sorted()
                    .forEach(files::add);
        }
        for (Path file : files) {
            NodeList nodes = parse(file).getElementsByTagName("case");
            for (int i = 0; i < nodes.getLength(); i++) {
                Element item = (Element) nodes.item(i);
                item.setAttribute("fixtureDirectory", file.getParent().toString());
                result.add(
                        new Object[] {
                            item.getAttribute("profile") + ": " + item.getAttribute("name"), item
                        });
            }
        }
        return result;
    }

    @BeforeAll
    static void compileSchemas() throws Exception {
        for (Object[] entry : cases()) {
            String profile = ((Element) entry[1]).getAttribute("profile");
            if (!SCHEMAS.containsKey(profile)) SCHEMAS.put(profile, compile(profile));
        }
    }

    @ParameterizedTest(name = "{0}")
    @MethodSource("cases")
    void conformanceFixture(String caseName, Element test) throws Exception {
        XPath xpath = XPathFactory.newInstance().newXPath();
        xpath.setNamespaceContext(
                new javax.xml.namespace.NamespaceContext() {
                    public String getNamespaceURI(String prefix) {
                        if (prefix.equals("pro")) return "urn:dk:medcom:pro:validation";
                        if (prefix.equals("v3")) return "urn:hl7-org:v3";
                        if (prefix.equals("sdtc")) return "urn:hl7-org:sdtc";
                        if (prefix.equals("xsi"))
                            return "http://www.w3.org/2001/XMLSchema-instance";
                        return XMLConstants.NULL_NS_URI;
                    }

                    public String getPrefix(String uri) {
                        throw new UnsupportedOperationException();
                    }

                    public Iterator<String> getPrefixes(String uri) {
                        throw new UnsupportedOperationException();
                    }
                });
        String name = test.getAttribute("name");
        String profile = test.getAttribute("profile");
        Document input =
                parse(Paths.get(test.getAttribute("fixtureDirectory")).resolve(profile + ".xml"));
        NodeList edits = test.getElementsByTagName("edit");
        for (int j = 0; j < edits.getLength(); j++) {
            Element edit = (Element) edits.item(j);
            Node node =
                    (Node) xpath.evaluate(edit.getAttribute("select"), input, XPathConstants.NODE);
            assertNotNull(node, name + ": mutation did not find " + edit.getAttribute("select"));
            switch (edit.getAttribute("action")) {
                case "remove":
                    if (node instanceof Attr)
                        ((Attr) node).getOwnerElement().removeAttributeNode((Attr) node);
                    else node.getParentNode().removeChild(node);
                    break;
                case "duplicate":
                    node.getParentNode().appendChild(node.cloneNode(true));
                    break;
                case "text":
                    node.setTextContent(edit.getAttribute("value"));
                    break;
                case "append":
                    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                    factory.setNamespaceAware(true);
                    factory.setFeature(
                            "http://apache.org/xml/features/disallow-doctype-decl", true);
                    Document fragment =
                            factory.newDocumentBuilder()
                                    .parse(
                                            new org.xml.sax.InputSource(
                                                    new java.io.StringReader(
                                                            edit.getAttribute("value"))));
                    node.appendChild(input.importNode(fragment.getDocumentElement(), true));
                    break;
                case "set":
                    node.setNodeValue(edit.getAttribute("value"));
                    break;
                default:
                    fail("Unknown mutation action");
            }
        }
        Set<String> found = failures(validate(SCHEMAS.get(profile), input));
        if (!test.hasAttribute("fails")) assertEquals(Collections.emptySet(), found, name);
        else
            for (String id : test.getAttribute("fails").split(" "))
                assertTrue(found.contains(id), name + ": expected " + id + "; got " + found);
    }
}
