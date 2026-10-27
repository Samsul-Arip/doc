module.exports = [
  {
    files: ['**/*.js', '**/*.cjs'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'commonjs',
      globals: {
        document: 'readonly',
        LogicEngine: 'readonly',
        globalThis: 'readonly',
        module: 'readonly',
        require: 'readonly',
      },
    },
    rules: {
      'no-undef': 'error',
      'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
      eqeqeq: 'error',
    },
  },
];
