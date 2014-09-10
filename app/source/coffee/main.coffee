init = ()->
	console.log dataJson.test
	console.log "starting ThreeJs..."
	
	window.scene = new Scene()

Utils.loadJson( 'assets/data.json', init);

bg = new Image()

bg.onload = ()->
	document.getElementById("overlay").style.opacity = 1
	setTimeout ()->
		window.overlayHandler = new OverlayHandler()
	,200
	
bg.src = "assets/backgroundLightS.jpg"