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
$tpl->loadTemplatefile("ps_ss.tpl", true, true);
$link = mysqli_connect("mysql.digital-humanities.xyz","poemetca","4jdkiL4_s","poemetca_db") or die("Error " . mysqli_error($link)); 

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

$query = "SELECT Poem_Serial, Syllable_Signature FROM Poemas $where  order by Poem_Serial"; 
##echo $query;

$result = $link->query($query); 
$tpl->setCurrentBlock("GENERAL") ;
$tpl->setVariable("num_poemas", mysqli_num_rows($result));
$tpl->parseCurrentBlock("GENERAL") ;

while($row = mysqli_fetch_array($result)) { 
	$tpl->setCurrentBlock("ROW") ;
	$tpl->setVariable("ps", $row["Poem_Serial"]) ;
	$tpl->setVariable("sy", $row["Syllable_Signature"]) ;
	$tpl->parseCurrentBlock("ROW") ;
} 
$query2 = "SELECT Syllable_Signature, count(*) num FROM Poemas $where group by Syllable_Signature order by 2"; 
$result2 = $link->query($query2); 
$cont = mysqli_num_rows($result2);
while($row2 = mysqli_fetch_array($result2)) { 
	$tpl->setCurrentBlock("GRAFICO") ;
	$tpl->setVariable("sy_graf", $row2["Syllable_Signature"]) ;
	$tpl->setVariable("num_graf", $row2["num"]) ;
    $cont--;
    if ($cont > 0) {
	    $tpl->setVariable("coma", ",") ;
    }
	$tpl->parseCurrentBlock("GRAFICO") ;
}
mysqli_free_result($result);
mysqli_free_result($result2);
$link->close();
$tpl->show();
?> 

