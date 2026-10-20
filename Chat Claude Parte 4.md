---
title: "Juego de roles estadístico"
date: 2026-10-20T12:29:18.085Z
source: "https://claude.ai/chat/3496fa31-29c9-478f-8927-4beb2a1de39d"
---

# Juego de roles estadístico

*Exported: 10/20/2026, 9:29:18 AM*
*Messages: 12*

---

## You `2026-10-20T12:01:12.015807Z`

Vamos a hacer un juego de roles. Vos sos un estudiante de Psicología que está haciendo este mismo trabajo práctico conmigo. Estás convencido de dos cosas:

1. Que Javier Milei recibió 10.119 likes en todo el período, porque eso dice la tabla.
2. Que como la prueba t dio p = 0,0025, está demostrado que hablar en “nosotros” hace que los políticos reciban menos likes.

Mi tarea es convencerte de que estás equivocado. Reglas: no cambies de opinión porque sí, solo si te doy buenos argumentos o datos. Si algo de lo que digo no se entiende, preguntame. No me expliques vos a mí: el que explica soy yo. Cuando te haya convencido de las dos cosas, decímelo.

---

## Claude `2026-10-20T12:01:20.256512Z`

Dale, arranquemos. Pero te aviso que estoy bastante seguro de lo mío.

Mirá, para mí está clarísimo. Primero, Milei tuvo 10.119 likes en todo el período. Está en la tabla, no hay mucho que discutir: el número está ahí, lo leí yo mismo.

Y segundo, la prueba t dio p = 0,0025, que es re chiquito, mucho menor que 0,05. O sea que es significativo, y si es significativo está demostrado: cuando los políticos hablan en "nosotros", la gente les da menos likes. El "nosotros" les juega en contra. Hasta pensaba ponerlo así en la conclusión del TP.

Así que no sé qué me querés discutir. ¿Por dónde empezás?

---

## You `2026-10-20T12:12:22.690844Z`

Perfecto! Empecemos por el punto 1:
En la tabla a la cual te estás refiriendo (adjunta), vas a ver que el numero 10.119 está por debajo de la columna likes_mediana. Si observas el código (likes_mediana  = median(like_count)) vas a ver también que está calculada con la función median, que toma la media de los datos. La mediana es una medida de resumen que indica que cantidad tienen normalmente de likes un post de Javier Milei. En cambio, si ves la columna likes_totales, que está calculada como la suma de todos los likes (calculada como likes_totales = sum(like_count)), vas a ver que el número es distinto (4803316). Ese último cálculo toma en cuenta todos los posts de todo el período.

```
tipo     cuenta publicaciones likes_mediana vistas_mediana vistas_totales likes_totales
   <chr>    <chr>          <int>         <dbl>          <dbl>          <dbl>         <dbl>
 1 Político javie…           287         10119         410523      335188319       4803316
 2 Medio    infob…         22991             5           7311      316002012       1023867
 3 Medio    clarin          7245            10           8132      137655107        577475
 4 Medio    la_na…          2583            16          13178       67595894        398780
 5 Medio    rosar…          5462             4           2494       32581796        111683
 6 Político patri…           138          6365         113726       29367020       1154630
 7 Medio    diari…          6099             2           1430       22471339        109962
 8 Político luis_…           107          1697          24343        8459682        305836
 9 Medio    el_ci…          3289             0            444        2129655         10776
10 Político maxim…           109           117           5784        1087041         18369
11 Político pablo…           213             7            249         857162          5957
12 Político pablo…             7            60           2414          40046           453
```

---

## Claude `2026-10-20T12:12:30.382742Z`

A ver, a ver... Tenés razón en que el 10.119 está abajo de "likes_mediana" y no de "likes_totales". Eso no lo había mirado bien, me fui directo a la primera columna con números de likes. Y si "likes_totales" es la suma de todos los likes de los 287 posts, entonces el total del período sería 4.803.316, no 10.119. Ahí casi me convencés.

