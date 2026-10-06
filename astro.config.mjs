// @ts-check
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

// https://astro.build/config
export default defineConfig({
  integrations: [tailwind()],
  devToolbar: {
    enabled: false,
  },
  site: 'https://danielffmarques.github.io',
  base: '/gaviaonaturevillage',
  trailingSlash: 'never',
  redirects: {
    '/programas': '/experiencias',
  },
});
