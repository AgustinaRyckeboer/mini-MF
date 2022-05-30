<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title>Índice Ana María</title>
<link href="cancionero.css"  rel="stylesheet" />
</head>
 <body>
<form action="cancionero.php" method="GET">
Manuscrito: <select name="man" id="man">
	<option value="Todos" selected>Ver todos</option>
<!-- BEGIN ROW_MAN -->
	<option value="{str_man}" {selected}>{str_man}</option>
<!-- END ROW_MAN -->
</select>
Métrica: <input type="text" value="" id="ss" name="ss"/>
<small>(Búsqueda exacta: <input type="radio" name="tipo_busqueda" id="tipo_busqueda" value="exacta" checked/> &nbsp;Búsqueda aproximada: <input type="radio" name="tipo_busqueda" id="tipo_busqueda" value="aprox"/>)</small>
<input type="submit" value="Filtrar"/>
</form>
<!-- BEGIN GENERAL -->
Poemas encontrados: {num_poemas}<br/>
<!-- END GENERAL -->

  <table border="1">
  <tr>
    <th>ID DUTTON</th>
    <th>Man</th>
    <th>Poem Serial</th>
    <th>Folio</th>
    <th>Stanza</th>
    <th>Syllable Signature</th>
    <th>First Line</th>
    <th>Second Line</th>
    <th>Last Line</th>
    <th>Poem</th>
  </tr>
<!-- BEGIN ROW -->
   <tr>
    <td>{dutton_id}</td>
    <td>{man}</td>
    <td>{ps}</td>
    <td>{fol}</td>
    <td><div class="celda_simple">{st}</div></td>
    <td><div class="celda_simple">{sy}</div></td>
    <td>{fl}</td>
    <td>{sl}</td>
    <td>{ll}</td>
    <td class="poem"><div class="celda_poema">{poem}</div></td>
   </tr>
<!-- END ROW -->
  </table>
 </body>
</html>

