window.AudioContext = window.AudioContext || window.webkitAudioContext #fix up the prefixing

class window.SoundHandler
	@context = new AudioContext()
	@currentSounds = []

	@createSound = (buffer) ->
		panner = @context.createPanner()
		panner.coneOuterGain = Settings.soundVolume
		panner.coneOuterAngle = 180
		panner.coneInnerAngle = 0
		panner.connect(@context.destination)

		source = @context.createBufferSource()
		source.buffer = buffer
		source.loop = true
		source.connect(panner)

		sound = {source:source, panner:panner}
		return sound