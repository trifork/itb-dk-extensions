import {defineConfig} from '@playwright/test';
export default defineConfig({
  testDir: './tests',
  outputDir: './target/itb-ui-test-results',
  reporter: [['list'], ['junit', {outputFile: './target/itb-ui-junit.xml'}]],
  // Traces record request bodies, including the throwaway CI test user's login, so keep them
  // to CI runs (disposable stack) and out of local runs that use saved real credentials.
  use: {
    browserName: 'chromium',
    headless: true,
    trace: process.env.CI ? 'retain-on-failure' : 'off',
    screenshot: 'only-on-failure',
  },
});
