window.Utils = {
	displayError: (details) ->
		document.getElementsByTagName("body")[0].innerHTML = "<div id='error'>There was an error.<br/>try <a href='index.html'>reloading the page</a> <div id='details'>"+details+" <br/><i> The experience will not be launched</i></div></div>"
		console.log "ERROR: "+details
	loadJson: ( url, callback ) ->
		Utils.onJsonCallback = callback
		ajax = new XMLHttpRequest()
		ajax.open( "GET", url, true )
		ajax.setRequestHeader("Content-type", "application/json");
		ajax.onreadystatechange = Utils.onRecieveJson
		ajax.send()
		return null

	onRecieveJson: (e) ->
		if e.target.readyState == 4 && e.target.status == 200
			try
				window.dataJson = JSON.parse(e.target.response)
				launch = true
			catch e
				Utils.displayError("The error occured while reading a json file containing important data for this experience. this file seems to be corrupted.");
				launch = false
			Utils.onJsonCallback() if launch
			
		else if e.target.readyState == 4
			Utils.displayError("The error occured while trying to load the json containing gps tags, image dimensions and other critical data.");
}
HTMLElement::hide = () ->
	@className = @className.replace("show", "hide")
	if @className.indexOf("hide") == -1 then @className += " hide"
HTMLElement::show = () ->
	@className = @className.replace("hide", "show")
	if @className.indexOf("show") == -1 then @className += " show"
HTMLElement::addClass = (val) ->
	if @className.indexOf(val) == -1 then @className += " "+val
HTMLElement::removeClass = (val) ->
	@className = @className.replace(" "+val, "")
	@className = @className.replace(val+" ", "")
	@className = @className.replace(val, "")
