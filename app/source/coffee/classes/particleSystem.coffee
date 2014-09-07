class window.ParticleSystem extends THREE.Object3D
	constructor : (@count, @soundCount) ->
		super
		@particles = []
		setTimeout(@addParticle, 50)
			
		if Settings.debug then @add Debugger.axes(6, 0xFF00FF)

	update:()=>
		p.update() for p in @particles

	addParticle:()=>
		if @count > 0
			p = new ImageParticle()
			@particles.push p
			@add p
			@count--
		if @soundCount > 0
			p = new SoundParticle()
			@add p
			@particles.push p
			@soundCount--

		document.getElementById("loaderValue").innerHTML = @count

		if @count > 0 || @soundCount > 0 then setTimeout(@addParticle, 5)
		else if @count == 0 && @soundCount == 0 then overlayHandler.gotoSection(2)