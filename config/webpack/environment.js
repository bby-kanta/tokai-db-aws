const { environment } = require('@rails/webpacker')

// 追記 (5/24)
const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        Popper: 'popper.js'  // (6/3にBootstrap用のpopper.js追加)
    })
)
// ここまで

module.exports = environment
