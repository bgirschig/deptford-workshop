window.mouse = {x: window.innerWidth/2, y: window.innerHeight/2}

updateMouse = (e) ->
	mouse.x = e.clientX
	mouse.y = e.clientY
onDocumentMouseDown = (e) -> 
	projector = new THREE.Projector()
	mouseVector = new THREE.Vector3()

	e.preventDefault()
	mouseVector.x = 2 * (e.clientX / window.innerWidth) - 1;
	mouseVector.y = 1 - 2 * (e.clientY / window.innerHeight);
	raycaster = projector.pickingRay( mouseVector.clone(), scene.camera );
	intersects = raycaster.intersectObjects( scene.clickable, true );
	if intersects.length > 0
		ref = intersects[0].object.particleReference
		if(!dataJson.images[ref].streetview?)
			window.open("https://www.google.ch/maps/place/London",'_blank')
		else
			window.open(dataJson.images[ref].streetview, '_blank')
	else if Settings.debug
		scene.camera.position.z = Settings.camOffset - scene.camera.position.z

setOrientation = (e) ->
	document.removeEventListener( 'mousemove', updateMouse, false )
	document.removeEventListener( 'mousedown', onDocumentMouseDown, false )
	alpha = e.alpha
	scene.particleSystem.targetRotation = -e.alpha/180*Math.PI

initOrientation = (e) ->
	window.removeEventListener("deviceorientation", initOrientation, false)

	if e.alpha == null
		document.addEventListener('mousemove', updateMouse, false)
		document.addEventListener( 'mousedown', onDocumentMouseDown, false )
	else
		window.addEventListener("deviceorientation", setOrientation, false)

start = () ->
	scene.update()
	document.getElementById('ui').className = "hide"
	document.getElementById('about').className = "hide"
	document.getElementById('threeCanvas').className = ""


window.addEventListener("deviceorientation", initOrientation, false)

document.getElementById('cta').onclick = start