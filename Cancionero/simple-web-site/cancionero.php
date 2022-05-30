<?php
require_once "HTML/Template/IT.php";

if (!isset($_GET["man"])) {
	$man = "sv1";
} else {
	$man = $_GET["man"];
}
if (!isset($_GET["ss"])) {
	$ss = "";
} else {
	$ss = $_GET["ss"];
}
if (!isset($_GET["tipo_busqueda"])) {
	$tipo_busqueda = "exacta";
} else {
    if ($_GET["tipo_busqueda"] == "aprox") {
	    $tipo_busqueda = "aprox";
    } else {
	    $tipo_busqueda = "exacta";
    }
}

$tpl = new HTML_Template_IT("./");
$tpl->loadTemplatefile("cancionero.tpl", true, true);
$link = mysqli_connect("HOSTNAME_HERE","DB_USER_HERE","DB_PASS_HERE","DB_NAME_HERE") or die("Error " . mysqli_error($link)); 

/* Manuscritos */
$query_man = "select distinct Manuscrito from Poemas order by Manuscrito";
$result_man = $link->query($query_man); 
while($row_man = mysqli_fetch_array($result_man)) { 
	$tpl->setCurrentBlock("ROW_MAN") ;
	$tpl->setVariable("str_man", $row_man["Manuscrito"]);
	if ($row_man["Manuscrito"] == $man)
		$tpl->setVariable("selected", "selected");
	$tpl->parseCurrentBlock("ROW_MAN") ;
} 

/* Tabla principal */
$man = mysqli_real_escape_string($link, $man);
$ss = mysqli_real_escape_string($link, $ss);
$where = "";
if (($man != "Todos") && ($ss != "")) {
    if ($tipo_busqueda == "exacta") {
	    $where = " where Manuscrito = '$man' and Syllable_Signature = '$ss'";
    } else {
	    $where = " where Manuscrito = '$man' and Syllable_Signature like '%$ss%'";
    }
} else if (($man != "Todos") && ($ss == "")) {
	$where = " where Manuscrito = '$man'";
} else if (($man == "Todos") && ($ss != "")) {
    if ($tipo_busqueda == "exacta") {
	    $where = " where Syllable_Signature = '$ss'";
    } else {
	    $where = " where Syllable_Signature like '%$ss%'";
    }
} else {
	$where = "";
}

$query = "SELECT Dutton_ID, Manuscrito, Poem_Serial, Folio, Stanza, Syllable_Signature, First_Line, Second_Line, Last_Line, Poema FROM Poemas $where  order by Dutton_ID"; 
##echo $query;

$result = $link->query($query); 
$tpl->setCurrentBlock("GENERAL") ;
$tpl->setVariable("num_poemas", mysqli_num_rows($result));
$tpl->parseCurrentBlock("GENERAL") ;

while($row = mysqli_fetch_array($result)) { 
	$tpl->setCurrentBlock("ROW") ;
	$tpl->setVariable("dutton_id", $row["Dutton_ID"]) ;
	$tpl->setVariable("man", $row["Manuscrito"]) ;
	$tpl->setVariable("ps", $row["Poem_Serial"]) ;
	$tpl->setVariable("fol", $row["Folio"]) ;
	$tpl->setVariable("st", $row["Stanza"]) ;
	$tpl->setVariable("sy", $row["Syllable_Signature"]) ;
	$tpl->setVariable("fl", $row["First_Line"]) ;
	$tpl->setVariable("sl", $row["Second_Line"]) ;
	$tpl->setVariable("ll", $row["Last_Line"]) ;
	$reemplazar = array("\r\n", "\n", "\r");
	$poem = str_replace($reemplazar, "<br/>", $row["Poema"]);
	$tpl->setVariable("poem", $poem) ;
	$tpl->parseCurrentBlock("ROW") ;
} 
$link->close();
$tpl->show();
?> 

