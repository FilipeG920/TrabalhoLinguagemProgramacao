const { chromium } = require('playwright-chromium');
const path = require('path');

const dir = __dirname;
const jobs = [
  ['roteiro-apresentacao-nota-maxima.html', 'roteiro-apresentacao-nota-maxima.pdf'],
  ['explicacao-c-imperativo.html', 'explicacao-c-imperativo.pdf'],
  ['explicacao-java-oo.html', 'explicacao-java-oo.pdf'],
  ['explicacao-haskell-funcional.html', 'explicacao-haskell-funcional.pdf'],
  ['explicacao-prolog-logico.html', 'explicacao-prolog-logico.pdf'],
];

(async () => {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();
  for (const [html, pdf] of jobs) {
    const url = 'file://' + path.join(dir, html);
    await page.goto(url, { waitUntil: 'networkidle' });
    await page.pdf({
      path: path.join(dir, pdf),
      format: 'A4',
      printBackground: true,
      preferCSSPageSize: true,
      displayHeaderFooter: true,
      headerTemplate: '<div></div>',
      footerTemplate: '<div style="font-family:Arial,sans-serif;font-size:8px;color:#64748b;width:100%;padding:0 14mm;text-align:right;">Página <span class="pageNumber"></span> de <span class="totalPages"></span></div>',
      margin: { top: '0mm', right: '0mm', bottom: '8mm', left: '0mm' },
    });
    console.log(`exported ${pdf}`);
  }
  await browser.close();
})().catch(err => {
  console.error(err);
  process.exit(1);
});
