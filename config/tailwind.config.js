const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        primary: {"50":"#e5eafc","100":"#c3d3fa","200":"#9db8f9","300":"#7ca3f8","400":"#5d8cf6","500":"#3d78f5","600":"#2661f2","700":"#1a45e4","800":"#1a37bf","900":"#193495","950":"#12226c"}
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        monoton: ['Monoton']
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
