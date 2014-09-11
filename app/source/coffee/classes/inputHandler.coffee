window.mouse = {x: window.innerWidth/2, y: window.innerHeight/2}

# ...
updateMouse = (e) ->
	mouse.x = e.clientX
	mouse.y = e.clientY

# click on a particle
onDocumentMouseDown = (e) ->
	if(Settings.sceneStarted && scene.displayed)
		projector = new THREE.Projector()
		mouseVector = new THREE.Vector3()

		e.preventDefault()
		mouseVector.x = 2 * (e.clientX / window.innerWidth) - 1
		mouseVector.y = 1 - 2 * (e.clientY / window.innerHeight)
		raycaster = projector.pickingRay( mouseVector.clone(), scene.camera )
		intersects = raycaster.intersectObjects( scene.clickable, true )
		if intersects.length > 0
			overlayHandler.gotoSection(4)
			overlayHandler.showParticle(intersects[0].object.particleReference)

		else if Settings.debug
			scene.camera.position.z = Settings.camOffset - scene.camera.position.z

# only for orientation with sensors
setOrientation = (e) ->
	document.removeEventListener( 'mousemove', updateMouse, false )
	document.removeEventListener( 'mousedown', onDocumentMouseDown, false )
	alpha = e.alpha
	# scene.particleSystem.targetRotation = -e.alpha/180*Math.PI

# recieves a null event if there are no sensors.
initOrientation = (e) ->
	window.removeEventListener("deviceorientation", initOrientation, false)
	if e.alpha != null
		document.addEventListener('mousemove', updateMouse, false)
		document.addEventListener( 'mousedown', onDocumentMouseDown, false )
		window.addEventListener("deviceorientation", setOrientation, false)

window.addEventListener("deviceorientation", initOrientation, false)
document.addEventListener('mousemove', updateMouse, false)
document.addEventListener( 'mousedown', onDocumentMouseDown, false )

ctas = document.getElementsByClassName("cta")
for cta in ctas
	cta.addEventListener("click", ()->
		overlayHandler.gotoSection(3)
	, false)

# adjust viewport when window is resized
onWindowResize = ()->
    scene.camera.aspect = window.innerWidth / window.innerHeight;
    scene.camera.updateProjectionMatrix();
    scene.renderer.setSize( window.innerWidth, window.innerHeight );
    overlayHandler.checkMode()
window.addEventListener 'resize', onWindowResize, false

# shortcuts
shorcutHandler = (e)->
	switch e.keyCode
		when 39 # right arrow
			overlayHandler.nextParticle()
		when 37 # left arrow
			overlayHandler.prevParticle()
		when 27 # esc
			overlayHandler.gotoSection(3)
		when 32 # space
			overlayHandler.gotoSection(4)
window.addEventListener("keyup", shorcutHandler)

document.getElementById("back").addEventListener("click", ()->
	if overlayHandler.currentSection == 4
		overlayHandler.gotoSection(6)
)