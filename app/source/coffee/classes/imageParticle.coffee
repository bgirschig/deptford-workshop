class window.ImageParticle extends Particle
	@idCounter: 0
	@geometries: new THREE.PlaneGeometry(1, 1)
	@maps: []
	constructor : (x,y,z) ->
		super(x,y,z,0xFFFF00)
		@particleReference = ImageParticle.idCounter++%dataJson.images.length
		
		if(!ImageParticle.maps[@particleReference]?)
			ImageParticle.maps[@particleReference] = THREE.ImageUtils.loadTexture 'assets/objectImages/'+@particleReference+'.png';
		
		material = new THREE.MeshBasicMaterial({
		    map: ImageParticle.maps[@particleReference],
		    transparent: true
		})
		material.side = THREE.DoubleSide

		@plane = new THREE.Mesh ImageParticle.geometries, material

		@plane.scale.x = dataJson.images[@particleReference].size
		@plane.scale.y = dataJson.images[@particleReference].size*dataJson.images[@particleReference].ratio
		@plane.position.set(0,0,-20+@particleReference);
		scene.scene.add @plane

		@plane.particleReference = @particleReference
		scene.clickable.push(@plane)

		@plane.rotation.set(Math.random()*10,Math.random()*10,Math.random()*10, "XYZ");

	update: =>
		@updatePos()
		@plane.position.set(@position.x, @position.y, @position.z)
		@plane.rotation.y -= 0.0075