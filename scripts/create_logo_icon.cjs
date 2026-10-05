const fs = require('fs');
const sharp = require('sharp');

const svg = fs.readFileSync('public/images/branding/logo_gold.svg', 'utf8');
const iconSvg = svg
  .replace('viewBox="0 0 662 800"', 'viewBox="156 0 344 470"')
  .replace('width="662" height="800"', 'width="344" height="470"');

fs.writeFileSync('public/images/branding/logo_icon_gold.svg', iconSvg);
console.log('Saved public/images/branding/logo_icon_gold.svg');

sharp('public/images/branding/logo_icon_gold.svg')
  .png()
  .toFile('public/images/branding/logo_icon_trimmed.png')
  .then(() => console.log('Trimmed PNG created successfully!'));
