import fs from 'fs';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const pdfLib = require('pdf-parse');
const pdf = pdfLib.default || pdfLib;

const dataBuffer = fs.readFileSync('./docs/pneumologia.pdf');

pdf(dataBuffer).then(function(data) {
  console.log('Pages:', data.numpages);
  console.log(data.text);
}).catch(err => {
  console.error('PDF parse error:', err);
});
