const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

async function processImage(inputPath, outputWebp, outputJpg, options = {}) {
  const {
    saturation = 1.06,
    brightness = 1.02,
    sharpSigma = 1.0,
    sharpM1 = 0.7,
    sharpM2 = 2.0,
    quality = 82,
    width = 1600,
    height = 1067
  } = options;

  console.log(`Processing ${inputPath} -> ${outputWebp}...`);

  // Pipeline with Sharp
  const pipeline = sharp(inputPath)
    .resize(width, height, {
      fit: 'cover',
      position: 'center',
      kernel: sharp.kernel.lanczos3
    })
    .modulate({
      saturation: saturation,
      brightness: brightness
    })
    .sharpen({
      sigma: sharpSigma,
      m1: sharpM1,
      m2: sharpM2
    });

  // Export WebP
  await pipeline
    .clone()
    .webp({
      quality: quality,
      effort: 6,
      smartSubsample: true
    })
    .toFile(outputWebp);

  // Export JPG fallback
  await pipeline
    .clone()
    .jpeg({
      quality: quality,
      mozjpeg: true,
      trellisQuantisation: true,
      overshootDeringing: true
    })
    .toFile(outputJpg);

  const statWebp = fs.statSync(outputWebp);
  const statJpg = fs.statSync(outputJpg);
  console.log(`  Done: WebP = ${(statWebp.size / 1024).toFixed(1)} KB | JPG = ${(statJpg.size / 1024).toFixed(1)} KB`);
}

async function run() {
  const outputDir = path.resolve('public/images/hero');

  // 1. Casais & Romance (Glamping tent under cork oak at sunset)
  await processImage(
    'public/images/alojamentos/media_26_Gavi_o.jpg',
    path.join(outputDir, 'hero_casais.webp'),
    path.join(outputDir, 'hero_casais.jpg'),
    { saturation: 1.07, brightness: 1.02, sharpSigma: 0.8, sharpM1: 0.5, quality: 78, width: 1360, height: 906 }
  );

  // 2. Famílias & Natureza (Village pond & glamping domes at sunset)
  await processImage(
    'public/images/village/media_34_Gavi_o.jpg',
    path.join(outputDir, 'hero_familias.webp'),
    path.join(outputDir, 'hero_familias.jpg'),
    { saturation: 1.06, brightness: 1.02, sharpSigma: 0.6, sharpM1: 0.4, quality: 68, width: 1360, height: 906 }
  );

  // 3. Bem-Estar & Retiro (Tranquil Sunset Infinity Pool)
  await processImage(
    'public/images/village/media_15_Gavi_o.jpg',
    path.join(outputDir, 'hero_wellness.webp'),
    path.join(outputDir, 'hero_wellness.jpg'),
    { saturation: 1.06, brightness: 1.02, sharpSigma: 0.7, sharpM1: 0.5, quality: 74, width: 1360, height: 906 }
  );

  // 4. Aventura & Ecoturismo (Passadiços do Alamal & Rio Tejo)
  await processImage(
    'public/images/programas/media_68_Gavi_o.jpg',
    path.join(outputDir, 'hero_aventura.webp'),
    path.join(outputDir, 'hero_aventura.jpg'),
    { saturation: 1.07, brightness: 1.02, sharpSigma: 0.6, sharpM1: 0.4, quality: 66, width: 1360, height: 906 }
  );

  // 5. Default Resort Panorama (Belver Castle & Alto Alentejo Nature)
  await processImage(
    'public/images/geral/media_5_Gavi_o.jpg',
    path.join(outputDir, 'hero_village.webp'),
    path.join(outputDir, 'hero_village.jpg'),
    { saturation: 1.05, brightness: 1.02, sharpSigma: 0.6, sharpM1: 0.4, quality: 70, width: 1360, height: 906 }
  );

  console.log('All hero images successfully created and optimized!');
}

run().catch(console.error);
