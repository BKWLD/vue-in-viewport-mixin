// http://nightwatchjs.org/guide#settings-file
var TRAVIS_JOB_NUMBER = process.env.TRAVIS_JOB_NUMBER
module.exports = {
	'src_folders': ['test/e2e/specs'],
	'output_folder': 'test/e2e/reports',
	'custom_commands_path': ['node_modules/nightwatch-helpers/commands'],
	'custom_assertions_path': ['node_modules/nightwatch-helpers/assertions'],

	'selenium': {
		'start_process': true,
		'server_path': 'node_modules/selenium-server/lib/runner/selenium-server-standalone-2.53.1.jar',
		'host': '127.0.0.1',
		'port': 4444,
		'cli_args': {
			'webdriver.chrome.driver': 'node_modules/chromedriver/lib/chromedriver/chromedriver'
		}
	},

	'test_settings': {
		'default': {
			'selenium_port': 4444,
			'selenium_host': 'localhost',
			'silent': true,
			'screenshots': {
				'enabled': true,
				'on_failure': true,
				'on_error': false,
				'path': 'test/e2e/screenshots'
			},
			'desiredCapabilities': {
				'build': `build-${TRAVIS_JOB_NUMBER}`,
				'tunnel-identifier': TRAVIS_JOB_NUMBER,
			}
		},

		'chrome': {
			'desiredCapabilities': {
				'browserName': 'chrome',
				'javascriptEnabled': true,
				'acceptSslCerts': true
			}
		}

	}
}
