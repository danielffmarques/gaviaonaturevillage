// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

const BASE = '/gaviaonaturevillage';

/** @type {import('vite').Plugin} */
const rebasePublicAssets = {
  name: 'rebase-public-assets',
  /** @param {string} html */
  transformIndexHtml(html) {
    return html
      // Fix <img src="/images/..."> and <source srcset="/images/...">
      .replace(/(\s(?:src|srcset))="\/images\//g, `$1="${BASE}/images/`)
      // Fix inline style url(/images/...)
      .replace(/url\(["']?\/images\//g, `url("${BASE}/images/`)
      // Fix internal href="/..." links (skip already-prefixed and external)
      .replace(/\shref="\/([^"]*?)"/g, (/** @type {string} */ match, /** @type {string} */ path) => {
        if (path.startsWith('gaviaonaturevillage')) return match;
        return ` href="${BASE}/${path}"`;
      });
  },
};

// https://astro.build/config
export default defineConfig({
  integrations: [tailwind()],
  devToolbar: {
    enabled: false,
  },
  site: 'https://danielffmarques.github.io',
  base: BASE,
  trailingSlash: 'never',
  redirects: {
    '/programas': '/experiencias',
  },
  vite: {
    plugins: [rebasePublicAssets],
  },
});
