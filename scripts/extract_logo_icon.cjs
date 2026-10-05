const fs = require('fs');

const svg = fs.readFileSync('public/images/branding/logo_gold.svg', 'utf8');
const d = svg.slice(svg.indexOf(' d="') + 4, svg.lastIndexOf('"'));
console.log('d length:', d.length);

// Let's split on "m" or "M"
const chunks = [];
let lastIdx = 0;
for (let i = 1; i < d.length; i++) {
  if ((d[i] === 'm' || d[i] === 'M') && (d[i-1] === 'z' || d[i-1] === ' ' || d[i-1] === '\n')) {
    chunks.push(d.slice(lastIdx, i));
    lastIdx = i;
  }
}
chunks.push(d.slice(lastIdx));
console.log('Chunks found:', chunks.length);

chunks.forEach((chunk, i) => {
  console.log(`Chunk ${i}: length ${chunk.length}, starts with: ${chunk.slice(0, 30)}`);
});
