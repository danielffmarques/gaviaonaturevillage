// scripts/optimize_assets.cjs
const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

const targetImages = [
  {
    key: 'hero_village',
    src: 'public/images/geral/media_5_Gavi_o.jpg',
    label: 'Vista Panorâmica da Herdade & Castelo de Belver'
  },
  {
    key: 'hero_casais',
    src: 'public/images/alojamentos/media_10_Gavi_o.jpg',
    label: 'Cork Shelters ao Pôr do Sol (Casais & Romance)'
  },
  {
    key: 'hero_familias',
    src: 'public/images/alojamentos/media_26_Gavi_o.jpg',
    label: 'Glamping Familiar no Olival (Famílias & Natureza)'
  },
  {
    key: 'hero_wellness',
    src: 'public/images/wellness/media_37_Gavi_o.jpg',
    label: 'Piscina Hidroterapia & Sauna (Bem-Estar & Retiro)'
  },
  {
    key: 'hero_aventura',
    src: 'public/images/experiencias/media_119_Gavi_o.jpg',
    label: 'Rio Tejo, Passadiços & Arribas (Aventura & Ecoturismo)'
  }
];

const outDir = 'public/images/hero';
if (!fs.existsSync(outDir)) {
  fs.mkdirSync(outDir, { recursive: true });
}

async function run() {
  console.log('=== PROCESSAMENTO FOTOGRÁFICO DE ALTA FIDELIDADE ===\n');
  const report = [];

  for (const item of targetImages) {
    if (!fs.existsSync(item.src)) {
      console.error('File not found:', item.src);
      continue;
    }

    const origStat = fs.statSync(item.src);
    const meta = await sharp(item.src).metadata();

    // 1. Processamento de Alta Nitidez & Grading
    // Redimensionamento inteligente com Lanczos3 caso exceda 1920px
    const pipeline = sharp(item.src)
      .resize({
        width: Math.min(meta.width, 1920),
        withoutEnlargement: true,
        kernel: sharp.kernel.lanczos3
      })
      .modulate({
        brightness: 1.02,
        saturation: 1.07
      })
      .sharpen({
        sigma: 0.85,
        m1: 0.45,
        m2: 1.6
      });

    // 2. Exportação WebP Ultra-Otimizado (Qualidade Visual Brutal com Menor Peso)
    const webpPath = path.join(outDir, `${item.key}.webp`);
    await pipeline
      .clone()
      .webp({
        quality: 76,
        effort: 6,
        smartSubsample: true
      })
      .toFile(webpPath);
    const webpStat = fs.statSync(webpPath);

    // 3. Exportação JPG de Alta Resolução Otimizado com Mozjpeg
    const jpgPath = path.join(outDir, `${item.key}.jpg`);
    await pipeline
      .clone()
      .jpeg({
        quality: 82,
        progressive: true,
        mozjpeg: true
      })
      .toFile(jpgPath);
    const jpgStat = fs.statSync(jpgPath);

    report.push({
      key: item.key,
      label: item.label,
      dimensions: `${Math.min(meta.width, 1920)}x${Math.round(meta.height * (Math.min(meta.width, 1920)/meta.width))}`,
      origKb: Math.round(origStat.size / 1024),
      webpKb: Math.round(webpStat.size / 1024),
      jpgKb: Math.round(jpgStat.size / 1024),
      savedWebp: ((1 - webpStat.size / origStat.size) * 100).toFixed(1) + '%'
    });
  }

  console.table(report);
  console.log('\nTodas as 5 fotografias de Hero foram processadas e salvas em: ' + outDir);
}

run();
