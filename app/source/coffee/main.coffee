init = ()->
	console.log dataJson.test
	console.log "starting ThreeJs..."
	
	window.scene = new Scene()

Utils.loadJson( 'assets/data.json', init);