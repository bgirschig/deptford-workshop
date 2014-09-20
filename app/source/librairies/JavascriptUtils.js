// ---------------- V convertionVars
var radToDeg = 180/Math.PI;
var degToRad = Math.PI/180;

// ---------------- F contrain()
// returns fisrt parameter, constrained between the 2nd and third one;
Math.constrain = function(val, min, max){
	if(val>max) return max;
	else if(val<min) return min;
	else if(min>max){
		console.error("wrong arguments on constrain: min must be lower than max");
		return null;
	}
	return val;
}

// --------------- C MetaAngle
// class for handling smoothing of rotation animation that might go over 1 full turn
function MetaAngle(fullTurn){
	this.linearAngle;
	this.pAngle;
	this.smoothedLinearAngle;
	this.smoothRatio = 10;
	if(fullTurn==undefined) this.fullTurnLimit = 300;
	else this.fullTurnLimit = fullTurn - (fullTurn/6);
}
MetaAngle.prototype.update = function(newAngle){
	if(newAngle!=undefined){
		if(this.linearAngle!=undefined && this.linearAngle!=null){
			d = newAngle-this.pAngle;
			if(Math.abs(d)<300) this.linearAngle += d;
			this.pAngle = newAngle;
		}
		else this.set(newAngle);
	}
	this.smoothedLinearAngle += (this.linearAngle - this.smoothedLinearAngle) / this.smoothRatio;
}

MetaAngle.prototype.set = function(angle){
	this.linearAngle = angle;
	this.pAngle = angle;
	this.smoothedLinearAngle = angle;
}