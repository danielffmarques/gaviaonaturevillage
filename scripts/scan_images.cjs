const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

async function scan() {
  const dirs = ['alojamentos', 'experiencias', 'geral', 'hero', 'programas', 'restaurante', 'village', 'wellness'];
  for (const d of dirs) {
    const dirPath = path.join('public/images', d);
    if (!fs.existsSync(dirPath)) continue;
    const files = fs.readdirSync(dirPath).filter(f => f.endsWith('.jpg') || f.endsWith('.png') || f.endsWith('.webp'));
    console.log('--- ' + d + ' (' + files.length + ' images) ---');
    for (const f of files) {
      const fp = path.join(dirPath, f);
      try {
        const meta = await sharp(fp).metadata();
        const stat = fs.statSync(fp);
        console.log('  ' + f + ' : ' + meta.width + 'x' + meta.height + ' (' + Math.round(stat.size / 1024) + ' KB)');
      } catch (e) {
        console.log('  ' + f + ' : error reading metadata');
      }
    }
  }
}
scan();
