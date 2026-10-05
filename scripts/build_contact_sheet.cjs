// scripts/build_contact_sheet.js
const fs = require('fs');
const path = require('path');

function getImages(dir) {
  if (!fs.existsSync(dir)) return [];
  return fs.readdirSync(dir)
    .filter(f => f.match(/\.(jpg|jpeg|png)$/i))
    .map(f => path.join(dir, f).replace(/\\/g, '/'));
}

const categories = {
  'Alojamentos (Cork Shelters & Glamping)': getImages('public/images/alojamentos'),
  'Geral & Vista Herdade': getImages('public/images/geral'),
  'Programas & Experiências': getImages('public/images/programas'),
  'Village (Piscina, Vinhas, Quinta)': getImages('public/images/village'),
  'Wellness (Spa, Sauna, Jacuzzi)': getImages('public/images/wellness'),
  'Experiências & Tejo': getImages('public/images/experiencias')
};

let html = `<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Curadoria Imagens Gavião Nature Village</title>
  <style>
    body { background: #141210; color: #FAF8F5; font-family: -apple-system, BlinkMacSystemFont, sans-serif; padding: 24px; }
    h1 { color: #E8D3A2; font-size: 24px; margin-bottom: 20px; }
    h2 { color: #C2A472; font-size: 16px; margin: 24px 0 12px 0; border-bottom: 1px solid #333; padding-bottom: 6px; }
    .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 16px; margin-bottom: 30px; }
    .card { background: #22201D; border: 1px solid #3A3632; border-radius: 8px; overflow: hidden; padding: 8px; }
    img { width: 100%; height: 160px; object-fit: cover; border-radius: 4px; display: block; }
    .meta { font-size: 11px; color: #AAA; margin-top: 6px; line-height: 1.4; }
    .meta strong { color: #FFF; }
  </style>
</head>
<body>
  <h1>Catálogo Fotográfico Completo · Gavião Nature Village</h1>
`;

for (const [cat, imgs] of Object.entries(categories)) {
  html += `<h2>${cat} (${imgs.length} fotos)</h2><div class="grid">`;
  imgs.forEach(img => {
    const webPath = '../' + img;
    const size = Math.round(fs.statSync(img).size / 1024);
    const fname = path.basename(img);
    html += `
      <div class="card">
        <img src="${webPath}" alt="${fname}" loading="lazy">
        <div class="meta">
          <strong>${fname}</strong><br>
          Tamanho: ${size} KB
        </div>
      </div>
    `;
  });
  html += `</div>`;
}

html += `</body></html>`;
fs.writeFileSync('docs/curadoria_imagens.html', html);
console.log('Created docs/curadoria_imagens.html with', Object.values(categories).flat().length, 'images.');
