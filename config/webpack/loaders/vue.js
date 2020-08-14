
module.exports = {
  build: {
    publicPath: '/',
  },
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader',
  }]
}
