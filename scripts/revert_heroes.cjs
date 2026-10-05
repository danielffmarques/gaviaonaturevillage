const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

async function revert() {
  const mapping = [
    {
      source: 'public/images/alojamentos/media_10_Gavi_o.jpg',
      targetWebp: 'public/images/hero/hero_casais.webp',
      targetJpg: 'public/images/hero/hero_casais.jpg'
    },
    {
      source: 'public/images/alojamentos/media_26_Gavi_o.jpg',
      targetWebp: 'public/images/hero/hero_familias.webp',
      targetJpg: 'public/images/hero/hero_familias.jpg'
    },
    {
      source: 'public/images/wellness/media_37_Gavi_o.jpg',
      targetWebp: 'public/images/hero/hero_wellness.webp',
      targetJpg: 'public/images/hero/hero_wellness.jpg'
    },
    {
      source: 'public/images/experiencias/media_119_Gavi_o.jpg',
      targetWebp: 'public/images/hero/hero_aventura.webp',
      targetJpg: 'public/images/hero/hero_aventura.jpg'
    },
    {
      source: 'public/images/geral/media_5_Gavi_o.jpg',
      targetWebp: 'public/images/hero/hero_village.webp',
      targetJpg: 'public/images/hero/hero_village.jpg'
    }
  ];

  for (const item of mapping) {
    console.log(`Reverting ${item.source} -> ${item.targetWebp}...`);
    // Copy the original jpg directly
    fs.copyFileSync(item.source, item.targetJpg);
    
    // Generate webp from the original
    await sharp(item.source)
      .webp({ quality: 85 })
      .toFile(item.targetWebp);

    console.log(`  Done: ${item.targetWebp}`);
  }

  console.log('Revert complete! Previous hero images successfully restored.');
}

revert().catch(console.error);
