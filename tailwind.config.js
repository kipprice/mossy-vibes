/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      fontSize: {
        title: '3rem',
        subtitle: '1.5rem',
        body: '1rem',
        aside: '0.8rem'
      },
      width: {
        '50vw': '50vw',
        '25vw': '25vw',
        '50vh': '50vh',
        '25vh': '25vh',
        '10vh': '10vh'
      },
      height: {
        '50vw': '50vw',
        '25vw': '25vw',
        '50vh': '50vh',
        '25vh': '25vh',
        '10vh': '10vh'
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
        'breath-standard': {
          '0%': { transform: 'scale(0.8) rotate(0deg)' },
          '21%': { transform: 'scale(1.4) rotate(120deg)' },
          '58%': { transform: 'scale(1.4) rotate(240deg)' },
          '100%': { transform: 'scale(0.8) rotate(360deg)' }
        },
        'breath-quick': {
          '0%': { transform: 'scale(0.8) rotate(0deg)' },
          '33%': { transform: 'scale(1.4) rotate(120deg)' },
          '66%': { transform: 'scale(1.4) rotate(240deg)' },
          '100%': { transform: 'scale(0.8) rotate(360deg)' }
        },
        'breath-long': {
          '0%': { transform: 'scale(0.8) rotate(0deg)' },
          '27%': { transform: 'scale(1.4) rotate(120deg)' },
          '60%': { transform: 'scale(1.4) rotate(240deg)' },
          '100%': { transform: 'scale(0.8) rotate(360deg)' }
        },
        fade: {
          '0%': { opacity: 1 },
          '100%': { opacity: 0.3 }
        }
      },
      animation: {
        'breath-standard': 'breath-standard 19s linear infinite',
        'breath-quick': 'breath-quick 12s linear infinite',
        'breath-long': 'breath-long 30s linear infinite'
      },
      flexGrow: {
        2: '2'
      }
    },
  },
  plugins: [],
}
