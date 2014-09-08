window.AudioContext = window.AudioContext || window.webkitAudioContext #fix up the prefixing

class window.SoundHandler
	@context = new AudioContext()
	@currentSounds = []
	@gainNode = @context.createGain()

	@createSound = (buffer) ->
		panner = @context.createPanner()
		panner.coneOuterGain = Settings.soundVolume
		panner.coneOuterAngle = 180
		panner.coneInnerAngle = 0
		panner.connect(@gainNode)

		@gainNode.connect(@context.destination)
		@gainNode.gain.value = 0

		source = @context.createBufferSource()
		source.buffer = buffer
		source.loop = true
		source.connect(panner)

		sound = {source:source, panner:panner}
		return sound