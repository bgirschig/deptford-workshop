class window.Scene
	constructor: () ->
		# 3d scene init
		@scene = new THREE.Scene()
		@camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 0.1, 1500 );
		@renderer = new THREE.WebGLRenderer({ alpha: true });
		@renderer.setSize( window.innerWidth, window.innerHeight )
		@renderer.setClearColor( Settings.bgColor, 0 );
		document.body.appendChild( @renderer.domElement )
		@scene.fog = new THREE.FogExp2( Settings.fogColor, Settings.fogDensity )

		# lighting
		@ambientLight = new THREE.AmbientLight(Settings.ambientLightColor)
		@scene.add(@ambientLight)

		# camera position
		if Settings.debug then @camera.position.z = Settings.camOffset else @camera.position.z = 0

		# array of clickable objects(planes, and not axes for example
		@clickable = [];

		# creating the particleSystem
		@particleSystem = new ParticleSystem(Settings.particlesCount, Settings.soundParticlesCount)
		@scene.add @particleSystem

		if Settings.skybox
			@skybox = createSkybox()
			@particleSystem.add @skybox
	update: () =>
		@particleSystem.update()

		# cam movements
		# @camera.rotation.x += (mouse.y/window.innerHeight - 0.5)/10
		if @particleSystem.targetRotation
			@particleSystem.rotation.y += (@particleSystem.targetRotation-@particleSystem.rotation.y)/10
		@particleSystem.rotation.y += (mouse.x/window.innerWidth - 0.5)/30
		# @particleSystem.rotation.x += (mouse.y/window.innerHeight - 0.5)/10
		# @camera.rotation.x += (mouse.y/window.innerHeight - 0.5)/5

		requestAnimationFrame @update
		# setTimeout @update, 500
		@renderer.render @scene, @camera
