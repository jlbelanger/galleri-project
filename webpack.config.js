const BrowserSyncPlugin = require('browser-sync-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const path = require('path');
const TerserPlugin = require('terser-webpack-plugin');
const { WebpackManifestPlugin } = require('webpack-manifest-plugin');

require('dotenv').config();

module.exports = {
	mode: 'production',
	devtool: false,
	entry: {
		galleri: './index.js',
	},
	output: {
		chunkLoadingGlobal: 'app',
		filename: 'js/[name].min.js?[contenthash]',
		path: path.resolve(__dirname, 'build'),
		publicPath: '/',
	},
	plugins: [
		new MiniCssExtractPlugin({
			filename: 'css/[name].min.css?[contenthash]',
		}),
		new WebpackManifestPlugin({
			map: (f) => {
				if (!f.path.includes('?')) {
					f.name = '';
					f.path = '';
				} else {
					f.name = f.path.replace(/\?.+$/, '');
				}
				return f;
			},
			fileName: 'manifest.json',
		}),
		new CopyPlugin({
			patterns: [
				{
					from: './public',
					to: './',
					globOptions: {
						ignore: ['.DS_Store', '**/.DS_Store'],
					},
				},
			],
			options: {
				concurrency: 100,
			},
		}),
		new BrowserSyncPlugin({
			proxy: process.env.APP_URL,
			port: 3000,
			files: [
				'includes/**/*',
				'js/**/*',
				'public/**/*',
				'scss/**/*',
			],
			snippetOptions: {
				rule: {
					match: /<body[^>]*>/i,
					fn: (snippet, match) => (
						// Allow Browsersync to work with Content-Security-Policy without script-src 'unsafe-inline'.
						`${match}${snippet.replace('id=', 'nonce="browser-sync" id=')}`
					),
				},
			},
		}, {
			reload: false,
		}),
	],
	module: {
		rules: [
			{
				test: /\.js$/,
				exclude: /node_modules/,
				use: ['babel-loader'],
			},
			{
				test: /\.scss$/,
				use: [
					MiniCssExtractPlugin.loader,
					{
						loader: 'css-loader',
						options: {
							url: false,
						},
					},
					{
						loader: 'postcss-loader',
						options: {
							postcssOptions: {
								plugins: [
									'autoprefixer',
									{
										cssnano: {
											// Disable postcss-calc to avoid warnings about calc() inside hsl().
											// https://github.com/postcss/postcss-calc/issues/216
											preset: ['default', { calc: false }],
										},
									},
									'postcss-preset-env',
								],
							},
						},
					},
					'sass-loader',
				],
			},
		],
	},
	optimization: {
		minimizer: [
			new TerserPlugin({
				extractComments: false,
			}),
		],
		splitChunks: {
			cacheGroups: {
				style: {
					name: 'style',
					type: 'css/mini-extract',
					chunks: 'all',
					enforce: true,
				},
			},
		},
	},
};
