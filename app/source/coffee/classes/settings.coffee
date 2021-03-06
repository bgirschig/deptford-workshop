window.Settings = {
	#debug
	debug: false
	camOffset: 100
	unlockCamAxis: false

	# counts
	particlesCount: 500
	soundParticlesCount: 0
	
	# forces
	gravity: new THREE.Vector3(0, 0.0015 ,0)
	dragCoef: 2
	
	# sound
	soundPropagation: 0.5 # smaller number means sound fades away quicker with the distance
	soundVolume: 4 # master volume
	
	# distances
	vitalSpace: 3.5
	outerDistance: 80
	deletionDistance: 81

	#colors
	bgColor: 0x000000


	# environment
	skybox: true
	ambientLightColor: 0xFF0000
	
	#fog
	fogDensity: 0.016
	fogColor: 0x62666a

	# optimisation
	ratioSimplification: 1

	sceneStarted: false
}