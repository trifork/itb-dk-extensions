package com.trifork.itb.preview;

import static org.junit.jupiter.api.Assertions.*;

import java.nio.charset.StandardCharsets;
import javax.xml.transform.TransformerException;
import org.jsoup.Jsoup;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

class CdaRendererTest {
    private static CdaRenderer renderer;

    @BeforeAll
    static void setup() throws Exception {
        renderer = new CdaRenderer();
    }

    @Test
    void stylesheetResolverRejectsEveryOtherResource() {
        for (String uri :
                new String[] {"file:///etc/passwd", "https://example.com/a.xml", "other.xsl", ""}) {
            assertThrows(
                    TransformerException.class,
                    () -> renderer.resolveStylesheet(uri, "untrusted-base"));
        }
    }

    @Test
    void displaysNarrativeWithoutRequiringAValidProfile() throws Exception {
        var html = Jsoup.parse(renderer.render(xml("<paragraph>Blodtryk: æøå</paragraph>")));
        assertTrue(html.text().contains("Blodtryk: æøå"));
        assertTrue(html.text().contains("Home measurements"));
        assertEquals(CdaRenderer.POLICY, html.selectFirst("meta[http-equiv]").attr("content"));
    }

    @Test
    void rendersTableAttributesUsingTheStylesheetsOwnAllowlist() throws Exception {
        var html =
                Jsoup.parse(
                        renderer.render(
                                xml(
                                        """
                <table border="1" width="100%"><tbody><tr><td colspan="2">Table narrative</td></tr></tbody></table>
                """)));
        var cell = html.selectFirst("td[colspan=2]");
        assertNotNull(cell);
        assertEquals("Table narrative", cell.text());
    }

    @Test
    void removesActiveContentAndExternalNavigation() throws Exception {
        var html =
                Jsoup.parse(
                        renderer.render(
                                xml(
                                        """
                <paragraph><linkHtml href="https://example.com/secret">link</linkHtml></paragraph>
                <script>alert('bad')</script><iframe src="https://example.com"/>
                """)));
        assertTrue(html.select("script,iframe,object,embed,form,a[href]").isEmpty());
    }

    @Test
    void rejectsDoctypeAndExternalEntities() {
        byte[] input =
                ("<!DOCTYPE ClinicalDocument [<!ENTITY secret SYSTEM 'file:///etc/passwd'>]>"
                                + "<ClinicalDocument xmlns='urn:hl7-org:v3'><title>&secret;</title></ClinicalDocument>")
                        .getBytes(StandardCharsets.UTF_8);
        assertThrows(Exception.class, () -> renderer.render(input));
    }

    @Test
    void rejectsMalformedAndNonCdaXml() {
        for (String input :
                new String[] {"<", "<ClinicalDocument/>", "<other xmlns='urn:hl7-org:v3'/>"}) {
            assertThrows(
                    Exception.class, () -> renderer.render(input.getBytes(StandardCharsets.UTF_8)));
        }
    }

    private static byte[] xml(String narrative) {
        return ("""
                <ClinicalDocument xmlns="urn:hl7-org:v3">
                  <title>Home measurements</title>
                  <component><structuredBody><component><section><title>Results</title><text>
                """
                        + narrative
                        + "</text></section></component></structuredBody></component></ClinicalDocument>")
                .getBytes(StandardCharsets.UTF_8);
    }
}
