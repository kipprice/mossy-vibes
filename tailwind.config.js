/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./app/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
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
      }
    },
  },
  plugins: [],
}

