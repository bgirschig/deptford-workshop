window.Settings = {
	#debug
	debug: true
	camOffset: 100
	unlockCamAxis: false

	# counts
	particlesCount: 0
	soundParticlesCount: 2
	
	# forces
	gravity: new THREE.Vector3(0, 0.0015 ,0)
	dragCoef: 2
	environmentInfluence: 0
	noiseSize: 10
	
	# sound
	soundPropagation: 0.5 # smaller number means sound fades away quicker with the distance
	soundVolume: 1 # master volume
	
	# distances
	vitalSpace: 1
	outerDistance: 80
	deletionDistance: 81

	#colors
	bgColor: 0x000000


	# environment
	skybox: true
	ambientLightColor: 0xBBBBBB	
	
	#fog
	fogDensity: 0.015
	fogColor: 0xaaaaaa

	# optimisation
	ratioSimplification: 1
}