/* eslint-disable @typescript-eslint/no-var-requires */
const { fontFamily } = require('tailwindcss/defaultTheme');

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,jsx,ts,tsx,md,mdx}',
    './components/**/*.{js,jsx,ts,tsx,md,mdx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Montserrat', ...fontFamily.sans],
        mono: ['"Meslo LG S"', ...fontFamily.mono],
      },
      colors: {
        dark: {
          100: '#0c1110',
        },
        light: {
          100: '#cae2db',
        },
      },
      keyframes: {
        flicker: {
          '0%, 19.999%, 22%, 62.999%, 64%, 64.999%, 70%, 100%': {
            opacity: 0.99,
            filter:
              'drop-shadow(0 0 1px rgba(252, 211, 77)) drop-shadow(0 0 15px rgba(245, 158, 11)) drop-shadow(0 0 1px rgba(252, 211, 77))',
          },
          '20%, 21.999%, 63%, 63.999%, 65%, 69.999%': {
            opacity: 0.4,
            filter: 'none',
          },
        },
        shimmer: {
          '0%': {
            backgroundPosition: '-700px 0',
          },
          '100%': {
            backgroundPosition: '700px 0',
          },
        },
      },
      animation: {
        flicker: 'flicker 3s linear infinite',
        shimmer: 'shimmer 1.3s linear infinite',
      },
      spacing: {
        128: '32rem',
      },
    },
  },
  plugins: [require('@tailwindcss/typography'), require('daisyui')],
  daisyui: {
    themes: [
      // !STARTERCONF update colors
      {
        light: {
          primary: '#3dcea0',
          secondary: '#21936e',
          accent: '#9e9e9e',
          neutral: '#0c1110',
          'base-100': '#cae2db',
          info: '#37b3d2',
          success: '#36d399',
          warning: '#eebe44',
          error: '#db2b39',
          light: '#cae2db',
          dark: '#0c1110',

          '--rounded-box': '0.25rem',
          '--rounded-btn': '0.125rem',
          '--rounded-badge': '0.125rem',
          '--animation-btn': '0',
          '--animation-input': '0',
          '--btn-focus-scale': '1',
          '--tab-radius': '0',
        },
      },
      {
        dark: {
          primary: '#3dcea0',
          secondary: '#21936e',
          accent: '#9e9e9e',
          neutral: '#cae2db',
          'base-100': '#0c1110',
          info: '#37b3d2',
          success: '#36d399',
          warning: '#eebe44',
          error: '#db2b39',
          light: '#cae2db',
          dark: '#0c1110',

          '--rounded-box': '0.25rem',
          '--rounded-btn': '0.125rem',
          '--rounded-badge': '0.125rem',
          '--animation-btn': '0',
          '--animation-input': '0',
          '--btn-focus-scale': '1',
          '--tab-radius': '0',
        },
      },
    ],
  },
};
