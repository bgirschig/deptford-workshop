wiggleDistance = 20
wiggleSpeed = 800
wiggleSmooth = 50
counter = 3000
class window.OverlayHandler
	constructor: () ->
		@waitTransition = false
		@floatMode = document.getElementById("overlay").className.indexOf("floatMode") != -1
		

		if(@floatMode)
			@gotoSection(0)
			setTimeout(()=>
				@gotoSection(1)
			, 300)
			@initPositions()
		else @gotoSection 5

		document.getElementById("arrowNext").addEventListener("click", @nextParticle)
		document.getElementById("arrowPrev").addEventListener("click", @prevParticle)
	initPositions: ()->
		@title = new flatParticle(3,20)
		@title.attach(document.getElementById("title"))

		@map = new flatParticle(3,20)
		@map.attach(document.getElementById("map"))

		@aboutContent = new flatParticle(5,0)
		@aboutCaption = new flatParticle(5,0)

	gotoSection : (section) ->
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
				@map.element.style.top = - @map.element.offsetHeight+"px";
				@title.element.style.top = - @title.element.offsetWidth+"px";
				@map.element.style.opacity = 0;
				@title.element.style.opacity = 0;
				document.getElementById("logo").show()
				document.getElementById("aboutContent").show()
				document.getElementById("aboutCaption").show()
				rect = document.getElementById("aboutContent").getBoundingClientRect()
				document.getElementById("aboutCaption").style.top = rect.height+rect.top+80+"px"

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
				if !Settings.sceneStarted
					scene.update()
					Settings.sceneStarted = true
			when 3 # 3d view
				if !@waitTransition
					document.getElementById("threeCanvas").show()
					scene.displayed = true
					document.getElementById("overlay").style.opacity = 0
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
			when 4 # particleViewer desktop
				if !@waitTransition
					if !@currentParticle? then @showParticle(0)
					document.getElementById("aboutContent").hide()
					document.getElementById("aboutCaption").hide()
					if @floatMode
						document.getElementById("logo").addClass("whiteFont")
						document.getElementById("logo").removeClass("blackFont")
					document.getElementById("overlay").style.backgroundImage = 'url("assets/backgroundDark.jpg")';
					document.getElementById("overlay").show()
					
					@waitTransition = true
					setTimeout () =>
						@waitTransition = false
						document.getElementById("overlay").style.opacity = 1
					,10
					document.getElementById('particleViewer').show()
					scene.displayed = false

			when 5 #mobile about
				console.log 5
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
		@offsetX
		@offsetY
		@angleAmplitude = angleAmplitude
		@angleOffset = angleOffset
	attach : (element) =>
		@element = element
		setTimeout () =>
			@x = -(@element.offsetWidth/2)
			@y = -(@element.offsetHeight/2)
			@element.style.opacity = 0.9
			@wiggle()
			@animate()
			@offsetX = -@element.offsetWidth/2
			@offsetY = -@element.offsetHeight/2
		, 1
		setTimeout ()=>
			@isIntro = false
			@x = (-@element.getBoundingClientRect().width/2) + Math.cos(@targetPosRefAngle) * wiggleDistance
			@y = (-@element.getBoundingClientRect().height/2) + Math.sin(@targetPosRefAngle) * wiggleDistance
		,400
	wiggle : () =>
		@targetPosRefAngle += Math.random()*Math.PI/2 - Math.random()*Math.PI/4
		if Math.random() > 0.5 then @targetAngle = @angleOffset-@angleAmplitude else @targetAngle = @angleOffset+@angleAmplitude
		if @doAnimate then setTimeout(@wiggle, wiggleSpeed)

	animate : () =>
		if counter > 0 then counter-= 5
		targetX = @offsetX + Math.cos(@targetPosRefAngle) * wiggleDistance
		targetY = @offsetY + Math.sin(@targetPosRefAngle) * wiggleDistance
		@x += (targetX - @x) / wiggleSmooth
		@y += (targetY - @y) / wiggleSmooth
		@angle += (@targetAngle - @angle) / wiggleSmooth
		if @isIntro
			@element.style.webkitTransform = "translate(-50%,-50%) scale(1)"
		else
			@element.style.webkitTransform = "translate("+(@x)+"px, "+(@y)+"px) rotate("+@angle+"deg) scale(1)"
		if @doAnimate then setTimeout(@animate, 50)