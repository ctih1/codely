/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/codely_web/**/*.*ex"  // LiveView templates
  ],
  theme: {
    extend: {},
  },
  plugins: []
}