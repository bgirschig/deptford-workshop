
<html>
<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<?
	if(isset($_FILES['jpeg']) && $_FILES['jpeg']['error'] == 0){
	    $file = $_FILES["jpeg"];
	    $name = explode('.', $file['name']);
	    $extension = end($name);
	    $tempName = explode('/', $file["tmp_name"]);
	    $tempName = end($tempName).".jpeg";
	    if($extension == "jpg" || $extension == "jpeg" || $extension == "JPG" || $extension == "JPEG"){
	        move_uploaded_file($file["tmp_name"], "../assets/tmp/".$tempName);
	        getData("../assets/tmp/".$tempName);
	    }
	    else echo "noJpeg";
	}
	else{
		echo "noJpeg";
	}

	function getData($file){
	    if (is_file($file)) {
	        $info = exif_read_data($file);
	        if (isset($info['GPSLatitude']) && isset($info['GPSLongitude']) &&
	            isset($info['GPSLatitudeRef']) && isset($info['GPSLongitudeRef']) &&
	            in_array($info['GPSLatitudeRef'], array('E','W','N','S')) && in_array($info['GPSLongitudeRef'], array('E','W','N','S'))) {

	            $GPSLatitudeRef  = strtolower(trim($info['GPSLatitudeRef']));
	            $GPSLongitudeRef = strtolower(trim($info['GPSLongitudeRef']));

	            $lat_degrees_a = explode('/',$info['GPSLatitude'][0]);
	            $lat_minutes_a = explode('/',$info['GPSLatitude'][1]);
	            $lat_seconds_a = explode('/',$info['GPSLatitude'][2]);
	            $lng_degrees_a = explode('/',$info['GPSLongitude'][0]);
	            $lng_minutes_a = explode('/',$info['GPSLongitude'][1]);
	            $lng_seconds_a = explode('/',$info['GPSLongitude'][2]);

	            $lat_degrees = $lat_degrees_a[0] / $lat_degrees_a[1];
	            $lat_minutes = $lat_minutes_a[0] / $lat_minutes_a[1];
	            $lat_seconds = $lat_seconds_a[0] / $lat_seconds_a[1];
	            $lng_degrees = $lng_degrees_a[0] / $lng_degrees_a[1];
	            $lng_minutes = $lng_minutes_a[0] / $lng_minutes_a[1];
	            $lng_seconds = $lng_seconds_a[0] / $lng_seconds_a[1];

	            $lat = (float) $lat_degrees+((($lat_minutes*60)+($lat_seconds))/3600);
	            $lng = (float) $lng_degrees+((($lng_minutes*60)+($lng_seconds))/3600);

	            //If the latitude is South, make it negative. 
	            //If the longitude is west, make it negative
	            $GPSLatitudeRef  == 's' ? $lat *= -1 : '';
	            $GPSLongitudeRef == 'w' ? $lng *= -1 : '';

	            echo "<div id='preQuestions'>click <a target='_blank' href='https://www.google.ch/maps/place/".$lat."%20".$lng."'>here</a>, try to find the goo streetview angle, copy the url<br>";
	            echo "get back to <a href='addImage.php?geoloc=0'>add page</a> and paste it in the 'streetview' part<br><div>";
	        }
	    }
	    return false;
	}
?>
</body>
</html>