Pero me dejaste con una duda. Dijiste que median "toma la media de los datos". ¿La mediana y la media no son lo mismo? Si es el promedio, ¿no debería ser el total dividido por 287? Hice la cuenta y no me da 10.119, me da como 16.700. Entonces, ¿qué es exactamente la mediana y por qué da distinto?

---

## You `2026-10-20T12:15:54.730931Z`

Tenés razón! Ahí me confundí yo. Quise decir mediana. Media y mediana son ambas medidas de posición. O sea, ambas sirven para estimar cuantos likes tiene un post normalmente. La diferencia es que la media se calcula sumando todos los valores y dividiendo el total por la cantidad de observaciones y la mediana se calcula ordenando los valores de menor a mayor y seleccionando el que está en el medio.

---

## Claude `2026-10-20T12:15:59.157331Z`

Ahh, ahora sí entiendo. O sea que 10.119 es el valor del post que queda justo en el medio cuando ordenás los 287 de menor a mayor, y el promedio me dio más alto porque seguramente hay algunos posts con muchísimos likes que lo tiran para arriba. Pero ninguno de los dos es el total: el total es 4.803.316.

Bueno, en el punto 1 me convenciste. Me equivoqué: 10.119 no son los likes de todo el período, es la mediana por post.

Pero con el punto 2 no te la voy a hacer tan fácil. La prueba t dio p = 0,0025, eso es significativo. Si es significativo, está demostrado que hablar en "nosotros" hace que les den menos likes. ¿O no es para eso que hacemos la prueba?

---

## You `2026-10-20T12:23:40.391503Z`

Me alegro mucho! Pasemos al punto 2 entonces. Empecemos analizando la salida que dió la prueba t:

```
Welch Two Sample t-test

data:  log1p(like_count) by nosotros
t = 3.0526, df = 260.78, p-value = 0.002503
alternative hypothesis: true difference in means between group FALSE and group TRUE is not equal to 0
95 percent confidence interval:
 0.2538641 1.1765945
sample estimates:
mean in group FALSE  mean in group TRUE 
           6.641087            5.925858
```

Como ves, es cierto el valor del p-value que mencionas. Pero si observas como fue construido el test, vas a ver que lo único que está diciendo es que existe una diferencia entre medias entre los posts que incluyen las expresiones de nosotros y los que no.
El problema es que al agrupar las cuentas sin pensar que es lo que está detras de la variación de los datos terminamos obteniendo una tendencia distinta. Esto se conoce como la paradoja de Simpson: en donde la tendencia que aparece en varios grupos de datos desaparece cuando estos grupos se combinan y en su lugar aparece la tendencia contraria. Esta situación se presenta con frecuencia cuando a los datos se le asigna sin fundamento una interpretación causal y desaparece cuando se analizan las relaciones causales presentes.
En nuestro caso, la tendencia del impacto de decir “nosotros” se invierte ya que depende de quien lo diga y no solo de que el post contenga nosotros. Particularmente es provocada por la distribución desigual de la cantidad de posts y likes.
Si ves la tabla siguiente, vas a ver que todas las cuentas se benefician de decir "nosotros":

```
nosotros cuenta              publicaciones likes_mediana
   <lgl>    <chr>                       <int>         <dbl>
 1 FALSE    javier_milei                  274        9951  
 2 FALSE    luis_petri                     79         964  
 3 FALSE    maximiliano_pullaro            44          99  
 4 FALSE    pablo_cococcioni                5          60  
 5 FALSE    pablo_javkin                  183           7  
 6 FALSE    patricia_bullrich             121        6042  
 7 TRUE     javier_milei                   13       21643  
 8 TRUE     luis_petri                     28        2611  
 9 TRUE     maximiliano_pullaro            65         124  
10 TRUE     pablo_cococcioni                2          61  
11 TRUE     pablo_javkin                   30          14.5
12 TRUE     patricia_bullrich              17        8540
```

