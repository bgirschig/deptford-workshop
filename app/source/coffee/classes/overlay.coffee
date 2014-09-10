wiggleDistance = 20
wiggleSpeed = 800
wiggleSmooth = 50
class window.OverlayHandler
	constructor: () ->
		@checkMode(false)
		if window.innerWidth>500 && window.innerHeight > 600
			document.getElementById("overlay").removeClass("fixMode")
			document.getElementById("overlay").addClass("floatMode")
		else
			document.getElementById("overlay").removeClass("floatMode")
			document.getElementById("overlay").addClass("fixMode")

		@waitTransition = false
		@floatMode = document.getElementById("overlay").className.indexOf("floatMode") != -1
		@currentSection

		if(@floatMode)
			@gotoSection(0)
			setTimeout(()=>
				@gotoSection(1)
			, 3500)
			@initPositions()
		else @gotoSection 5
		document.getElementById("arrowNext").addEventListener("click", @nextParticle)
		document.getElementById("arrowPrev").addEventListener("click", @prevParticle)
	checkMode: (playPause=true)->
		if window.innerWidth<500 || window.innerHeight < 600
			@floatMode = "fixMode"
			document.getElementById("overlay").addClass("fixMode")
			document.getElementById("overlay").removeClass("floatMode")
			if playPause	
				@title.doAnimate = false
				@map.doAnimate = false
				@aboutContent.doAnimate = false
				@aboutCaption.doAnimate = false
			if @currentSection >= 3
				document.getElementById("logo").addClass("whiteFont")
				document.getElementById("logo").removeClass("blackFont")
		else
			@floatMode = "floatMode"
			document.getElementById("overlay").removeClass("fixMode")
			document.getElementById("overlay").addClass("floatMode")
		
	initPositions: ()->
		@title = new flatParticle(3,20)
		@title.attach(document.getElementById("title"))

		@map = new flatParticle(3,20)
		@map.attach(document.getElementById("map"), true)

		@aboutContent = new flatParticle(5,0)
		@aboutCaption = new flatParticle(5,0)

	gotoSection : (section) ->
		@currentSection = section
		switch section
			when 0 #intro with map
				document.getElementById("loader").show()
				document.getElementById("title").show()
				document.getElementById("logo").hide()
				document.getElementById("map").show()
				document.getElementById("aboutContent").hide()
				document.getElementById("aboutCaption").hide()
				document.getElementById("logo").addClass("blackFont")
			when 1 # about text with loader 
				document.getElementById("centerMap").style.top = "-50%"
				document.getElementById("centerTitle").style.top = "-50%"
				@map.element.style.opacity = 0
				@title.element.style.opacity = 0
				document.getElementById("logo").show()
				document.getElementById("aboutContent").show()
				document.getElementById("aboutCaption").show()
				rect = document.getElementById("aboutContent").getBoundingClientRect()

				@aboutContent.attach(document.getElementById("aboutContent"))
				@aboutCaption.attach(document.getElementById("aboutCaption"))

				@waitTransition = true
				setTimeout ()=>
					@waitTransition = false
					@title.doAnimate = false
					@map.doAnimate = false
					document.getElementById("title").hide()
					document.getElementById("map").hide()
				,300
			when 2 # about text with "continue" button
				document.getElementById("loader").hide()
				document.getElementById("cta").show()
				if scene? && scene.threeOk && !Settings.sceneStarted
					scene.update()
					Settings.sceneStarted = true
			when 3 # 3d view
				if(scene? && scene.threeOk)
					if !@waitTransition
						document.getElementById("logo").addClass("left")
						document.getElementById("twitterBtn").style.color = "white"
						document.getElementById("threeCanvas").show()
						document.getElementById("overlay").style.opacity = 0
						scene.displayed = true
						
						@waitTransition = true
						setTimeout ()=>
							SoundHandler.gainNode.gain.value = 1
							@waitTransition = false
							document.getElementById("overlay").hide()
							if @floatMode
								@aboutContent.doAnimate = false
								@aboutCaption.doAnimate = false
						,300

						document.getElementById("cta").hide()
						document.getElementById("miniMenu").show()
				else if(@currentSection==4)
					if @floatMode then overlayHandler.gotoSection 2
					else overlayHandler.gotoSection 5
				else
					@gotoSection 4
			when 4 # particleViewer
				document.getElementById("map").hide()
				document.getElementById("closeOverlay").show()
				if !@waitTransition
					if !@currentParticle? then @showParticle(0)
					document.getElementById("aboutContent").hide()
					document.getElementById("aboutCaption").hide()
					if @floatMode
						document.getElementById("logo").addClass("whiteFont")
					document.getElementById("logo").removeClass("blackFont")
					document.getElementById("overlay").style.backgroundImage = 'url("assets/backgroundDarkS.jpg")';
					document.getElementById("overlay").show()
					
					@waitTransition = true
					setTimeout () =>
						@waitTransition = false
						document.getElementById("overlay").style.opacity = 1
					,10
					document.getElementById('particleViewer').show()
					if(scene?) then scene.displayed = false

			when 5 #mobile about
				document.getElementById("logo").show()
				document.getElementById("loader").show()
				document.getElementById("aboutContent").show()
				document.getElementById("aboutCaption").show()
	showParticle: (particleRef) ->
		@currentParticle = particleRef
		@gotoSection(4)
		dataTitle = dataJson.images[particleRef].particleName ? "thing"
		dataName = dataJson.images[particleRef].contributorName ? "someone"
		link = dataJson.images[particleRef].contributorUrl ? "marckremers.com/"
		streetview = dataJson.images[particleRef].streetview ? "https://www.google.ch/maps/place/London"

		document.getElementById("viewerDataTitle").innerHTML = dataTitle
		document.getElementById("viewerDataName").innerHTML = dataName
		document.getElementById("viewerDataName").href = "http://www."+link
		document.getElementById("viewerImg").src = "assets/objectImages/"+particleRef+".png"
		document.getElementById("streetviewLink").href = streetview
	prevParticle: ()=>
		nextId = if @currentParticle>0 then @currentParticle-1 else dataJson.images.length-1
		@showParticle nextId
	nextParticle: ()=>
		nextId = if @currentParticle<dataJson.images.length-1 then @currentParticle+1 else 0
		@showParticle nextId

