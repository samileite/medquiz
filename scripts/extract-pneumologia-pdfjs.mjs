import fs from 'fs';
import * as pdfjsLib from 'pdfjs-dist/legacy/build/pdf.mjs';

async function extract() {
  const data = new Uint8Array(fs.readFileSync('./docs/pneumologia.pdf'));
  const loadingTask = pdfjsLib.getDocument({ data });
  const pdf = await loadingTask.promise;
  console.log('Pages:', pdf.numPages);
  for (let i = 1; i <= pdf.numPages; i++) {
    const page = await pdf.getPage(i);
    const content = await page.getTextContent();
    const strings = content.items.map(i => i.str || '').join(' ');
    console.log(`\n--- PAGE ${i} ---\n`);
    console.log(strings);
  }
}

extract().catch(err => { console.error('Error extracting PDF:', err); process.exit(1); });
