window.mouse = {x: window.innerWidth/2, y: window.innerHeight/2}

updateMouse = (e) ->
	mouse.x = e.clientX
	mouse.y = e.clientY
onDocumentMouseDown = (e) ->
	if document.getElementById('ui').className == "hide"
		projector = new THREE.Projector()
		mouseVector = new THREE.Vector3()

		e.preventDefault()
		mouseVector.x = 2 * (e.clientX / window.innerWidth) - 1
		mouseVector.y = 1 - 2 * (e.clientY / window.innerHeight)
		raycaster = projector.pickingRay( mouseVector.clone(), scene.camera )
		intersects = raycaster.intersectObjects( scene.clickable, true )
		if intersects.length > 0
			ref = intersects[0].object.particleReference
			document.getElementById("viewerDataTitle").innerHTML = dataJson.images[ref].particleName
			document.getElementById("viewerDataName").innerHTML = dataJson.images[ref].contributorName
			document.getElementById("viewerDataName").href = "http://"+dataJson.images[ref].contributorUrl
			document.getElementById("viewerImg").src = "assets/objectImages/"+ref+".png"
			if(!dataJson.images[ref].streetview?)
				document.getElementById("streetviewLink").href = "https://www.google.ch/maps/place/London"
			else
				document.getElementById("streetviewLink").href = dataJson.images[ref].streetview
			document.getElementById('ui').className = ""
			document.getElementById('particleViewer').className = ""
			document.getElementById('threeCanvas').className = "hide"
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
	if(!Settings.sceneStarted)
		scene.update()
		Settings.sceneStarted = true

	document.getElementById('ui').className = "hide"
	document.getElementById('aboutDiv').className = "hide"
	document.getElementById('threeCanvas').className = ""


window.addEventListener("deviceorientation", initOrientation, false)

document.getElementById('cta').onclick = start