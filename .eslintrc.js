module.exports = {
  root: true,

  parser: "@typescript-eslint/parser",

  plugins: ["@typescript-eslint"],

  extends: [
    "plugin:@typescript-eslint/recommended",
    "plugin:react/recommended",
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
    "react/react-in-jsx-scope": "off",
    "@typescript-eslint/explicit-function-return-type": [
      "warn",
      {
        allowExpressions: true,
      },
    ],
    camelcase: "off",
    "@typescript-eslint/camelcase": [
      "error",
      { allow: ["C_Timer", "C_LossOfControl", "C_Map"] },
    ],
    "@typescript-eslint/interface-name-prefix": "off",
    eqeqeq: ["error", "always"],
  },

  globals: {},
};
