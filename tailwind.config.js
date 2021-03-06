module.exports = {
  theme: {},
  variants: {},
  plugins: [require("@tailwindcss/typography"), require("daisyui")],
  // daisyUI config (optional)
  daisyui: {
    styled: true,
    themes: true,
    base: true,
    utils: true,
    logs: true,
    rtl: false,
    prefix: "",
    darkTheme: "dark",
    themes: [
      "light",
      "dark",
      "cupcake",
      "emerald",
      "corporate",
      "synthwave",
      "valentine",
      "halloween",
      "garden",
      "aqua",
      "pastel",
      "fantasy",
      "wireframe",
      "luxury",
      "business",
      "acid",
      "lemonade",
      "night",
      "coffee",
      "winter",
    ],
  },
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
};
