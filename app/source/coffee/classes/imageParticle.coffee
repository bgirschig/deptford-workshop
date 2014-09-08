class window.ImageParticle extends Particle
	@idCounter: 0
	@geometries: new THREE.PlaneGeometry(1, 1)
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
		plane = new THREE.Mesh ImageParticle.geometries, material
		# plane = new THREE.Mesh ImageParticle.geometries, new THREE.MeshBasicMaterial({color: 'red'})
		plane.scale.x = data.size
		plane.scale.y = data.size*data.ratio

		@add plane
		plane.particleReference = @particleReference
		scene.clickable.push(plane)

		this.rotation.set Math.random()*10,Math.random()*10,Math.random()*10

	update: =>
		@updatePos()
		@rotation.y -= 0.0075





			