class flatParticle
	constructor: (angleAmplitude, angleOffset) ->
		@isIntro = true
		@doAnimate = true
		@angle = 0
		@targetAngle = 0
		@targetPosRefAngle = 0
		@angleAmplitude = angleAmplitude
		@angleOffset = angleOffset
		@x = 0
		@y = 0
	attach : (element, center) =>
		@element = element
		if center then @offsetY = - @element.offsetHeight/2 else @offsetY = 0
		setTimeout () =>
			@element.style.opacity = 0.9
			@play()
		, 1
	play : ()=>
		@doAnimate = true
		@wiggle()
		@animate()
	wiggle : () =>
		if @doAnimate
			if @offsetY!=0 then @offsetY = - @element.offsetHeight/2
			@targetPosRefAngle += Math.random()*Math.PI/2 - Math.random()*Math.PI/4
			if Math.random() > 0.5 then @targetAngle = @angleOffset-@angleAmplitude else @targetAngle = @angleOffset+@angleAmplitude
			setTimeout(@wiggle, wiggleSpeed)

	animate : () =>
		if @doAnimate
			targetX = Math.cos(@targetPosRefAngle) * wiggleDistance
			targetY = Math.sin(@targetPosRefAngle) * wiggleDistance
			@x += (targetX - @x) / wiggleSmooth
			@y += (targetY - @y) / wiggleSmooth
			@angle += (@targetAngle - @angle) / wiggleSmooth
			@element.style.webkitTransform = "translate("+(@x)+"px, "+(@offsetY+@y)+"px) rotate("+@angle+"deg) scale(1)"
			@element.style.MozTransform = "translate("+(@x)+"px, "+(@offsetY+@y)+"px) rotate("+@angle+"deg) scale(1)"
			@element.style.Transform = "translate("+(@x)+"px, "+(@offsetY+@y)+"px) rotate("+@angle+"deg) scale(1)"
			setTimeout(@animate, 50)

