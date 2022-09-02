module.exports = function({ config, mode }) {
  
  // Add to resolve extensions
  config.resolve.extensions.push('.coffee')
  
  // Add Coffeescript
  config.module.rules.push({
    test: /\.coffee$/,
    use: [
      'babel-loader',
      'coffee-loader'
    ]
  })
  
  return config
};
