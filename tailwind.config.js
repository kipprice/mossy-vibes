/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./app/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      fontSize: {
        title: '3rem',
        subtitle: '1.5rem',
        body: '1rem',
        aside: '0.8rem'
      },
      width: {
        vw_50: '50vw',
        vw_25: '25vw',
        vh_50: '50vh',
        vh_25: '25vh',
      },
      height: {
        vw_50: '50vw',
        vw_25: '25vw',
        vh_50: '50vh',
        vh_25: '25vh',
      },
      colors: {
        'yellow': '#FFD25A',
        'orange-light': '#FFAA5A',
        'orange-dark': '#FF785A',
        'green-dark': '#136F63',
        'green-light': '#C2E1B8',
        'brown-dark': '#312924',
        'brown-med': '#594226',
        'brown-light': '#B09668',
        'grey': '#746F72',
        'off-white': '#F6F0E4',
        'off-black': '#232220'
      },
      backgroundImage: {
        'paper': 'url("/img/ep_naturalwhite.png")'
      },
      fontFamily: {
        'sans': ['Quicksand', 'sans-serif']
      },
      fontWeight: {
        'light': '300',
        'base': '500',
        'bold': '700'
      },
      keyframes: {
        breathe: {
          '0%': { transform: 'scale(0.8) rotate(0deg)' },
          '21%': { transform: 'scale(1.4) rotate(120deg)' },
          '58%': { transform: 'scale(1.4) rotate(240deg)' },
          '100%': { transform: 'scale(0.8) rotate(360deg)' }
        },
        fade: {
          '0%': { opacity: 1 },
          '100%': { opacity: 0.3 }
        }
      },
      animation: {
        'breathe': 'breathe 19s ease infinite',
      }
    },
  },
  plugins: [],
}

