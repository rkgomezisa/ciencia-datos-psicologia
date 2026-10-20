---
title: "Informe de publicaciones X Argentina"
date: 2026-10-20T04:41:34.994Z
source: "https://claude.ai/chat/2113d3e3-8d59-4e39-ac0d-bb7b4b2e0e80"
---

# Informe de publicaciones X Argentina

*Exported: 10/20/2026, 1:41:34 AM*
*Messages: 56*

---

## You `2026-10-19T22:16:01.483065Z`

Voy a trabajar con vos en un trabajo práctico de la Facultad de Psicología. Tengo que revisar un informe sobre una base de publicaciones de X (doce cuentas: seis medios y seis políticos argentinos, marzo a mayo de 2024) y encontrar sus errores. Sé muy poco de programación y de estadística.
Quiero que seas mi tutor, no que hagas el trabajo por mí. Por eso te pido estas reglas:

1. No me digas si un párrafo está bien o mal, ni cuál es el error. Primero preguntame qué pienso yo.
2. Si me equivoco, no me corrijas directamente: haceme una pregunta que me ayude a darme cuenta.
3. Explicame los conceptos (mediana, promedio, p valor, correlación, etc.) con ejemplos que NO sean de esta base.
4. Si te pido código de R, explicámelo línea por línea. Usá solo estas columnas, que son las que existen: cuenta, texto, fecha, like_count, view_count, comment_count, retweet_count, is_retweet, lang, nosotros.
5. Si no estás seguro de algo, decímelo en lugar de inventar.

El párrafo que quiero revisar es este: "En síntesis, los argentinos confían más en los políticos que en los medios de comunicación, y premian a los dirigentes que hablan en primera persona del singular en lugar de apelar a un colectivo".
Lo que yo creo que está mal es: No hay datos suficientes para inferir eso. Con una muestra de tan poco tiempo y tan pocas cuentas, no es posible sacar ese tipo de conclusiones sobre la categoría “políticos argentinos” o “medios de comunicación”. Esta conclusión es la más peligrosa, ya que generaliza a la totalidad de políticos y medios argentinos.

---

## Claude `2026-10-19T22:16:13.362768Z`

Bien, ya tenés una hipótesis propia, que es el punto de partida que pedías. Antes de seguir, quiero ponerla a prueba con un experimento mental.

Imaginá que el equipo hubiera juntado datos durante cinco años, con 500 medios y 500 políticos argentinos en vez de doce cuentas en tres meses. Con esa base enorme, **¿te parecería que el párrafo pasa a estar bien?** ¿Podrían afirmar entonces que "los argentinos confían más en los políticos"?

Para pensarlo, te sugiero algo que sirve mucho al revisar informes: separar el párrafo en afirmaciones más chicas. Fijate que esa oración dice varias cosas a la vez. ¿Cuántas afirmaciones distintas encontrás? Hacé una lista, aunque te parezca obvia.

Contestame esas dos cosas con tus palabras y desde ahí seguimos.

---

## You `2026-10-19T22:32:26.047564Z`

Primera pregunta: me parece que además de la cantidad de datos, también deberíamos preguntarnos si las métricas pueden ser indicadoras o no de confianza. O sea, seguiría estando incompleto.
Segunda pregunta: Hay dos afirmaciones:

1. "los argentinos confían más en los políticos que en los medios de comunicación"
2. "...premian a los dirigentes que hablan en primera persona del singular en lugar de apelar a un colectivo"

---

## Claude `2026-10-19T22:32:36.016037Z`

Ese giro es importante: pasaste de preguntarte *cuántos* datos hay a preguntarte *qué miden* esos datos. Son dos problemas distintos, y conviene tenerlos separados en tu revisión.

Sigamos ese hilo con la primera afirmación. Mirá las columnas que tiene la base: cuenta, texto, fecha, like_count, view_count, comment_count, retweet_count, is_retweet, lang, nosotros.

1. **Pensá en tu propio uso de redes.** ¿Por qué razones le diste "me gusta" alguna vez a una publicación? Hacé una lista de motivos, y después preguntate cuántos tienen que ver con *confiar* en quien la publicó.

2. **Fijate en el sujeto de la oración: "los argentinos".** Con esas columnas, ¿qué podemos saber sobre *quiénes* dieron esos likes o vistas?

Hay una pista más: dentro de cada una de tus dos afirmaciones quedan otras escondidas. Por ejemplo, "los argentinos" ya es una afirmación en sí misma. Cuando volvamos a la segunda, te voy a preguntar por la palabra "premian" y por cómo se habría medido lo de "primera persona", así que podés ir pensándolo.

Por ahora, contestame las dos preguntas de arriba.

---

## You `2026-10-19T22:36:06.426519Z`

1. Dar un like está más relacionado a que el contenido del a publicación "te resuena de alguna forma", pero no necesariamente porque confíes en el titular de la cuenta.
2. Claro, también al considerar a la población que dió sus likes, estamos desestimando al resto de la población, no solo que no dió likes, sino que no vieron la publicación, que no usan redes sociales o que simplemente no tienen acceso a la tecnología.

---

## Claude `2026-10-19T22:36:17.448395Z`

Agregaste algo con eso: no solo es dudoso qué significa un like, también *quiénes* dan likes no representan a toda la población. Son dos problemas distintos que conviene anotar por separado.

Me queda una pregunta sobre ese punto antes de pasar a la segunda afirmación. Asumiste que los que dieron like son argentinos que usan redes. **¿Hay algo en la base que nos garantice que esas personas son argentinas?** Pensá qué información da la columna `lang` y qué no da. Y pensá si alguien de Uruguay, de España o una cuenta automatizada podría dar like a un político argentino.

Ahora sí, la segunda afirmación: *"premian a los dirigentes que hablan en primera persona del singular en lugar de apelar a un colectivo"*.

En la base hay una columna llamada `nosotros`. No sé exactamente qué contiene: no vi la base ni el informe. Si tenés la descripción de las variables, fijate ahí. Con ese nombre, te pregunto:

1. **¿Qué creés que mide esa columna?** Y si mide eso, ¿alcanza para saber si alguien habló en *primera persona del singular* ("yo")? Pensá qué otras formas de hablar quedan afuera de "usar nosotros o no usarlo".

2. **"Premian"** es un verbo que sugiere algo. Si un político habla en singular y recibe más likes, ¿qué estaría diciendo el informe sobre la relación entre esas dos cosas? ¿Se te ocurre alguna otra razón por la que esas publicaciones podrían tener más likes?

Tomate las tres preguntas con calma; podés contestarlas de a una.

---

## You `2026-10-19T22:45:28.066247Z`

Si, en el análisis se filtran los mensajes en español, pero no se filtran los mensajes por sus originarios. Es probable que personas que no sean argentinas estén incluidas.
La columna nosotros es el resultado de aplicar regex al texto de las tweets. Este es un extracto del código:
patron_nosotros <- "\\b(nosotros|nosotras|nuestro|nuestra|nuestros|nuestras)\\b"
patron_yo       <- "\\b(yo|mi|mí|mis|me|conmigo)\\b"

## El "ellos" lo partimos en dos, porque son dos exogrupos distintos:
## el adversario político y la figura del delincuente.
patron_ellos_politico <- "\\b(casta|kirchnerismo|kirchneristas?|kukas?|zurdos?|golpistas?|corruptos?)\\b"
patron_ellos_delito   <- "\\b(delincuentes?|narcos?|mafias?|chorros?|criminales?)\\b"

propios <- propios |>
  mutate(
    nosotros       = str_detect(texto_limpio, patron_nosotros),
    yo             = str_detect(texto_limpio, patron_yo),
    ellos_politico = str_detect(texto_limpio, patron_ellos_politico),
    ellos_delito   = str_detect(texto_limpio, patron_ellos_delito),
    exclamacion    = str_detect(texto_limpio, "[!¡]")     # [regex] [ ] cualquiera de estos caracteres
  )

## Proporción de publicaciones con cada marcador, por tipo de cuenta.
## across() aplica la misma función a varias columnas a la vez.
propios |>
  group_by(tipo) |>
  summarise(across(nosotros:exclamacion, mean)) |>       # [op] : acá es "de tal columna a tal columna"
  mutate(across(where(is.numeric), \(x) round(x * 100, 1)))