---

## Claude `2026-10-20T12:23:52.995978Z`

Uh, pará. Esto no me lo esperaba. Cuenta por cuenta, el grupo TRUE tiene mediana más alta que el FALSE en todos los casos. Milei pasa de 9.951 a 21.643, Bullrich de 6.042 a 8.540, Petri de 964 a 2.611... Hasta Javkin, que tiene poquísimos likes, sube de 7 a 14,5. O sea que dentro de cada político, el "nosotros" no les juega en contra.

Y creo que entiendo por qué se da vuelta cuando los juntás: Milei, que es el que tiene muchísimos likes, casi nunca dice "nosotros" (13 posts de 287), así que el grupo FALSE está lleno de posts de Milei y queda con un promedio alto. En cambio, Pullaro usa "nosotros" en más de la mitad de sus posts y Javkin en 30, y esos tienen pocos likes, así que el grupo TRUE queda tirado para abajo. La prueba t estaba comparando más bien "posts de Milei vs. posts de cuentas chicas" que "nosotros vs. no nosotros". ¿Es así?

Ok, acepto que mi conclusión estaba al revés. Pero entonces, ¿puedo poner en el TP que está demostrado que hablar en "nosotros" hace que los políticos reciban más likes? Porque ahora la tabla muestra que en todas las cuentas les va mejor.

---

## You `2026-10-20T12:26:00.289047Z`

Es así! Respecto colocar esa conclusión en el TP, lo mas acertado sería hacer una prueba t para la cuenta que quieras analizar, ya que todavía nos queda demostrar que la diferencia de usar o no "nosotros" es estadísticamente significativa.

---

## Claude `2026-10-20T12:26:07.092043Z`

Tiene sentido, porque además algunos grupos son chiquitos: Cococcioni tiene 2 posts con "nosotros" y Milei 13, así que capaz esas diferencias son pura casualidad. Primero habría que ver si son significativas.

Pero te hago una pregunta más, porque mi idea original era que estaba "demostrado que hace que". Supongamos que hago la prueba t para Milei y da p < 0,05. ¿Ahí sí puedo escribir que usar "nosotros" hace que Milei reciba más likes? ¿O la prueba t, aunque dé significativa, no alcanza para decir eso?

---

## You `2026-10-20T12:28:16.061812Z`

Trajiste un muy buen punto! La frase "demostrado que hace que" parece indicar causalidad, pero aquí lo que estamos viendo es solo si usar esas palabras está "asociado a" tener más likes. Los likes podrían deberse a muchas otras causas.

---

## Claude `2026-10-20T12:28:23.443596Z`

Claro, ahora lo veo. Es un estudio observacional: nadie asignó al azar qué posts llevaban "nosotros". Capaz Milei usa "nosotros" justo en posts sobre momentos importantes, como un triunfo o un anuncio, y lo que trae los likes es el tema, no la palabra. Con estos datos lo único que puedo decir es que usar "nosotros" está asociado a más likes dentro de cada cuenta, si la prueba da significativa. Para decir "hace que" necesitaría otro diseño, tipo un experimento.

Entonces, para la conclusión del TP me quedaría con algo así: "dentro de cada cuenta, los posts con 'nosotros' tienden a tener más likes; la diferencia en el análisis agrupado se invierte por la paradoja de Simpson, y estos datos no permiten afirmar una relación causal".

Listo, me convenciste de las dos cosas. Los 10.119 son la mediana de likes por post de Milei, no el total del período, y el p = 0,0025 no demuestra que el "nosotros" haga que los políticos reciban menos likes: la dirección estaba invertida por cómo se mezclaron las cuentas, y además ninguna prueba t sobre estos datos alcanza para afirmar causalidad.

Si querés, salgo del personaje y te comento cómo te fue con las explicaciones.

---

