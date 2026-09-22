import {defineConfig} from '@playwright/test';
export default defineConfig({
  testDir: './tests',
  outputDir: './target/itb-ui-test-results',
  reporter: [['list'], ['junit', {outputFile: './target/itb-ui-junit.xml'}]],
  use: {browserName: 'chromium', headless: true},
});
