class window.ParticleSystem
	constructor : (@count, @soundCount) ->
		@particles = []
		setTimeout(@addParticle, 50)
			
		if Settings.debug then @add Debugger.axes(6, 0xFF00FF)
	update:()=>
		p.update() for p in @particles

	addParticle:()=>
		if @count > 0
			p = new ImageParticle()
			@particles.push p
			@count--
		if @soundCount > 0
			p = new SoundParticle()
			@particles.push p
			@soundCount--

		document.getElementById("loaderValue").innerHTML = @count

		if @count > 0 || @soundCount > 0 then setTimeout(@addParticle, 5)
		else if @count == 0 && @soundCount == 0 then overlayHandler.gotoSection(2)