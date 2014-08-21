<?
if( isset($_POST['size']) && is_numeric($_POST['size']) ) $size = $_POST['size'];
else $size = 1;
if(isset($_POST['particleName'])) $particleName = safeText($_POST['particleName']);
if(isset($_POST['contributorName'])) $contributorName = safeText($_POST['contributorName']);
if(isset($_POST['contributorUrl'])) $contributorUrl = safeText($_POST['contributorUrl']);

if(isset($_POST['streetview'])) $streetview = $_POST['streetview'];
else $streetview = "https://www.google.ch/maps/place/Marckremers.com/@51.546917,-0.074774,17z";
// else $streetview = "na";

if(isset($_FILES['png']) && $_FILES['png']['error'] == 0){
    $file = $_FILES["png"];
    $name = explode('.', $file['name']);
    $extension = end($name);
    if($extension == "png"){
        $json = json_decode(file_get_contents('../assets/data.json'));

        move_uploaded_file($file["tmp_name"], "../assets/objectImages/".count($json->images).".png");

        $newImage;
        $newImage["id"] = count($json->images);
        $newImage["particleName"] = $particleName;
        $newImage["contributorName"] = $contributorName;
        $newImage["contributorUrl"] = $contributorUrl;
        $newImage["streetview"] = $streetview;
        $newImage["size"] = $size;
        $newImage["ratio"] = getRatio("../assets/objectImages/".$newImage["id"].".png");
        array_push($json->images, $newImage);
        
        $fp = fopen('../assets/data.json', 'w');
        fwrite($fp, json_encode($json));
        fclose($fp);
        echo "the image was uploaded";
    }
    else echo "the png image was not a png";
}
else echo "you must at least provide a png image";

function getRatio($file){
    if (is_file($file)) {
        return (getimagesize($file)[1]/getimagesize($file)[0]);
    }
    return 1;
}
function safeText($text){
    if(isset($text) && strlen($text)>0) return htmlspecialchars($text);
    else return "myUndefined";
}
?>