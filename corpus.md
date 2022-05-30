---
layout: page
title: Corpus
order: 7
permalink: /corpus/
---

<p class="prosa">Esta sección presenta un corpus de poemas editados y reconstruidos desde lo filológico y lo musicológico, pensados desde la noción de contrafactum y cantiga de seguir, y ordenados según la tradición poética a la que pertenecen: "Preguntas y respuestas del Cancionero de Baena" y "Cantigas medievales gallego-portuguesas". El juego contrafático entre una pregunta y una respuesta o entre una cantiga base y su posible cantiga de seguir puede visualizarse al clickear en el botón "Métrica y rima" en la esquina superior derecha de la pantalla y al desplazar el cursor sobre la sílaba final de un verso, lo que hace que se destaquen todos los finales de verso con la misma rima.  
</p>
<p class="prosa">En el caso de las cantigas gallego-portuguesas, se ofrecen además audios y partituras donde este juego compositivo se pone de manifiesto desde el elemento melódico.</p>



## <span style="color: DarkCyan;">Preguntas y respuestas</span>
<!-- <br/> -->
<ul>
{% for my_preg_resp in site.preguntas_respuestas %}
    <li class="corpus"><a href="{{site.baseurl}}/{{my_preg_resp.url}}">{{ my_preg_resp.title }}</a></li>
{% endfor %}
</ul>

## <span style="color: SlateGray;">Cantigas y seguires</span>
<!-- <br/> -->
🚧 en construcción 🚧
<br/>
<ul>
{% for my_cantiga in site.cantigas %}
    <li class="corpus"><a href="{{site.baseurl}}/{{my_cantiga.url}}">{{ my_cantiga.title }}</a></li>
{% endfor %}
</ul>