window.createSkybox = () ->
	imagesLocation = "assets/skybox/";
	urls = [imagesLocation + "posx.jpg", imagesLocation + "negx.jpg",
	    	imagesLocation + "posy.jpg", imagesLocation + "negy.jpg",
	    	imagesLocation + "posz.jpg", imagesLocation + "negz.jpg"]
	materials = []
	for i in [0..5] by 1
	  img = new Image()
	  img.src = urls[i]
	  tex = new THREE.Texture(img)
	  img.tex = tex
	  img.onload = () ->
	    this.tex.needsUpdate = true
	  mat = new THREE.MeshBasicMaterial({color: 0xffffff, map: tex, fog:false})
	  mat.side = THREE.BackSide
	  materials.push(mat)
	cubeGeo = new THREE.BoxGeometry(1200,1200,1200)
	cube = new THREE.Mesh(cubeGeo, new THREE.MeshFaceMaterial(materials))
	return cube

	

	textureCube = THREE.ImageUtils.loadTextureCube( urls )

	shader = THREE.ShaderLib["cube"]
	uniforms = THREE.UniformsUtils.clone( shader.uniforms )
	uniforms['tCube'].texture = textureCube

	material = new THREE.ShaderMaterial({
	    fragmentShader    : shader.fragmentShader,
	    vertexShader  : shader.vertexShader,
	    uniforms  : uniforms
	})
	# material.side = THREE.BackSide

	return new THREE.Mesh( new THREE.BoxGeometry( 10, 10, 10 ), material );