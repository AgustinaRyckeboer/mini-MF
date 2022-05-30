<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title>Índice Ana María</title>
<link href="cancionero.css"  rel="stylesheet" />
<!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">

      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart', 'table']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Syllable Signature');
        data.addColumn('number', 'Número de apariciones');
        data.addRows([
        <!-- BEGIN GRAFICO -->
            ['{sy_graf}', {num_graf}]{coma}
        <!-- END GRAFICO -->
        ]);

        // Set chart options
        var options = {'title':'Gráfica: Syllable Signatre / Número de apariciones',
                       'width':800,
                       'height':600};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        chart.draw(data, options);

        var table = new google.visualization.Table(document.getElementById('table_div'));
        table.draw(data, options);
      }
    </script>
</head>
 <body>
<form action="ps_ss.php" method="GET">
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

<div style="margin-left: auto; margin-right: auto; float:left;">
  <table border="1" style="margin-left:50px">
  <tr>
    <th>Poem Serial</th>
    <th>Syllable Signature</th>
  </tr>
<!-- BEGIN ROW -->
   <tr>
    <td>{ps}</td>
    <td><div class="celda_simple">{sy}</div></td>
   </tr>
<!-- END ROW -->
  </table>
</div>
<div style="margin-left: auto; margin-right: auto; float: right;">
    <div id="chart_div"></div>
    <br/>
    <div id="table_div"></div>
    <br/>
</div>
 </body>
</html>

