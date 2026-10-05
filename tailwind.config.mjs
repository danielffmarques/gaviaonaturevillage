/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        natureGold: {
          DEFAULT: '#C2A472',
          dark: '#B58C30',
          light: '#E6D8BF',
          50: '#FBF9F5',
          100: '#F5EFE6',
        },
        charcoal: {
          DEFAULT: '#474242',
          dark: '#132223',
          muted: '#6E6666',
          light: '#8C827A',
        },
        sand: {
          bg: '#F3F3F3',
          warm: '#FAF7F2',
          card: '#FFFFFF',
          border: '#E8E1D5',
        },
        forestGreen: {
          DEFAULT: '#3A4D39',
          dark: '#273526',
          light: '#E8EFE8',
        }
      },
      fontFamily: {
        catamaran: ['Catamaran', 'sans-serif'],
        montserrat: ['Montserrat', 'sans-serif'],
        playfair: ['Playfair Display', 'serif'],
      },
      boxShadow: {
        'soft': '0 4px 20px -2px rgba(71, 66, 66, 0.06)',
        'luxury': '0 12px 35px -4px rgba(194, 164, 114, 0.15)',
        'dropdown': '0 10px 40px -5px rgba(0, 0, 0, 0.12)',
      }
    },
  },
  plugins: [],
};
