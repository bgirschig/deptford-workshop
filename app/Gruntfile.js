module.exports = function(grunt){

	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		watch: {
			options: {
				dateFormat: function(time) {
					grunt.log.writeln('grunt is waiting for updates...');
				},
			},
			copy:{
				files: ['source/*.html',
						'source/style.css',
						'../assets/objectImages/data.json',
						"../assets/_assets-update.txt",
						'source/cms/**'],
				tasks:['copy'],
				options:{
					livereload: true
				}
			},
			js: {
				files: ['source/coffee/*.coffee', 'source/coffee/classes/*.coffee'],
				tasks: ['coffee'],
				options: {
					livereload: true
				},
			},
			css: {
				files: ['source/styl/*.stylus'],
				tasks: ['stylus'],
				options: {
					livereload: true
				},
			}
		},
		stylus: {
			options: {
				compress: false,
				paths: ['Styl/*styl'],
			},
			compile: {
				files: {
					'../build/css/main.css' : 'source/styl/main.stylus',
				},
			},
		},
		coffee: {
			compile: {
				files: {
					'../build/script/classes.js' : 'source/coffee/classes/*.coffee',
					'../build/script/main.js' : 'source/coffee/*.coffee',
				},
			},
		},

		copy: {
		  main: {
		    files: [
		      {src: ['source/index.html'], dest: '../build/index.html', filter: 'isFile'},
		      {src: ['source/index2.html'], dest: '../build/index2.html', filter: 'isFile'},
		      {src: ['source/style.css'], dest: '../build/style.css', filter: 'isFile'},
		      {src: ['node_modules/three/three.min.js'], dest: '../build/script/librairies/three.min.js', filter: 'isFile'},
		      // {expand: true, cwd: '../assets/', src: ['**'], dest: '../build/assets/'},
		      {expand: true, cwd: 'source/librairies/', src: ['**'], dest: '../build/script/librairies/'},
		      {expand: true, cwd: 'source/cms/', src: ['**'], dest: '../build/cms/'},
		    ]
		  }
		}
	});

	grunt.loadNpmTasks('grunt-contrib-stylus');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-copy');

	grunt.registerTask('default', ['watch']);
};