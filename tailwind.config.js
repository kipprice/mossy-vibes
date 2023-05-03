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
        "Tea_green": "#c2efb3",
        "Cadet_gray": "#97abb1",
        "Dim_gray": "#746f72",
        "Coyote": "#735f3d",
        "Drab_dark_brown": "#594a26",
        "Maize": "#fff05a",
        "Sunglow": "#ffd25a",
        "Sandy_brown": "#ffaa5a",
        "Bittersweet": "#ff785a",
        "Pine_green": "#136F63"
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
          '42%': { transform: 'scale(1.4) rotate(180deg)' },
          '56%': { transform: 'scale(1.4) rotate(180deg)' },
          '100%': { transform: 'scale(0.8) rotate(360deg)' }
        },
        fade: {
          '0%': { opacity: 1 },
          '100%': { opacity: 0.3 }
        }
      },
      animation: {
        'breathe-10': 'breathe 10s ease-in-out infinite',
        'breathe-12': 'breathe 12s ease-in-out infinite',
        'breathe-18': 'breathe 18s ease-in-out infinite',
      }
    },
  },
  plugins: [],
}

