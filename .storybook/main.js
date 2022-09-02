module.exports = {
    addons: [
        '@storybook/addon-knobs'
    ],
    core: {
        builder: 'webpack5',
    },
    features: {
        postcss: false,
    },
    framework: "@storybook/vue3",
    stories: ['../**/*.stories.@(js|jsx|ts|tsx)'],
  }