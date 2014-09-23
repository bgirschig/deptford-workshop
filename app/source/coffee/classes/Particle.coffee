class window.Particle
	@zeroVector = new THREE.Vector3(0,0,0)

	constructor: (x,y,z) ->
		@position = new THREE.Vector3(x,y,z)
		@speed = new THREE.Vector3(0,0,0)
		@drag = new THREE.Vector3(0,0,0)
		@acceleration = new THREE.Vector3(0,0,0)
		
		Particle.randomisePos(@)

	updatePos: (element)=>
		d = @position.distanceTo Particle.zeroVector
		if d > Settings.deletionDistance || d < Settings.vitalSpace then @reposition()		

		# drag
		speedMag = @speed.length()
		dragMag = speedMag * speedMag * Settings.dragCoef
		@drag = @speed.clone()
		@drag.negate()
		@drag.setLength(dragMag)

		# applying forces
		@acceleration.add Settings.gravity
		@acceleration.add @drag

		# apply speed and acceleration
		@speed.add @acceleration		
		@position.add @speed

		# reset acceleration for next pass
		@acceleration.set(0,0,0)
	reposition: () =>
		Particle.randomisePos(@) #FIXME
		@position.y = - 30
		@speed.set(0,0,0)

	@randomisePos: (particle) ->
		length = Settings.vitalSpace + Math.random()*(Settings.outerDistance - Settings.vitalSpace)
		t = Math.random()*Math.PI*2 #tetha
		p = Math.random()*Math.PI*2 #phi
		particle.position.set(Math.sin(t)*Math.cos(p)*length, Math.sin(t)*Math.sin(p)*length-(Settings.outerDistance/2), Math.cos(t)*length)
		return null

