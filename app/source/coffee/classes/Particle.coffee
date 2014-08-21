class window.Particle extends THREE.Object3D
	@environmentForce = new THREE.Vector3(0,0,0)
	@zeroVector = new THREE.Vector3(0,0,0)

	constructor: (x,y,z, debugColor) ->
		super
		@position.copy(Particle.getRandomVector())

		@speed = new THREE.Vector3(0,0,0)
		@drag = new THREE.Vector3(0,0,0)
		@acceleration = new THREE.Vector3(0,0,0)
		if Settings.debug then @add Debugger.axes(1, debugColor)
	updatePos: =>
		if (@position.distanceTo(Particle.zeroVector)) > Settings.deletionDistance then @reposition()		
		
		# get the 'environment force'
		# force = new THREE.Vector3((Math.random()-0.5)/100000, (Math.random()-0.2)/100000, (Math.random()-0.5)/100000)
		angle = noiseGenerator.noise3d(@position.x/Settings.noiseSize,@position.y/Settings.noiseSize, @position.z/Settings.noiseSize) * Math.PI
		Particle.environmentForce.set(Math.sin(angle)*Settings.environmentInfluence, 0, Math.cos(angle)*Settings.environmentInfluence)

		# drag
		speedMag = @speed.length()
		dragMag = speedMag * speedMag * Settings.dragCoef
		@drag = @speed.clone()
		@drag.negate()
		@drag.setLength(dragMag)

		# applying forces
		@acceleration.add Particle.environmentForce
		@acceleration.add Settings.gravity
		@acceleration.add @drag

		# apply speed and acceleration
		@speed.add @acceleration		
		@position.add @speed

		# reset acceleration for next pass
		@acceleration.set(0,0,0)

	reposition: () =>
		@position.copy(Particle.getRandomVector()) #FIXME
		@speed.set(0,0,0)

	@getRandomVector: (_length) ->
		length = _length ? Settings.vitalSpace + Math.random()*(Settings.outerDistance - Settings.vitalSpace)
		t = Math.random()*Math.PI*2 #tetha
		p = Math.random()*Math.PI*2 #phi
		return new THREE.Vector3(Math.sin(t)*Math.cos(p)*length, Math.sin(t)*Math.sin(p)*length-(Settings.outerDistance/2), Math.cos(t)*length)