## Lo mismo por cuenta. Lean esta tabla con calma.
por_cuenta <- propios |>
  group_by(tipo, cuenta) |>
  summarise(n = n(), across(nosotros:exclamacion, mean), .groups = "drop") |>
  mutate(across(nosotros:exclamacion, \(x) round(x * 100, 1)))

1. Creo que mide la presencia de una lista curada de palabras, lo cual excluiría todas las formas de expresarse en primera persona que no está en esa lista. También están las columnas de los otros patrones.
2. Premiar asocia el like a algo positivo. También podrían ser bots y no personas.

---

## Claude `2026-10-19T22:45:45.379406Z`

Lo de `lang` lo identificaste: filtrar por idioma no es lo mismo que filtrar por nacionalidad. Y traer el código fue muy útil, porque ahora podemos mirar *cómo* se midió en vez de suponerlo.

Quedate un poco más en el punto 1, porque dijiste algo que se puede llevar más lejos: "excluiría las formas de expresarse en primera persona que no están en la lista". Te propongo dos pruebas con frases inventadas.

**a)** Pasá estas frases mentalmente por los patrones `patron_yo` y `patron_nosotros` y decime qué columna quedaría en `TRUE`:
- "Viajé a Salta y hablé con los productores."
- "Vamos a ganar en octubre."
- "Me parece que nuestra propuesta es la mejor."

Después preguntate qué tiene el español que hace que esto pase tan seguido.

**b)** Con la tercera frase, fijate qué pasa con `yo` y `nosotros` al mismo tiempo. Ahora releé el final del párrafo: *"en lugar de apelar a un colectivo"*. ¿Encaja eso con lo que encontraste?

Sobre el punto 2, en "premian" hay algo más que lo positivo. Te doy un ejemplo de fuera de la base. En un pueblo, las semanas en que más helado se vende son también las semanas con más gente insolada. ¿Diría alguien que el helado *causa* insolación? ¿Qué está pasando ahí?

Con eso en mente, mirá el comentario que dejaron en el código: *"Lo mismo por cuenta. Lean esta tabla con calma."* Imaginá que, de los seis políticos, uno tiene muchísimos más seguidores que el resto y además usa mucho "yo". **¿Qué le pasaría a la comparación "singular vs. colectivo" si juntamos a los seis?**

Andá de a una; empezá por la a) si querés.

---

## You `2026-10-19T22:49:14.045043Z`

a) claro, con el español, se pone la persona en los verbos.
b) claro, en un mismo post se pueden mezclar tanto la primera persona del singular como la del plural. 
Sobre el punto 2, si, está asumiendo causalidad y no correlación.
Claro, el caso extremo del presidente (que utiliza mucho el yo), terminaría desdibujando lo dicho por el resto de políticos.

---

## Claude `2026-10-19T22:49:23.908522Z`

Lo del presidente vale la pena nombrarlo bien. Cuando una cuenta muy grande pesa tanto, ya no sabemos si los likes vienen de *hablar en singular* o de *ser esa persona*. En el ejemplo del helado, el calor explica las dos cosas; acá, ¿qué podría estar explicando a la vez "usa mucho yo" y "recibe muchos likes"?

Ahora te propongo un cierre. Empezaste con una crítica: "faltan datos, se generaliza". En el camino aparecieron varias cosas más:

- qué mide un like,
- quiénes dan likes y si son argentinos,
- cómo se detectó "yo" y "nosotros",
- si singular y plural se excluyen,
- causalidad,
- el peso de una cuenta.

**Reescribí tu crítica del párrafo con todo eso**, como la pondrías en el trabajo. No hace falta que sea larga. Intentá ordenarla: ¿qué problemas son de la *muestra*, cuáles de la *medición* y cuáles de la *conclusión* que se saca? Cuando la tengas, la miramos juntos con preguntas, no con correcciones.

Te dejo algo para después. Si el informe compara likes "promedio" entre políticos y medios, y una cuenta tiene números enormes, ¿te parece que el promedio representa bien al grupo? Si no conocés bien la diferencia entre promedio y mediana, esa es la próxima que vemos, con un ejemplo de fuera de la base.

---

## You `2026-10-19T23:04:06.063370Z`

Bien! La consigna nos pide "Por qué está mal" y "Cómo debería decirlo un informe correcto", así que aprovecho para elaborar eso:
Por qué está mal: Al decir los argentinos, está infiriendo que las cuentas pertenecen a argentinos, cuando lo que se hace es solo filtrar por idioma. Cuando habla de confianza, está infiriendo que dar un like significa confiar, cuando no necesariamente es así; se puede dar un like porque la publicación "te resuena". En la medición de que es primera persona del singular y del plural, se utiliza una lista de palabras incompleta que no termina de cubrir estas categorías; por otro lado en una misma oración pueden aparecer palabras relativas a primera persona del singular y del plural simultáneamente. Por otro lado, la conclusión afirma una causalidad cuando en realidad el estudio es solo de correlación. Además utilizar una muestra tan pequeña no es representativa de las poblaciones mencionadas. Inclusive, al ser una de las cuentas la del presidente, el patrón de su actividad puede eclipsar el del resto.
Cómo debería decirlo un informe correcto: "El uso de palabras que podrían indicar el uso de primera persona en tweets de X, está correlacionado con un diferencial positivo de likes dentro de una misma cuenta".
Respecto al promedio y mediana, si, estoy familiarizado con eso. El código de la cátedra que use para la parte del informe correcto es este:
propios <- propios |>
  group_by(cuenta) |>
  mutate(percentil_likes = percent_rank(like_count)) |>
  ungroup()

## Si no hubiera ninguna relación, las publicaciones CON un marcador y las
## SIN él tendrían en promedio el mismo percentil. (No va a dar exactamente
## 0,5: cuando muchas publicaciones empatan, por ejemplo con 0 likes,
## percent_rank() les da a todas el lugar más bajo, y el promedio baja. Lo
## que importa es la DIFERENCIA entre con y sin.)

marcadores <- c("nosotros", "yo", "ellos_politico", "ellos_delito",
                "exclamacion", "ira")

comparacion <- propios |>
  pivot_longer(all_of(marcadores), names_to = "marcador", values_to = "presente") |>
  group_by(tipo, marcador, presente) |>
  summarise(n = n(), percentil = mean(percentil_likes), .groups = "drop")

comparacion

## pivot_longer() apila las seis columnas TRUE/FALSE en una sola, para poder
## agrupar por marcador. Es pasar de una tabla "ancha" a una "larga".

diferencias <- comparacion |>
  select(-n) |>                                          # [op] - en select(): todas menos ésta
  pivot_wider(names_from = presente, values_from = percentil) |>
  mutate(diferencia = (`TRUE` - `FALSE`) * 100)          # en puntos percentiles

diferencias

---

## Claude `2026-10-19T23:04:25.167791Z`

Quedó bastante completo, y se nota que pasaste de una crítica general a varias críticas concretas. Como acordamos, te devuelvo preguntas, no correcciones.

**Sobre "Por qué está mal"**

1. Escribiste que se infiere que *"las cuentas pertenecen a argentinos"*. Pensá en las doce cuentas: son medios y políticos argentinos. Entonces, ¿de quiénes no sabemos si son argentinos? Releé tu oración y fijate si dice lo que querías decir.

2. El párrafo original tiene una comparación: *"más en los políticos que en los medios"*. ¿Tu crítica dice algo sobre esa comparación en particular? Un medio y un político, ¿tienen el mismo tipo de público y la misma cantidad de seguidores? ¿Qué pasa si comparamos sus likes directamente?

3. Sobre la lista de palabras: si la cátedra agregara cincuenta pronombres más al patrón, ¿se resolvería el caso de "Viajé a Salta"? ¿Tu texto deja claro *por qué* la lista no alcanza?

**Sobre la versión correcta y el código**

4. El código hace `percent_rank(like_count)` **agrupado por cuenta**. Explicame con tus palabras qué gana el análisis con eso. ¿Tiene algo que ver con el problema del presidente que señalaste?

5. En tu frase decís *"primera persona"*. Mirá los marcadores: `nosotros` también es primera persona. ¿De cuál de las dos hablás? Y, ¿ya viste los números de la tabla `diferencias`? ¿Sabés que la diferencia es *positiva* para ese marcador, y si es igual en políticos y en medios?

