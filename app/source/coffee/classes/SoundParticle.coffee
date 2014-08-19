class window.SoundParticle extends Particle
	@idCounter: 0
	constructor : (x,y,z) ->
		super(x,y,z,0x35A4E4)
		@particleReference = SoundParticle.idCounter++%dataJson.sounds.length
		@playing = false

		request = new XMLHttpRequest()
		request.open('GET', "assets/sounds/"+@particleReference+".mp3", true)
		request.responseType = 'arraybuffer'
		request.onload = @onload
		request.send()

	onload: (e) =>
		if e.target.readyState == 4 && e.target.status == 200
			try
				SoundHandler.context.decodeAudioData(e.target.response, @onDecode, @onError)
			catch e
				console.log "error while reading sound file"

		else if e.target.readyState == 4
			console.log "error: sound file probably missing"

		# SoundHandler.context.decodeAudioData(@response, SoundHandler.onDecode, SoundHandler.onError)
	onDecode: (e) =>
		@soundBuffer = e
		@sound = SoundHandler.createSound(@soundBuffer)
		@sound.source.start(0)
		console.log @sound.source

	update: =>
		pos = new THREE.Vector3();
		pos.setFromMatrixPosition(@matrixWorld)
		if @sound then @sound.panner.setPosition(pos.x*Settings.soundPropagation, pos.z*Settings.soundPropagation ,pos.y*Settings.soundPropagation)
		@updatePos()

	onError: (e) =>
		console.log "an error occured while decoding a sound"