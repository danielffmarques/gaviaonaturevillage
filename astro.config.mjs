// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

const BASE = '/gaviaonaturevillage';

/**
 * Vite plugin that fixes all absolute public asset paths and internal
 * navigation links in the generated HTML to include the GitHub Pages sub-path.
 * This avoids having to manually update every src/href in every component.
 */
const rebasePublicAssets = {
  name: 'rebase-public-assets',
  transformIndexHtml: {
    order: 'post',
    handler(html) {
      return html
        // Fix <img src="/images/..."> and <source srcset="/images/...">
        .replace(/(\s(?:src|srcset))="\/images\//g, `$1="${BASE}/images/`)
        // Fix inline style url(/images/...)
        .replace(/url\(["']?\/images\//g, `url("${BASE}/images/`)
        // Fix internal href="/..." links (skip external, skip already-prefixed)
        .replace(/\shref="\/([^"]*?)"/g, (match, path) => {
          if (path.startsWith('gaviaonaturevillage')) return match;
          return ` href="${BASE}/${path}"`;
        });
    },
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