6. Tu frase no dice a qué cuentas, qué período ni qué publicaciones se refiere. Si alguien la leyera suelta, ¿qué podría creer que se estudió?

Un detalle donde no estoy seguro: en `marcadores` aparece `"ira"`, pero en el fragmento anterior que me pasaste no se crea esa columna. Puede estar definida en otra parte del código de la cátedra. Si no la encontrás, avisame.

Empezá por la que quieras. Si me pasás la salida de `diferencias`, vemos la 5 con los números reales.

---

## You `2026-10-19T23:17:14.216411Z`

1. Buen punto, tengo que aclarar que las cuentas de las que hablo son de los que dieron like.
2. Es cierto, para hacer esa comparación, estamos asumiendo que la audiencia de uno y de otro son las mismas.
3. Claro, como en español los verbos se conjugan con la persona, esa lista se podría hacer infinita.
4. El uso de percentiles dentro de la cuenta es justamente para que una cuenta no contamine a la otra, y para que se pueda ver el efecto dentro del a cuenta.
5. Claro, viendo los resultados, se aplica tanto a singular como plural (ya que los marcadores "yo" y "nosotros" tienen un diferencial positivo. Tanto en políticos como en medios la diferencia es positiva, solo que en políticos es un poco mayor, y en general nosotros es mejor que yo.
6. Claro, debería agregar un "De la muestra de referencia de dos meses de tweets de X, de 12 cuentas, 6 de políticos y 6 de medios de comunicación,..."


Si, lo de ira es porque en otra parte del código se hace un analisis de emociones.

El siguiente problema que me gustaría analizar es:
“Las vistas y los likes tienen una correlación de r = 0,54, lo que significa que las vistas explican el 54% de los likes.”
Yo puse: Por un lado, el “explican” podría implicar que hay una relación de causalidad vistas > like, que la correlación de Pearson no mide. Lo que sí podriamos decir, utilizando el r2 = 0.29, es que el modelo de regresión puede explicar el 29% de la variabilidad de una variable a partir de la otra.

---

## Claude `2026-10-19T23:17:30.472555Z`

Antes de pasar al nuevo párrafo, dos cosas que dejaste en tus respuestas:

- En la 6 escribiste "dos meses". Fijate en el enunciado del trabajo: ¿de qué mes a qué mes es la base?
- En la 5 dijiste que *"en general nosotros es mejor que yo"*. Ahora releé el párrafo original: *"premian a los dirigentes que hablan en primera persona del singular en lugar de apelar a un colectivo"*. ¿Qué relación hay entre lo que encontraste en la tabla y lo que afirma el informe? Eso podría ser la crítica más fuerte de todas, y todavía no está en tu texto.

**Sobre el nuevo párrafo**

Hiciste la cuenta del r². Te propongo cuatro preguntas para ir más hondo:

1. **"Explicar" en estadística.** Buscá cómo llaman los manuales de estadística al r². Si la expresión habitual usa la palabra "explicada", ¿el problema del párrafo está en *usar* el verbo, o en otra parte de la oración?

2. **"El 54% de los likes" vs. "el 29% de la variabilidad".** Pensá en la altura y el peso de un grupo de personas. Si la altura "explica el 30% de la variabilidad del peso", ¿quiere decir que el 30% de los kilos de cada persona se debe a su altura? ¿Qué quiere decir entonces? Intentá explicarlo con tus palabras.

3. **La dirección.** Dijiste que el informe sugiere vistas → likes. En X, ¿se te ocurre algún mecanismo por el que la flecha pueda ir también al revés?

4. **Volvamos al presidente.** Esa correlación, ¿se calculó con todas las publicaciones juntas o dentro de cada cuenta? Imaginá doce puntos-nube, una por cuenta, algunas con números enormes y otras chicas. ¿Qué le puede pasar al r si las juntás? Si no sabés cómo se calculó, mirá el código de la cátedra; si me lo pasás, lo vemos línea por línea.

Empezá por la que quieras.

---

## You `2026-10-19T23:25:08.128412Z`

1. Si, me surgió esa duda, porque se que en estadística se usa la palabra explicar. Pero también sabía que se usa varianza explicada y el r2 (no el r)
2. Podría ser que el 30% de las características de la variabilidad del peso pueden ser escritas en términos de la variabilidad de la altura?
3. Si mucha gente da like a un post, entonces se puede viralizar y generar mas vistas.
4. La correlación se calculó para todas las cuentas. Claro, si la correlación corresponde a la cuenta del presidente, poner todo en la misma bolsa puede provocar que los datos mas chicos se contaminen.

---

## Claude `2026-10-19T23:25:22.510671Z`

En la 1 marcaste algo importante: el término correcto existe, pero se aplica al r², no al r. Con eso en mente, releé tu crítica original. Empezaba por la causalidad. **¿Seguirías poniendo ese argumento primero, o el error central está en otro lado?**

**Sobre la 2.** Tu frase es vaga, y te pasa lo mismo que con el ejemplo: es difícil decirlo sin una imagen concreta. Te explico la idea de "varianza explicada" con otro ejemplo.

Imaginá que tenés que adivinar el peso de personas que no ves. Si no sabés nada de ellas, lo mejor que podés hacer es decir siempre el peso promedio del grupo, y te vas a equivocar bastante. Alguien pesa 50 kg, otro 95 kg. Ahora te dicen la altura de cada uno. Tus adivinanzas mejoran, porque a los altos les decís más y a los bajos menos, pero igual te seguís equivocando. Hay gente alta y flaca, y gente baja y robusta.

El r² dice **cuánto se achicaron tus errores** gracias a conocer la altura, comparado con adivinar a ciegas. Un r² de 0,30 significa que conocer la altura reduce esos errores un 30%. El 70% restante depende de otras cosas: alimentación, músculo, genética, etc.

Con esa imagen, **¿cómo traducirías "r² = 0,29" a una frase sobre vistas y likes**, que entienda alguien sin estadística?

**Sobre la 4.** Vamos un paso más allá. Imaginá que dentro de cada cuenta las vistas y los likes no tuvieran *ninguna* relación: en cada nube los puntos están desparramados sin forma. Pero las cuentas grandes tienen todas sus publicaciones arriba a la derecha (muchas vistas, muchos likes) y las chicas abajo a la izquierda. Si juntás todas las nubes en un solo gráfico, **¿qué forma tendría la nube total, y qué r esperarías?** ¿Qué te dice eso sobre lo que realmente mide un r calculado "con todo en la misma bolsa"?

---

## You `2026-10-19T23:37:07.343248Z`

* Claro, el error principal es usar r en vez de r2 (donde si vale el término varianza explicada).
* Podría ser entonces: que la altura nos permité inferir o reducir el error de la predicción de peso en un 30%?
* Claramente dirían que a mas vistas mas likes y viceversa. Sería un ejemplo de sensibilidad a casos extremos, no?

---

## Claude `2026-10-19T23:37:18.774738Z`

Antes de seguir, tengo que corregirme. Al explicarte el r² simplifiqué de más. Lo que se reduce un 30% no es "el error" tal como lo medirías a ojo (cuántos kilos le errás a cada persona), sino la **varianza** de los errores, que trabaja con los errores *al cuadrado*. En la práctica, el error típico se achica bastante menos que un 30%. Para tu informe alcanza con decir "reduce un 30% la variabilidad no explicada", pero no quiero que te quedes con una versión inexacta por culpa mía.

Dicho eso, en la segunda respuesta reformulaste el ejemplo de la altura, pero yo te había pedido otra cosa: **traducirlo a vistas y likes**. ¿Cómo lo dirías para la base?

**Sobre la tercera.** Pensemos si es lo mismo que un caso extremo.

- En el escenario que te describí, ¿hay *una* publicación rarísima que tira todo? Si borraras la publicación más extrema, ¿desaparecería el patrón? ¿Qué tendrías que sacar para que desaparezca?
- Dijiste que el gráfico conjunto diría "a más vistas, más likes". Pero en mi escenario, dentro de cada cuenta, eso *no pasa*. Entonces, ¿de qué habla realmente esa correlación: de las publicaciones o de las cuentas?

Por último, conectalo con algo que ya explicaste vos: el `percent_rank()` agrupado por cuenta del párrafo anterior. ¿Qué tiene que ver con este problema?

---

## You `2026-10-19T23:42:42.164960Z`

Perfecto!
Claro, en el caso de los likes y de las vistas, el conocer las vistas nos permitiría reducir el error en la predicción de los likes un 30%.
Cierto, no es un outlier porque no se trata de un punto de la base, sino de una cuenta en sí. En este caso es necesario dividir por cuenta para que el comportamiento de una cuenta no afecte al resto.

Siguiente problema:
"Ordenando las cuentas por mediana de likes, Pablo Cococcioni (60) supera holgadamente a Pablo Javkin (7), lo que indica que su estrategia de comunicación es mucho más efectiva."
Yo puse: Si bien las métricas son correctas, decir que la estrategia de comunicación es mucho más efectiva es un poco “estirado”. No sabemos cual es la estrategia de comunicación de cada cuenta (por ejemplo su público objetivo), por lo que no podemos decir cual es más efectiva.

---

## Claude `2026-10-19T23:42:59.170857Z`

Antes del nuevo párrafo, revisá tu frase sobre vistas y likes comparándola con la corrección que te hice recién. ¿Qué es lo que se reduce un 29%? Y fijate el número.

Lo de "no es un outlier, es una cuenta" quedó claro.

**Sobre el párrafo de Cococcioni y Javkin**

1. **"Si bien las métricas son correctas"**: ¿cómo lo sabés? Pensá qué tendrías que chequear antes de confiar en esas medianas. Por ejemplo: ¿se incluyeron los retweets (`is_retweet`)? ¿Cuántas publicaciones tiene cada cuenta? Sobre los retweets no estoy seguro de qué valor de likes guarda la base en esos casos; vale la pena que lo mires en el código o en los datos.

2. **Tamaño de la audiencia.** ¿Hay alguna columna con la cantidad de seguidores de cada cuenta? Si no la hay, ¿qué columna de las que existen te permitiría hacer una comparación más justa que los likes "a secas"? ¿Qué cuenta harías con ella?

3. **El contexto.** ¿Sabés qué cargo tenía cada uno y qué estaba pasando en Rosario y Santa Fe entre marzo y mayo de 2024? Buscalo si no lo tenés presente, y pensá si eso podría explicar la diferencia sin que intervenga ninguna "estrategia".

4. **"Más efectiva"**: ¿efectiva para qué? Si el objetivo de un intendente fuera, por ejemplo, informar cortes de calle o trámites, ¿los likes medirían bien si lo logra?

Tu crítica apunta a que no conocemos la estrategia. Estas preguntas apuntan a que, *aunque la conociéramos*, la comparación tendría otros problemas. Empezá por la que quieras.

---

## You `2026-10-19T23:57:05.744665Z`

Parrafo viejo:
Por qué está mal: Si bien los likes y las vistas tienen esa correlación, al hablar de que una variable explica a la otra, se debe calcular el r cuadrado (coeficiente de determinación), no el r, y además se debe concluir que lo que se explica es la varianza de una variable en terminos de la otra. Además de esto, al calcularlo en general y no por cuenta, el comportamiento de una cuenta con mucha actividad afecta demasiado al cálculo general.
Cómo debería decirlo un informe correcto: “En la base de estudio, el coeficiente de correlación entre vistas y likes es de 0.54. Por otra parte, el coeficiente de determinación R2 es de 0.29, lo cual significa que las vistas explican un 29% de la varianza de los likes y viceversa. Nota: Al incluir cuentas con mucha actividad, el comportamiento de la muestra se asemejará a estas"

Nuevo párrafo:

1. Utilicé el siguiente código:


```
> resumen_cuenta <- propios |>
+   group_by(tipo, cuenta) |>
+   summarise(
+     publicaciones = n(),
+     likes_mediana  = median(like_count),
+     vistas_mediana = median(view_count),
+     vistas_totales = sum(view_count),
+     .groups = "drop"
+   ) |>
+   arrange(desc(vistas_totales))
> resumen_cuenta
# A tibble: 12 × 6
   tipo     cuenta          publicaciones likes_mediana vistas_mediana vistas_totales
   <chr>    <chr>                   <int>         <dbl>          <dbl>          <dbl>
 1 Político javier_milei              287         10119         410523      335188319
 2 Medio    infobae                 22991             5           7311      316002012
 3 Medio    clarin                   7245            10           8132      137655107
 4 Medio    la_nacion                2583            16          13178       67595894
 5 Medio    rosario3_com             5462             4           2494       32581796
 6 Político patricia_bullr…           138          6365         113726       29367020
 7 Medio    diario_la_capi…          6099             2           1430       22471339
 8 Político luis_petri                107          1697          24343        8459682
 9 Medio    el_ciudadano             3289             0            444        2129655
10 Político maximiliano_pu…           109           117           5784        1087041
11 Político pablo_javkin              213             7            249         857162
12 Político pablo_cococcio…             7            60           2414          40046

```

En la base propios, se excluyen retweets.

2. No hay followers. Podríamos utilizar las vistas.
3. En marzo de 2024 Rosario vivió una crisis de Narcoterrorismo. Esto significa que tuvieron likes y vistas simplemente por el contexto y quienes son los dueños de las cuentas y no por lo que hayan hecho?
4. Claro, no hay objetivos.

---

## Claude `2026-10-19T23:57:19.404990Z`

**Sobre el párrafo viejo**, dos preguntas:

- En la nota escribiste *"cuentas con mucha actividad"*. Mirá la tabla que acabás de traer. ¿Qué cuenta tiene más *actividad* (publicaciones)? ¿Y cuál tiene los números más *grandes* por publicación? ¿Son la misma? ¿Cuál de las dos cosas es la que distorsiona la correlación conjunta?
- Tu versión correcta agrega una advertencia. ¿Podría el informe *hacer* algo distinto en lugar de solo advertir? Pensá en lo que hizo la cátedra con `percent_rank()` por cuenta.

**Sobre Cococcioni y Javkin**

1. Ya verificaste lo de los retweets. Ahora mirá la columna `publicaciones` para las dos cuentas que se comparan. ¿Qué te llama la atención? Si tuvieras que estimar el ingreso típico de un barrio, ¿confiarías igual en una mediana calculada con 7 casas que en una calculada con 213?

2. Propusiste usar las vistas. Hacelo con la tabla que ya tenés: dividí la mediana de likes por la mediana de vistas para cada uno de los dos. ¿Qué te da? ¿Sigue habiendo un ganador holgado?
   Una advertencia honesta: dividir dos medianas es una aproximación. Lo más prolijo sería calcular likes/vistas para cada publicación y después sacar la mediana de eso. Si querés, armamos ese código y te lo explico línea por línea.

3. Preguntaste si los likes se deben *simplemente* al contexto y no a lo que hicieron. Dale vuelta: con estos datos, ¿podrías *demostrar* que fue el contexto? Si afirmaras eso, ¿no estarías cometiendo el mismo tipo de error que el informe, pero al revés? ¿Qué podés decir con seguridad sobre el contexto?

---

## You `2026-10-20T01:32:56.798257Z`

1. Es cierto! Javkin pública 30 veces más que Cococcioni. Entiendo que los datos son mucho más representativos con un n más alto. 
2. Claro Javkin tiene muchas más vistas, lo cual podría ser un proxy de cantidad de gente a la que llega.
3. Respecto del contexto, no hay información suficiente para determinar su influencia.

---

## Claude `2026-10-20T01:33:07.266192Z`

En la 1 hiciste bien la cuenta: 213 contra 7 es unas 30 veces. En la 3 llegaste a una formulación prudente que podés usar tal cual en el informe.

**Sobre la 1, un matiz.** Dijiste que con un n más alto los datos son "más representativos". Pensá esto: esas 7 publicaciones, ¿son una *muestra* de lo que Cococcioni publicó entre marzo y mayo, o son *todo* lo que publicó? Si son todas, el problema no es exactamente de representatividad. Entonces, ¿qué problema tiene una mediana calculada con 7 valores? Imaginá que una sola de esas 7 publicaciones hubiera tenido 500 likes en vez de 60. ¿Cuánto cambiaría la mediana? ¿Y con 213 publicaciones?

**Sobre la 2.** Dijiste que Javkin tiene muchas más vistas. Volvé a la tabla y fijate en dos columnas distintas:
- `vistas_mediana` de cada uno
- `vistas_totales` de cada uno

¿Quién gana en cada una? ¿Por qué podrían dar resultados opuestos? Pista: tiene que ver con lo que acabás de descubrir en la 1.

Después hacé la división que te propuse: `likes_mediana / vistas_mediana` para cada uno. ¿Qué número te da cada uno?

Te quedaron pendientes las dos preguntas sobre el párrafo de la correlación (actividad vs. tamaño, y qué podría hacer el informe en vez de solo advertir). Retomalas cuando cierres este.

---

## You `2026-10-20T01:44:00.238262Z`

Párrafo anterior

1. Corregí la parte de actividad por gran cantidad de likes y vistas (que es lo que afecta la métrica).
2. Si, podría hacer los cálculos por cuenta. Pero eso ya estiraría el alcance del trabajo demasiado (hay que tener cuidado hasta cuanto entrar en el "rabbit hole" de las explicaciones. Me gustaría que tengamos en cuenta esto a futuro. No es necesario estirar infinitamente las preguntas, solo cuando sea necesario)


Párrafo actual

1. Como es una muestra de 2 mesess y no la total, no sabemos como se comportó la cuenta antes y/o después. Respecto a la siguiente pregunta, en teoría la mediana debería ser inmune a los valores extremos, no? O sea, que si hay una publicación con muchísimos likes, no debiera cambiar tanto (solo un lugar en el ordenamiento de los valores, aunque en un universo con menos lugares).
2. Claro, perdón, Javkin tiene mas vistas totales, pero su mediana es menor. Dan resultados opuestos por la cantidad de publicaciones. En cuanto a la relacion que me mencionabas Cococcioni esta un poco por debajo que Javkin.

---

## Claude `2026-10-20T01:44:13.351652Z`

Entendido. De ahora en adelante pregunto solo lo necesario para que cada crítica quede sólida, sin abrir temas que excedan el trabajo. Si en algún momento me paso, decímelo.

Dos cosas puntuales sobre el párrafo actual.

**El período.** Es la segunda vez que escribís "2 meses". Revisá el enunciado: marzo a mayo.

**La mediana.** Tu intuición va bien encaminada: un valor extremo no arrastra la mediana como arrastra al promedio. Pero con pocos datos aparece otro problema. Te lo muestro con un ejemplo de fuera de la base.

Siete personas declaran sus ingresos mensuales, en miles:
`200 · 250 · 300 · 900 · 1000 · 1100 · 1200`

La mediana es 900, el valor del medio. Ahora imaginá que la persona que ganaba 300 en realidad ganaba 950. Se reordena así:
`200 · 250 · 900 · 950 · 1000 · 1100 · 1200`

La mediana pasa a 950. Y si en cambio la de 900 ganaba 280, la mediana cae a 300. **Moviendo un solo dato, la mediana salta de 300 a 950.** Con pocos valores puede haber "huecos" grandes entre uno y el siguiente, y cambiar un dato te hace caer en otro lado del hueco. Con 213 valores, los vecinos están mucho más pegados y la mediana se mueve poco.

Con eso, y con la división que hiciste (la relación likes/vistas queda casi igual, incluso un poco por debajo para Cococcioni), ya tenés lo necesario. **Escribí la crítica de este párrafo** con el mismo formato: por qué está mal y cómo debería decirlo un informe correcto.

---

## You `2026-10-20T02:02:55.751754Z`

Perfecto! Escribo:
Por qué está mal: la evidencia que presentan los datos no es suficiente para hacer ese tipo de afirmaciones. En cuanto a la estrategia de comunicación, desconocemos cual es su objetivo y cual es el público al que apunta. En cuanto a los datos, podemos observar que la muestra es muy pequeña para Cococcioni (tan solo 7 tweets), lo cual reduciría la fiabilidad de la métrica calculada.
Cómo debería decirlo un informe correcto: "Para la muestra considerada, la mediana de likes por tweet de Pablo Cococcioni (60) es superior a la de Pablo Javkin (7). Nota: la cantidad de tweets de Pablo Cococcioni es bastante pequeña (7), lo cual podría afectar la fiabilidad de la mediana calculada"

---

## Claude `2026-10-20T02:03:01.243103Z`

Le falta una sola cosa importante, así que te pregunto solo eso.

En el camino hiciste una cuenta que cambia bastante el panorama: la relación likes/vistas. ¿Dónde aparece eso en tu crítica? Pensá qué le pasa a la palabra **"holgadamente"** del párrafo original cuando tenés en cuenta a cuánta gente llega cada uno. Y si tu versión correcta solo informa las medianas de likes, un lector podría sacar la misma conclusión equivocada que el informe. ¿Qué agregarías para evitarlo?

---

## You `2026-10-20T02:14:33.482083Z`

Perfecto! Ahora te paso la versión revisada:
Por qué está mal: la evidencia que presentan los datos no es suficiente para hacer ese tipo de afirmaciones. En cuanto a la estrategia de comunicación, desconocemos cual es su objetivo y cual es el público al que apunta. En cuanto a los datos, podemos observar que la muestra es muy pequeña para Cococcioni (tan solo 7 tweets), lo cual reduciría la fiabilidad de la métrica calculada. También, se excluyen métricas que podrían moderar las conclusiones, como la cantidad de vistas.
Cómo debería decirlo un informe correcto: "Para la muestra considerada, la mediana de likes por tweet de Pablo Cococcioni (60) es superior a la de Pablo Javkin (7). No obstante, si calculamos la razon entre la mediana de likes y la mediana de vistas, la razón de P. Javkin (0.028) resulta ligeramente superior a la de P. Cococcioni (0.024). Nota: la cantidad de tweets de Pablo Cococcioni es bastante pequeña (7), lo cual podría afectar la fiabilidad de la mediana calculada"

Siguiente problema:
"Para estudiar la identidad social en el sentido de Tajfel y Turner, marcamos las publicaciones de los políticos que usan “nosotros”, “nuestro” o sus variantes. Las que lo usan tienen una mediana de 206 likes, contra 3.376 de las que no lo usan (gráfico 2). La prueba t sobre el logaritmo de los likes da p = 0,0025. Como el p valor es menor que 0,05, queda demostrado con un 99,75% de certeza que hablar en clave de “nosotros” provoca que el público castigue a los políticos."
Por que esta mal: Al haber un diferencial positivo en el percentil de likes para los tweets de políticos que tienen el marcador de nosotros, el incluir el marcador está asociado a
efectos positivos sobre los likes de su cuenta (y no al revés).

---

## Claude `2026-10-20T02:14:43.967126Z`

Antes de lo nuevo, revisá la división de Cococcioni: 60 / 2414. ¿Da 0,024?

**Sobre el nuevo párrafo**

Encontraste una contradicción con el resultado por percentiles. Para que tu crítica quede sólida, faltan dos cosas.

1. **¿Por qué dan resultados opuestos?** Si dentro de cada cuenta "nosotros" se asocia a *más* likes, ¿cómo puede ser que, juntando a los seis políticos, las publicaciones con "nosotros" tengan una mediana mucho *menor*? Mirá la tabla de antes: ¿quién aporta los likes más altos? Y pensá qué pasaría si esa persona casi no usara "nosotros". Esto ya lo trabajaste con la correlación, así que no hace falta abrir nada nuevo.

2. **El p valor.** Tu crítica no toca la segunda mitad del párrafo: *"queda demostrado con un 99,75% de certeza"*. ¿Qué entendés vos que significa p = 0,0025? Decímelo con tus palabras y, según lo que respondas, te explico el concepto con un ejemplo de fuera de la base.

---

## You `2026-10-20T02:57:11.620727Z`

1. Me parece que puede ser que por que al juntar todo en una misma bolsa, se pierde el efecto específico del usar nosotros en cada cuenta? Esta es la tabla que estoy viendo:


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

2. El p valor: entiendo que el p-value lo que hace es aceptar/rechazar la hipótesis nula en base un grado de significancia estadística. O sea, que con un  95% de confianza se rechaza la hipótesis nula cuando espero que sea por debajo de 0.05. (Tengo la duda de si puedo estirar esto a 99.75, creo que si). Si me parece equivocado lo de "queda demostrado con certeza"

---

## Claude `2026-10-20T02:57:24.860864Z`

**1. La tabla.** Tu idea va por ahí, pero hay que hacerla concreta: la tabla tiene todo lo que necesitás.

- Fila por fila, compará TRUE contra FALSE dentro de cada político. ¿En cuántos de los seis la mediana con "nosotros" es mayor?
- Ahora mirá la columna `publicaciones`. Entre los posts **sin** "nosotros", ¿qué parte son de Milei y Bullrich? ¿Y entre los posts **con** "nosotros", quiénes aportan la mayoría?

Con esas dos respuestas podés explicar en una oración por qué el resultado se da vuelta al juntar todo.

**2. El p valor.** Te explico el concepto con un ejemplo de fuera de la base.

Sospechás que una moneda está cargada. La hipótesis nula es "la moneda es normal". La tirás 20 veces y salen 17 caras. El p valor responde esta pregunta: **si la moneda fuera normal, ¿qué tan probable sería obtener un resultado tan extremo como 17 caras o más?** Supongamos que da 0,001. Eso quiere decir que, *con una moneda normal*, algo así pasaría muy rara vez.

Fijate el orden: el p valor *supone* que la nula es cierta y calcula la probabilidad de los datos. No calcula la probabilidad de que la nula sea cierta ni la de que tu hipótesis sea cierta. El 0,05 es un umbral que elegís de antemano para decidir; no es una "confianza" sobre la conclusión.

Con eso:

- ¿Se puede pasar de "p = 0,0025" a "99,75% de certeza de que la hipótesis es cierta"?
- Aunque la moneda esté cargada, el p valor no te dice *quién* la cargó ni *por qué*. ¿Qué te dice eso sobre la palabra "provoca" del párrafo?
- Pensá también en el punto 1: si la comparación mezcla cuentas, ¿qué hipótesis nula está poniendo a prueba ese test?

---

## You `2026-10-20T03:09:58.620317Z`

1. Casi todos los políticos mejoran su mediana incluyendo la palabra nosotros. Pero, como Patricia Bullrich y Javier Milei tienen muy pocos tweets con nosotrs y muchos tweets sin, cuando se arma la mediana indiferenciada, terminan tirando la mediana con nosotros para abajo y la mediana sin nosotros para arriba. En este caso hubiera sido mejor usar la media? O que otra métrica?
2. Entiendo que la prueba t simplemente compara si las medianas son iguales o no. Se podría reformular a que podemos afirmar solo con un 0.25% de confianza de que la hipótesis nula sea cierta, por lo que se rechaza la hipótesis nula para el valor de referencia de 5% y por lo tanto las medianas son diferentes. Claramente no hay más inferencia que hacer, solo que la mediana de likes de los posts con nosotros es mas baja que la mediana de likes de los posts sin nosotros.

---

## Claude `2026-10-20T03:10:11.586793Z`

**1.** Revisá el "casi todos": fijate fila por fila si hay alguno donde no se cumpla. El mecanismo que describiste es exactamente el que tenías que encontrar.

Sobre si conviene usar la media: si la usaras, **¿cambiaría quiénes aportan los posts a cada grupo?** Pensá también qué le haría la media a los 9.951 likes de Milei. Y acordate de que ya conocés una solución que ataca justo este problema: la usó la cátedra antes y vos la explicaste.

**2.** Acá hay tres cosas que revisar.

- **¿Medias o medianas?** Buscá en tu apunte qué compara la prueba t.
- **Volvé a la moneda.** Con p = 0,001, ¿eso significa que hay un 0,1% de probabilidad de que la moneda sea normal? Releé qué cosa *supone* el p valor y qué cosa *calcula*. Después mirá tu frase "0,25% de confianza de que la nula sea cierta" y fijate cuál de las dos está describiendo.
- **"No hay más inferencia que hacer"**: el test compara todos los posts con "nosotros" contra todos los posts sin "nosotros", mezclando cuentas. Con lo que descubriste en el punto 1, ¿esa diferencia "significativa" te habla del efecto de usar "nosotros" o de otra cosa?

---

## You `2026-10-20T03:17:08.872762Z`

1. Si, para todos mejora. Claro, el problema es mas bien no separar por cuenta, verdad? Claramente el separar por cuenta y ver el efecto diferencial del uso de nosotros dentro de su percentil de likes es mucho mejor. 
2. Claro, la prueba t es de diferencia entre medias, no? En cuanto al p-value, el 0.25% indicaría la probabilidad de que los "datos" representaran la situación de que la hipótesis nula es cierta (que en este caso no lo es), no es así?. La diferencia significativa habla sobre la diferencia entre medias de likes de las textos de tweets que cumplen con el patron nosotros o no.

---

## Claude `2026-10-20T03:17:21.514324Z`

**1.** Lo sacaste vos de la tabla: comparar dentro de cada cuenta evita que la composición de los grupos decida el resultado.

**2.** Te quedan tres ajustes chicos. Después de eso, ya podés escribir la crítica.

- **Medias, sí, pero ¿de qué?** El párrafo dice que la prueba t se hizo sobre el *logaritmo* de los likes. Cuando lo escribas, ¿qué variable vas a decir que se comparó?

- **El p valor.** Tu frase todavía mezcla las cosas, y además agregaste "(que en este caso no lo es)". ¿El p valor te garantiza que la nula es falsa? Probá completar esta frase, con la misma forma que la de la moneda:
  *"Si ________ fuera cierto, la probabilidad de obtener ________ sería 0,25%."*

- **De qué habla la diferencia.** Dijiste que habla de los tweets con y sin el patrón. Pero en el punto 1 encontraste que el grupo "sin nosotros" está lleno de tweets de Milei y Bullrich. Entonces, ¿la diferencia que detecta el test es entre *tipos de tweet* o entre *quiénes escriben* esos tweets?

Cuando tengas esas tres, escribí la crítica completa con el formato de siempre. Fijate de incluir también "demostrado", "provoca" y "castigar". Y si te parece necesario para el trabajo, sumá si la palabra "nosotros" alcanza para estudiar la identidad social de Tajfel y Turner.

---

## You `2026-10-20T03:34:57.087952Z`

Por qué está mal: la afirmación llega a una conclusión que no se puede desprender de la prueba realizada. Primero, el realizar el cálculo de la mediana sobre el grupo total, habla más de la composición del grupo que del efecto de usar el "nosotros" por parte de cada cuenta. Esto es, P. Bullrich y J. Milei tienen ambos una gran cantidad de tweets sin usar "nosotros" y muy pocos usándolo (A pesar de que sus posts con nosotros tenga una mediana mayor que los sin). Al no diferenciar por cuenta, los pocos posts con nosotros no tienen efecto en el global y los muchos posts sin nosotros sí. Además de esto, la prueba t mide diferencia entre medias, no diferencia entre medianas.
Cómo debería decirlo un informe correcto: "La mediana de los likes de los tweets de políticos que utilizan palabras como 'nosotros' y afines es menor que la mediana de los que no los utilizan. Sin embargo, el efecto de la composición del grupo hace que esta métrica hable más de como escriben las cuentas con una mayor mediana de likes del grupo; no nos permite inferir si el usar 'nosotros' y afines tiene un efecto positivo o no sin antes estudiarlo abierto por cuentas. Al realizar esta apertura, se puede observar como la mediana para cada una de las cuentas aumenta al utilizar 'nosotros' y afines".

---

## Claude `2026-10-20T03:35:05.163561Z`

La parte de composición quedó bien armada. Pero el párrafo original tiene una segunda mitad que tu crítica todavía no toca, así que te quedan tres cosas, nada más.

1. **El p valor.** El informe dice *"queda demostrado con un 99,75% de certeza"*. Tu crítica no lo menciona, y es uno de los errores centrales del párrafo. Completá la frase que te dejé:
   *"Si ________ fuera cierto, la probabilidad de obtener ________ sería 0,25%."*
   Con esa frase resuelta, ¿podés explicar en una oración por qué "99,75% de certeza" está mal?

2. **El grupo "con nosotros".** Escribiste que los pocos posts con "nosotros" de Milei y Bullrich "no tienen efecto en el global". Mirá la tabla: ¿qué cuentas aportan la mayoría de los posts *con* "nosotros", y cuántos likes suelen tener? Eso explica por qué ese grupo queda bajo, no solo por qué el otro queda alto.

3. **Las palabras causales.** El informe dice "provoca" y "castigan". Y tu propia versión correcta cierra con "la mediana *aumenta* al utilizar 'nosotros'". ¿Ese verbo describe una asociación o un efecto? ¿Cómo lo dirías para que no sugiera causalidad?

---

## You `2026-10-20T03:40:35.201594Z`

Por qué está mal: la afirmación llega a una conclusión que no se puede desprender de la prueba realizada. Primero, el realizar el cálculo de la mediana sobre el grupo total, habla más de la composición del grupo que del efecto de usar el "nosotros" por parte de cada cuenta. Esto es, P. Bullrich y J. Milei tienen ambos una gran cantidad de tweets sin usar "nosotros" y muy pocos usándolo (A pesar de que sus posts con nosotros tenga una mediana mayor que los sin). Al no diferenciar por cuenta, los pocos posts con nosotros no tienen efecto en el global (ya que el resto de cuentas posee muy pocos likes comparativamente) y los muchos posts sin nosotros sí. Además de esto, la prueba t mide diferencia entre medias, no diferencia entre medianas; también en vez de usar la expresión "99,75% de certeza", debería decir "si no hubiera diferencia entre usar y no usar nosotros, la probabilidad de obtener medias iguales sería de 0.25%".
Cómo debería decirlo un informe correcto: "La mediana de los likes de los tweets de políticos que utilizan palabras como 'nosotros' y afines es menor que la mediana de los que no los utilizan. Sin embargo, el efecto de la composición del grupo no nos permite inferir si el usar 'nosotros' y afines tiene un efecto positivo o no sin antes estudiarlo abierto por cuentas. Al realizar esta apertura, se puede observar como un aumento de la mediana para cada una de las cuentas se asocia a utilizar 'nosotros' y afines", en oposición de no usarlos.
Por qué está mal: la afirmación llega a una conclusión que no se puede desprender de la prueba realizada. Primero, el realizar el cálculo de la mediana sobre el grupo total, habla más de la composición del grupo que del efecto de usar el "nosotros" por parte de cada cuenta. Esto es, P. Bullrich y J. Milei tienen ambos una gran cantidad de tweets sin usar "nosotros" y muy pocos usándolo (A pesar de que sus posts con nosotros tenga una mediana mayor que los sin). Al no diferenciar por cuenta, los pocos posts con nosotros no tienen efecto en el global (ya que el resto de cuentas posee muy pocos likes comparativamente) y los muchos posts sin nosotros sí. Además de esto, la prueba t mide diferencia entre medias, no diferencia entre medianas; también en vez de usar la expresión "99,75% de certeza", debería decir "si no hubiera diferencia entre usar y no usar nosotros, la probabilidad de obtener medias iguales sería de 0.25%".
Cómo debería decirlo un informe correcto: "La mediana de los likes de los tweets de políticos que utilizan palabras como 'nosotros' y afines es menor que la mediana de los que no los utilizan. Sin embargo, el efecto de la composición del grupo no nos permite inferir si el usar 'nosotros' y afines tiene un efecto positivo o no sin antes estudiarlo abierto por cuentas. Al realizar esta apertura, se puede observar como un aumento de la mediana para cada una de las cuentas se asocia a utilizar 'nosotros' y afines", en oposición de no usarlos.

---

## Claude `2026-10-20T03:40:42.723119Z`

Te llegó el texto duplicado, pero las dos copias son iguales, así que no hay problema.

Me queda una sola pregunta, y es sobre la frase del p valor: *"la probabilidad de obtener medias iguales sería de 0.25%"*.

Volvé a la moneda. Si la moneda fuera normal, ¿el 0,001 era la probabilidad de sacar *10 caras de 20*, es decir, el resultado "parejo"? ¿O era la probabilidad de sacar algo tan extremo como lo que observaste?

Con eso, revisá qué va en el segundo hueco de tu frase. Y ya que la corregís, acordate de que las medias que compara el test son las del *logaritmo* de los likes.

---

## You `2026-10-20T03:40:47.639627Z`

Por qué está mal: la afirmación llega a una conclusión que no se puede desprender de la prueba realizada. Primero, el realizar el cálculo de la mediana sobre el grupo total, habla más de la composición del grupo que del efecto de usar el "nosotros" por parte de cada cuenta. Esto es, P. Bullrich y J. Milei tienen ambos una gran cantidad de tweets sin usar "nosotros" y muy pocos usándolo (A pesar de que sus posts con nosotros tenga una mediana mayor que los sin). Al no diferenciar por cuenta, los pocos posts con nosotros no tienen efecto en el global (ya que el resto de cuentas posee muy pocos likes comparativamente) y los muchos posts sin nosotros sí. Además de esto, la prueba t mide diferencia entre medias, no diferencia entre medianas; también en vez de usar la expresión "99,75% de certeza", debería decir "si no hubiera diferencia entre usar y no usar nosotros, la probabilidad de obtener medias iguales sería de 0.25%".
Cómo debería decirlo un informe correcto: "La mediana de los likes de los tweets de políticos que utilizan palabras como 'nosotros' y afines es menor que la mediana de los que no los utilizan. Sin embargo, el efecto de la composición del grupo no nos permite inferir si el usar 'nosotros' y afines tiene un efecto positivo o no sin antes estudiarlo abierto por cuentas. Al realizar esta apertura, se puede observar como un aumento de la mediana para cada una de las cuentas se asocia a utilizar 'nosotros' y afines", en oposición de no usarlos.

---

## Claude `2026-10-20T03:40:51.031081Z`

Esta es la misma versión que me mandaste recién; parece que el mensaje se reenvió. La frase del p valor sigue igual: *"la probabilidad de obtener medias iguales sería de 0.25%"*.

Te dejo la pregunta de nuevo: con la moneda normal, ¿el 0,001 era la probabilidad de un resultado *parejo* (10 caras de 20), o de un resultado *tan extremo como el que observaste*? Con eso, corregí el segundo hueco. Recordá también que las medias son del logaritmo de los likes.

---

## You `2026-10-20T03:45:28.098799Z`

A ver ahora:
Por qué está mal: la afirmación llega a una conclusión que no se puede desprender de la prueba realizada. Primero, el realizar el cálculo de la mediana sobre el grupo total, habla más de la composición del grupo que del efecto de usar el "nosotros" por parte de cada cuenta. Esto es, P. Bullrich y J. Milei tienen ambos una gran cantidad de tweets sin usar "nosotros" y muy pocos usándolo (A pesar de que sus posts con nosotros tenga una mediana mayor que los sin). Al no diferenciar por cuenta, los pocos posts con nosotros no tienen efecto en el global (ya que el resto de cuentas posee muy pocos likes comparativamente) y los muchos posts sin nosotros sí. Además de esto, la prueba t mide diferencia entre medias (en este caso del logaritmo de los likes), no diferencia entre medianas; también en vez de usar la expresión "99,75% de certeza", debería decir "si las medias fueran iguales, la probabilidad de obtener esta diferencia entre entre usar y no usar nosotros sería de 0.25%".
Cómo debería decirlo un informe correcto: "La mediana de los likes de los tweets de políticos que utilizan palabras como 'nosotros' y afines es menor que la mediana de los que no los utilizan. Sin embargo, el efecto de la composición del grupo no nos permite inferir si el usar 'nosotros' y afines tiene un efecto positivo o no sin antes estudiarlo abierto por cuentas. Al realizar esta apertura, se puede observar como un aumento de la mediana para cada una de las cuentas se asocia a utilizar 'nosotros' y afines", en oposición de no usarlos.

---

## Claude `2026-10-20T03:45:32.058262Z`

Te queda un único detalle, chico. En la moneda, el p valor era la probabilidad de sacar 17 caras *o más*, no exactamente 17. ¿Qué le agregarías a "obtener esta diferencia" para que diga lo mismo?

Con ese ajuste, no tengo más preguntas sobre este párrafo. Cuando quieras, pasamos al siguiente.

---

## You `2026-10-20T03:47:00.003288Z`

Pero esta no es una prueba de diferencia de medias? No una prueba de si es mayor o menor?

---

## Claude `2026-10-20T03:47:07.840373Z`

Buena pregunta, porque hay dos cosas distintas que se confunden fácil.

- **Dirección**: preguntar si A es mayor que B, o B mayor que A.
- **Tamaño**: preguntar qué tan grande es la diferencia, sin importar para qué lado va.

El "o más" se refiere al **tamaño**, no a la dirección. Volvamos a la moneda. Si tu pregunta es solo "¿está cargada?", sin importar hacia qué lado, el p valor es la probabilidad de un resultado *tan desparejo o más* que el tuyo. Eso incluye 17 o más caras y también 17 o más cecas (3 caras o menos). Esa es una prueba de dos colas: mira los dos extremos.

Con la prueba t pasa lo mismo. Aunque no pregunte por la dirección, el p valor es la probabilidad de obtener una diferencia **igual o mayor que la observada, para cualquiera de los dos lados**, si las medias fueran iguales.

No sé con certeza cómo hizo la prueba el informe. En R, `t.test()` es de dos colas por defecto, así que es lo más probable. Si en el código aparece `alternative = "less"` o `"greater"`, avisame, porque eso cambiaría la frase.

Con esto, ¿cómo quedaría tu frase del p valor?

---

## You `2026-10-20T03:49:22.281007Z`

Si, es t.test(). Ahora:
Por qué está mal: la afirmación llega a una conclusión que no se puede desprender de la prueba realizada. Primero, el realizar el cálculo de la mediana sobre el grupo total, habla más de la composición del grupo que del efecto de usar el "nosotros" por parte de cada cuenta. Esto es, P. Bullrich y J. Milei tienen ambos una gran cantidad de tweets sin usar "nosotros" y muy pocos usándolo (A pesar de que sus posts con nosotros tenga una mediana mayor que los sin). Al no diferenciar por cuenta, los pocos posts con nosotros no tienen efecto en el global (ya que el resto de cuentas posee muy pocos likes comparativamente) y los muchos posts sin nosotros sí. Además de esto, la prueba t mide diferencia entre medias (en este caso del logaritmo de los likes), no diferencia entre medianas; también en vez de usar la expresión "99,75% de certeza", debería decir "si las medias fueran iguales, la probabilidad de obtener esta diferencia o una mayor entre entre usar y no usar nosotros sería de 0.25%".
Cómo debería decirlo un informe correcto: "La mediana de los likes de los tweets de políticos que utilizan palabras como 'nosotros' y afines es menor que la mediana de los que no los utilizan. Sin embargo, el efecto de la composición del grupo no nos permite inferir si el usar 'nosotros' y afines tiene un efecto positivo o no sin antes estudiarlo abierto por cuentas. Al realizar esta apertura, se puede observar como un aumento de la mediana para cada una de las cuentas se asocia a utilizar 'nosotros' y afines", en oposición de no usarlos.

---

## Claude `2026-10-20T03:49:24.411251Z`

No tengo más preguntas sobre este párrafo. Solo corregí un detalle de tipeo: en la frase del p valor quedó "entre entre".

Cuando quieras, pasame el siguiente párrafo junto con lo que pensás vos.

---

## You `2026-10-20T03:54:23.838965Z`

![1792468448040_image.png](https://claude.ai/api/c757f196-f5c8-4adb-893e-dd194ea76898/files/deb9140f-f67b-4f1f-86e1-97ff7f6e2c53/preview)

Perfecto! Siguiente problema. Este es de gráficos (así que lo adjunto).
Lo que puse: Al haber múltiples categorías, el grafico de torta no es el ideal.
Además no está ordenado de mayor a menor y no hay tanto contraste entre las porciones.

---

## Claude `2026-10-20T03:54:33.402421Z`

Antes de opinar sobre un gráfico, conviene saber qué quería mostrar. ¿El informe dice algo sobre el Gráfico 1, o lo usa para sostener alguna afirmación? Si hay un texto que lo acompaña, pasámelo. Mientras tanto, dos preguntas:

1. **¿Qué mide cada porción?** Imaginá que le mostrás el gráfico a alguien que no vio el código. ¿Puede saber si las porciones son publicaciones, likes o vistas? ¿Qué le falta al gráfico para que se entienda?

2. **Buscá en la torta las porciones de Cococcioni, Javkin y Pullaro.** ¿Las podés distinguir? Y mirando la leyenda, ¿cómo sabe el lector cuáles cuentas son medios y cuáles son políticos? Pensá si eso importa en una base que se armó justamente para comparar esos dos grupos.

---

## You `2026-10-20T04:02:35.497530Z`

Ahí va la descripción que lo mencionaba "Los medios de comunicación concentran 98 de cada 100 publicaciones propias. Infobae es, por lejos, la cuenta que más publica, con 22.991 publicaciones en el período (gráfico 1)."
Claramente le falta un título. 
Claramente tampoco se distingue si son medios o políticos. 
Me quedó la duda de si los colores eran buenos o no, pero me imagino que si me cuesta a mi, probablemente no sea bueno utilizar esos colores.
Reformulo:
Por qué está mal: el gráfico no tiene título, por lo cual no se sabe que mide. Tampoco está bien seleccionado, ya que posee demasiadas categorías para un gráfico de tortas. No está ordenado de mayor a menor y los colores no permiten un buen contraste. Además, teniendo en cuenta que el análisis hace énfasis en diferenciar medios de comunicación de políticos, sería util tener esta distinción.
Cómo debería mostrarlo un informe correcto: Utilizaría dos gráficos de barra, uno al lado del otro, con diferentes escalas, separando medios de comunicación con políticos, con colores más contrastantes (por ejemplo rojo para medios y azul para políticos), ordenadas las barras de mayor a menor y con el título "Publicaciones por cuenta", con dos subtítulos: "Medios de Comunicación" y "Políticos".

---

## Claude `2026-10-20T04:02:45.167738Z`

Tu propuesta resuelve varios problemas a la vez. Te queda una pregunta, y viene del texto que acompaña al gráfico.

El párrafo dice que **los medios concentran 98 de cada 100 publicaciones**. Imaginá tus dos gráficos de barras lado a lado, cada uno **con su propia escala**. En el de políticos, la barra de Milei llega hasta arriba de todo, igual que la de Infobae en el de medios. ¿Un lector que mire tu gráfico se daría cuenta de esa diferencia de 98 a 2? ¿Qué tendrías que cambiar para que se vea?

Aparte, una tarea rápida. Ya tenés la tabla con las publicaciones por cuenta: sumá las de medios y las de políticos, y fijate si el "98 de cada 100" del texto es correcto. Es un chequeo de dos minutos, pero es justo el tipo de error que el trabajo te pide buscar.

---

## You `2026-10-20T04:10:04.965515Z`

Es cierto! Reformulo:
Por qué está mal: el gráfico no tiene título, por lo cual no se sabe que mide. Tampoco está bien seleccionado, ya que posee demasiadas categorías para un gráfico de tortas. No está ordenado de mayor a menor y los colores no permiten un buen contraste. Además, teniendo en cuenta que el texto que menciona el gráfico hace énfasis en diferenciar medios de comunicación de políticos, esa distinción no se puede observar.
Cómo debería mostrarlo un informe correcto: Utilizaría dos gráficos: uno de torta y otro de barras horizontales. En el de torta, mostraría la diferencia del 98/2 con colores más contrastantes (por ejemplo rojo para medios y azul para políticos) y con el título "Comparación de cantidad de publicaciones entre medios de comunicación y políticos". En el de barras la cantidad de publicaciones de los medios de comunicación, ordenadas las barras de mayor a menor y con el título "Publicaciones por cuenta en medios de comunicación".

---

## Claude `2026-10-20T04:10:08.332814Z`

No tengo más preguntas sobre el gráfico. Solo me falta saber una cosa: ¿hiciste la suma? ¿Te dio el 98 de cada 100 que dice el texto?

---

## You `2026-10-20T04:12:47.615495Z`

Si, fui al script y ejecuté:
resumen_tipo <- propios |>
  group_by(tipo) |>
  summarise(
    publicaciones  = n(),
    participacion  = n() / nrow(propios),           # [op] / división
    likes_mediana  = median(like_count),
    likes_promedio = mean(like_count)
  )
resumen_tipo
Resultados:

```
> resumen_tipo
# A tibble: 2 × 5
  tipo     publicaciones participacion likes_mediana likes_promedio
  <chr>            <int>         <dbl>         <dbl>          <dbl>
1 Medio            47669        0.982              4           46.8
2 Político           861        0.0177          1918         7304. 
```

---

## Claude `2026-10-20T04:12:50.952273Z`

Con esa tabla quedó verificado: 0,982 son 98 de cada 100, así que el número del texto coincide con los datos. Es bueno que lo hayas chequeado antes de darlo por cierto.

Cuando quieras, seguimos con el próximo párrafo.

---

