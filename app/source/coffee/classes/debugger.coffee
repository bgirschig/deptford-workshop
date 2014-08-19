window.Debugger = {
	testCube: (s=1) ->
		material = new THREE.MeshLambertMaterial {map: THREE.ImageUtils.loadTexture 'assets/testPattern.png' }
		geometry = new THREE.BoxGeometry s,s,s
		geometry = new THREE.PlaneGeometry(s, s)
		return new THREE.Mesh geometry, material

	axes: (size, _idColor) ->
		group = new THREE.Object3D()

		red = new THREE.LineBasicMaterial {color: 0xFF0000, linewidth: 3}
		green = new THREE.LineBasicMaterial {color: 0x00FF00, linewidth: 3}
		blue = new THREE.LineBasicMaterial {color: 0x0000FF, linewidth: 3}
		_idColor = _idColor ? 0xFFFFFF
		idColor = new THREE.MeshBasicMaterial { color: _idColor }


		head = new THREE.Geometry()
		pitch = new THREE.Geometry()
		bank = new THREE.Geometry()
		idCube = new THREE.BoxGeometry size/10,size/10,size/10

		head.vertices.push new THREE.Vector3(0, 0, 0)
		head.vertices.push new THREE.Vector3(0, size, 0)

		pitch.vertices.push new THREE.Vector3(0, 0, 0)
		pitch.vertices.push new THREE.Vector3(size, 0, 0)
		
		bank.vertices.push new THREE.Vector3(0, 0, 0)
		bank.vertices.push new THREE.Vector3(0, 0, size)

		group.add( new THREE.Line head, red )
		group.add( new THREE.Line pitch, green )
		group.add( new THREE.Line bank, blue )
		group.add( new THREE.Mesh idCube, idColor )

		return group
}