preloadCounter = 0
init = ()->
	preloadCounter++
	if preloadCounter == 3
		window.scene = new Scene()
		
		document.getElementById("overlay").style.opacity = 1
		setTimeout ()->
			window.overlayHandler = new OverlayHandler()
		,200
Utils.loadJson( 'assets/data.json', init);

# background image
bg = new Image()
bg.onload = init
bg.src = "assets/backgroundLightS.jpg"

# font
window.onload = init