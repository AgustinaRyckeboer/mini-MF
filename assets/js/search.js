---

---
// Based on a script by Kathie Decora : katydecorah.com/code/lunr-and-jekyll/

//Create the lunr index for the search
var index = elasticlunr(function () {
  this.addField('title')
  this.addField('layout')
  this.addField('content')
  this.setRef('id')
});

//Add to this index the proper metadata from the Jekyll content
{% assign count = 0 %}{% for text in site.preguntas_respuestas %} //metadata from preguntas_respuestas repertory
index.addDoc({
  subtitle: {{text.title | jsonify}},
  layout: {{text.layout | jsonify}},
  type: {{text.type | jsonify}},
  content: {{text.content | jsonify | strip_html}},
  id: {{count}}
});{% assign count = count | plus: 1 %}{% endfor %}
console.log( jQuery.type(index) );

{% for text in site.cantigas %} //metadata from cantigas repertory
index.addDoc({
  subtitle: {{text.title | jsonify}},
  layout: {{text.layout | jsonify}},
  type: {{text.type | jsonify}},
  content: {{text.content | jsonify | strip_html}},
  id: {{count}}
});{% assign count = count | plus: 1 %}{% endfor %}
console.log( jQuery.type(index) );

// Builds reference data for results
var store1 = [{% for text in site.preguntas_respuestas %}{ //reference data from preguntas y respuestas
  "title": {{text.title | jsonify}},
  "layout": {{ text.layout | jsonify }},
  "type": {{ text.type | jsonify }},
  "link": {{text.url | jsonify}},
},
{% endfor %}]

var store2 = [{% for text in site.cantigas %}{ //reference data from cantigas
  "title": {{text.title | jsonify}},
  "layout": {{ text.layout | jsonify }},
  "type": {{ text.type | jsonify }},
  "link": {{text.url | jsonify}},
},
{% endfor %}]

let store = store1.concat(store2); //concat reference data to loop on single reference variabe when recovering results

//Query
var url = window.location.href;
if (url.lastIndexOf("?q=") > 0) {
  // get the index of the parameter, add three (to account for length)
  var stringloc = url.lastIndexOf("?q=") + 3;
  // get the substring (query) and decode
  var searchquery = decodeURIComponent(url.substr(stringloc));
}

function doSearch() {
  var resultdiv = $('#results');
  var query = $('input#search').val();

  //The search is then launched on the index built with Lunr
  var result = index.search(query);
  resultdiv.empty();
  if (result.length == 0) {
    resultdiv.append('<p class="">No se encontraron resultados.</p>');
  } else if (result.length == 1) {
    resultdiv.append('<p class="">'+result.length+' resultados</p>');
  } else {
    resultdiv.append('<p class="">'+result.length+' resultados</p>');
  }
  //Loop through, match, and add results
  for (var item in result) {
    var ref = result[item].ref;
    var searchitem = '<div class="result"><dd><a href="{{ site.baseurl }}'+store[ref].link+'?q='+query+'">'+store[ref].type+' - '+store[ref].title+'</a></dd></div>';
    resultdiv.append(searchitem);
  }
}

$(document).ready(function() {
  if (searchquery) {
    $('input#search').val(searchquery);
    doSearch();
  }
  $('input#search').on('keyup', doSearch);
});
