init = ()->
	console.log dataJson.test
	console.log "starting ThreeJs..."
	
	window.scene = new Scene()
	scene.update()

Utils.loadJson( 'assets/data.json', init);

# video = document.querySelector("#videoElement")
 
# navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia || navigator.oGetUserMedia
 
# handleVideo = (stream) ->
#     video.src = window.URL.createObjectURL(stream)

# videoError = (e) ->
# 	console.log "error with live video"

# if (navigator.getUserMedia)
#     navigator.getUserMedia( {video: true}, handleVideo, videoError )
#  