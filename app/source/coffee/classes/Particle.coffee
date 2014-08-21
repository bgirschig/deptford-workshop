class window.Particle extends THREE.Object3D
	@zeroVector = new THREE.Vector3(0,0,0)

	constructor: (x,y,z, debugColor) ->
		super
		Particle.randomisePos(@)

		@speed = new THREE.Vector3(0,0,0)
		@drag = new THREE.Vector3(0,0,0)
		@acceleration = new THREE.Vector3(0,0,0)
		if Settings.debug then @add Debugger.axes(1, debugColor)
	updatePos: =>
		if (@position.distanceTo(Particle.zeroVector)) > Settings.deletionDistance then @reposition()		

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
		@speed.set(0,0,0)

	@randomisePos: (particle) ->
		length = Settings.vitalSpace + Math.random()*(Settings.outerDistance - Settings.vitalSpace)
		t = Math.random()*Math.PI*2 #tetha
		p = Math.random()*Math.PI*2 #phi
		particle.position.set(Math.sin(t)*Math.cos(p)*length, Math.sin(t)*Math.sin(p)*length-(Settings.outerDistance/2), Math.cos(t)*length)
		return null

