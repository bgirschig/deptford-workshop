class window.ImageParticle extends Particle
	@idCounter: 0
	@geometries: {}
	@maps: []
	constructor : (x,y,z) ->
		super(x,y,z,0xFFFF00)
		@particleReference = ImageParticle.idCounter++%dataJson.images.length
		
		data = dataJson.images[@particleReference]

		if(!ImageParticle.maps[@particleReference]?)
			ImageParticle.maps[@particleReference] = THREE.ImageUtils.loadTexture 'assets/objectImages/'+@particleReference+'.png';
		
		material = new THREE.MeshBasicMaterial({
		    map: ImageParticle.maps[@particleReference],
		    transparent: true
		})
		material.side = THREE.DoubleSide

		data = dataJson.images[@particleReference]
		geometry = ImageParticle.getGeometryFor(data.ratio)
		plane = new THREE.Mesh geometry, material
		plane.scale.x = data.size
		plane.scale.y = data.size*data.ratio

		@add plane
		plane.particleReference = @particleReference
		scene.clickable.push(plane)

		this.rotation.set Math.random()*10,Math.random()*10,Math.random()*10

	update: =>
		@updatePos()
		@rotation.y -= 0.0075

	@getGeometryFor: (ratio) ->
		discreteRatio = Math.round(ratio/Settings.ratioSimplification)
		if @geometries[discreteRatio]
			return @geometries[discreteRatio]
		else
			@geometries[discreteRatio] = new THREE.PlaneGeometry(1, 1)
			return @geometries[discreteRatio]









			