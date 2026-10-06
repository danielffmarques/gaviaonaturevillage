// fix-base-paths.mjs
// Post-build script: rewrites all absolute /... paths in the generated HTML
// files to include the GitHub Pages sub-path /gaviaonaturevillage.
// This runs after `astro build` so it doesn't require touching any component.

import { readFileSync, writeFileSync, readdirSync, statSync } from 'fs';
import { join, extname } from 'path';

const BASE = '/gaviaonaturevillage';
const DIST = './dist';

/** Recursively collect all .html files under a directory */
function collectHtml(dir) {
  const entries = readdirSync(dir);
  const files = [];
  for (const entry of entries) {
    const full = join(dir, entry);
    if (statSync(full).isDirectory()) {
      files.push(...collectHtml(full));
    } else if (extname(entry) === '.html') {
      files.push(full);
    }
  }
  return files;
}

function fixHtml(html) {
  return html
    // ── CSS / JS assets injected by Astro/Vite (/_astro/...) ────────────────
    .replace(/(\s(?:href|src))="\/_astro\//g, `$1="${BASE}/_astro/`)

    // ── <img src="/images/..."> and <source srcset="/images/..."> ────────────
    .replace(/(\s(?:src|srcset))="\/images\//g, `$1="${BASE}/images/`)

    // ── meta content="/images/..." (og:image, twitter:image, etc.) ───────────
    .replace(/(\scontent)="\/images\//g, `$1="${BASE}/images/`)

    // ── favicon / other public root assets ──────────────────────────────────
    .replace(/(\shref)="\/favicon\.ico"/g, `$1="${BASE}/favicon.ico"`)
    .replace(/(\shref)="\/favicon\.svg"/g, `$1="${BASE}/favicon.svg"`)
    .replace(/(\shref)="\/logo\.svg"/g, `$1="${BASE}/logo.svg"`)

    // ── inline background-image: url("/images/...") in <style> tags ─────────
    .replace(/url\(["']?\/images\//g, `url("${BASE}/images/`)

    // ── JavaScript string literals with /images/ (e.g. in data objects) ─────
    .replace(/(["'`])\/images\//g, `$1${BASE}/images/`)

    // ── internal navigation href="/..." and form action="/..." links ─────────
    // Skip: external (http/https), already prefixed, anchor-only (#)
    .replace(/(\s(?:href|action)=")\/([^"]*?)"/g, (match, prefix, path) => {
      if (path.startsWith('gaviaonaturevillage')) return match; // already fixed
      if (path.startsWith('/')) return match;                   // protocol-relative
      return `${prefix}${BASE}/${path}"`;
    });
}

const htmlFiles = collectHtml(DIST);
let count = 0;

for (const file of htmlFiles) {
  const original = readFileSync(file, 'utf8');
  const fixed = fixHtml(original);
  if (fixed !== original) {
    writeFileSync(file, fixed, 'utf8');
    count++;
  }
}

console.log(`✓ Fixed base paths in ${count} of ${htmlFiles.length} HTML files.`);
