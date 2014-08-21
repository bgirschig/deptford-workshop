
<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<?
		if(!isset($_GET['geoloc'])){?>
			<div id="preQuestions">
				<p>
					Does your original JPG have Gelolocation <br>
					<div id="linkBox">
						<a href="?geoloc=1">yes</a> <a href="?geoloc=0">no</a>
					</div>
				</p>
			</div>
		<?}
		elseif($_GET['geoloc']==true){?>
			<form method="POST" action="getGps.php" enctype="multipart/form-data" id="jpegForm">
				<label for="jpeg">original jpeg: </label><input type="file" name="jpeg" id="jpeg"/>
				<input type="submit" value="get link"></submit>
			</form>
		<?}
		else{?>
			<form method="POST" action="uploadHandler.php" enctype="multipart/form-data" id="infoForm">
				<span id="formLabels">
					<label for="streetview">paste Streetview URL: </label>
					<label for="png">png cutout: </label>
					<label for="size">object size: </label>
					<label for="particleName">particle name: </label>
					<label for="contributorName">your name: </label>
					<label for="contributorUrl">your url: </label>
				</span>
				<span id="formInputs">
					<input type="text" value="here" name="streetview" id="streetview"/>
					<input type="file" name="png" id="png"/>
					<input type="text" name="size" id="size"/>
					<input type="text" name="particleName" id="particleName"/>
					<input type="text" name="contributorName" id="contributorName"/>
					<input type="text" name="contributorUrl" id="contributorUrl"/>
				</span>
				<input type="submit" value="send"></submit>
			</form>
		<?}
	?>
	<script type="text/javascript">
	</script>
</body>
</html>