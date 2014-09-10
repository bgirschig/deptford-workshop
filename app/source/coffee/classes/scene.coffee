class window.Scene
	constructor: () ->
		# 3d scene init
		@scene = new THREE.Scene()
		@camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 0.1, 1500 )
		try
			@renderer = new THREE.WebGLRenderer({ alpha: true })
			@threeOk = true

			@renderer.setSize( window.innerWidth, window.innerHeight )
			@renderer.domElement.className = "hide fullscreen"
			@renderer.domElement.id = "threeCanvas"
			document.body.appendChild( @renderer.domElement )
			@scene.fog = new THREE.FogExp2( Settings.fogColor, Settings.fogDensity )
			@displayed = false
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
		catch e
			alert("This website uses a whole bunch of webGl, but your browser does not seem to support it.\n Please note that this experience will not work on ios")
			@threeOk = false
			if(overlayHandler.floatMode) then overlayHandler.gotoSection 2
			else
				overlayHandler.gotoSection 5
				overlayHandler.gotoSection 2
	update: () =>
		if(scene.displayed)
			@particleSystem.update()

			# cam movements
			if @particleSystem.targetRotation
				@particleSystem.rotation.y += (@particleSystem.targetRotation-@particleSystem.rotation.y)/10
			
			@particleSystem.rotation.y += (mouse.x/window.innerWidth - 0.5)/30
			if Settings.unlockCamAxis then @particleSystem.rotation.x += (mouse.y/window.innerHeight - 0.5)/30

			@renderer.render @scene, @camera
		requestAnimationFrame @update
