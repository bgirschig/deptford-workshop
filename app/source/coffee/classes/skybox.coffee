window.createSkybox = () ->
	img = new Image()
	img.src = 'assets/skies/C.jpg'
	texture = new THREE.Texture(img)
	img.tex = texture
	img.onload = () ->
		this.tex.needsUpdate = true

	geometry = new THREE.SphereGeometry(Settings.deletionDistance+Settings.deletionDistance/4, 20, 20)
	material = new THREE.MeshBasicMaterial({color: 0xffffff, map: texture, fog:false})
	material.side = THREE.BackSide 
	sky = new THREE.Mesh(geometry, material)
	sky.position.y = -30
	return sky