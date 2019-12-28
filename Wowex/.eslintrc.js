module.exports = {
  root: true,

  parser: "@typescript-eslint/parser",

  plugins: ["@typescript-eslint"],

  extends: [
    "plugin:@typescript-eslint/recommended",
    "prettier",
    "prettier/@typescript-eslint",
  ],

  env: {
    es6: true,
    node: true,
  },

  parserOptions: {
    sourceType: "module",
    ecmaVersion: 2018,
  },

  rules: {
    "@typescript-eslint/explicit-function-return-type": [
      "error",
      {
        allowExpressions: true,
      },
    ],
    camelcase: "off",
    "@typescript-eslint/camelcase": ["error", { allow: ["C_Timer"] }],
    "eqeqeq": ["error", "always"],
  },

  globals: {},
};
