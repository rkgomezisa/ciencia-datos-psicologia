# =============================================================================
# TALLER DE CIENCIA DE DATOS Y PSICOLOGÍA
# Script 2. Procesamiento de lenguaje natural: de contar palabras a modelar
#          temas, con una pregunta de psicología social
#
# Datos: df_trabajo_1.csv (la misma base del script 1: publicaciones de X de
#        seis medios y seis políticos, marzo a mayo de 2024)
#
# Cómo usar este archivo:
#   Igual que el script 1: de arriba hacia abajo, con Ctrl+Enter
#   (Cmd+Enter en Mac). Está ordenado en NIVELES que van de lo más simple a
#   lo más complejo. Cada nivel usa lo del anterior, así que no conviene
#   saltearse ninguno la primera vez.
#
#   Las marcas [op] señalan operadores, como en el script 1.
#   Las marcas [regex] señalan símbolos de "expresiones regulares", que son
#   el idioma para describir patrones de texto. Están todos juntos en la
#   sección 11. Búsquenlos con Ctrl+F.
#
# Este archivo está guardado en UTF-8. Si ven caracteres raros en los
# acentos, en RStudio: File > Reopen with Encoding > UTF-8.
# =============================================================================


# -----------------------------------------------------------------------------
# 0. PREPARACIÓN
# -----------------------------------------------------------------------------

# Además del tidyverse, este script usa cuatro paquetes nuevos. Se instalan
# UNA vez, con internet. Después, vuelvan a comentar la línea.
#
#   tidytext     convierte textos en tablas de palabras, para trabajarlas
#                con las mismas funciones del script 1
#   stopwords    listas de "palabras vacías" (de, la, que, el...) en
#                muchos idiomas
#   syuzhet      trae adentro un léxico de emociones en castellano, así que
#                no hay que bajar nada más
#   topicmodels  el modelo de tópicos (LDA) del nivel 7
#
# install.packages(c("tidyverse", "tidytext", "stopwords", "syuzhet", "topicmodels"))

library(tidyverse)
library(tidytext)
library(topicmodels)

# stopwords y syuzhet no los cargamos con library(): vamos a usar una sola
# función de cada uno, y la llamamos con  paquete::función(). Así queda a la
# vista de dónde sale cada cosa.                                    # [op] ::

# Igual que en el script 1: el CSV tiene que estar en la misma carpeta que
# este archivo. Si da error, Session > Set Working Directory > To Source
# File Location.
getwd()


# -----------------------------------------------------------------------------
# 1. LA PREGUNTA
# -----------------------------------------------------------------------------
#
# ¿Hablar en términos de "nosotros" y de "ellos" genera más repercusión?
#
# La teoría de la identidad social (Tajfel y Turner, 1979) sostiene que
# buena parte de cómo nos pensamos depende de los grupos a los que sentimos
# que pertenecemos, y que esa pertenencia se construye por contraste con un
# exogrupo: un "ellos". En redes sociales, Rathje, Van Bavel y van der Linden
# (2021, PNAS) analizaron millones de publicaciones de Facebook y Twitter
# en Estados Unidos y encontraron que las palabras que nombraban al grupo
# político rival eran el predictor más fuerte de que una publicación se
# compartiera, más fuerte que las palabras de emoción.
#
# ¿Pasa algo parecido en nuestra base? Vamos a buscarlo con herramientas
# cada vez más potentes:
#
#   Nivel 1  El texto como cadena de caracteres: limpiar y detectar
#   Nivel 2  Un diccionario propio: nosotros, yo, ellos
#   Nivel 3  De textos a palabras: tokenizar y contar
#   Nivel 4  Un léxico de emociones prestado
#   Nivel 5  Volver a la pregunta: ¿se asocia con la repercusión?
#   Nivel 6  tf-idf: qué palabras son propias de cada cuenta
#   Nivel 7  Modelo de tópicos (LDA): de qué se habla, sin decirle de qué
#
# Una advertencia desde el principio:
# en cada nivel vamos a tomar decisiones (qué palabra cuenta como "ellos",
# qué palabra es "vacía", cuántos temas hay) y el resultado va a depender de
# esas decisiones. Una técnica no reemplaza al marco teórico: lo ejecuta.


# -----------------------------------------------------------------------------
# 2. CARGAR Y PREPARAR (lo mismo que en el script 1, en versión corta)
# -----------------------------------------------------------------------------

datos <- read_csv(
  "df_trabajo_1.csv",
  col_types = cols(
    .default             = col_guess(),
    id                   = col_character(),
    account_id           = col_character(),
    conversation_id      = col_character(),
    in_reply_to_tweet_id = col_character(),
    quoted_tweet_id      = col_character(),
    `.id`                = col_character()
  )
)

# La etiqueta medio / político, con el diccionario del script 1.
diccionario <- tribble(
  ~cuenta,                ~tipo,
  "infobae",              "Medio",
  "clarin",               "Medio",
  "la_nacion",            "Medio",
  "diario_la_capital",    "Medio",
  "rosario3_com",         "Medio",
  "el_ciudadano",         "Medio",
  "javier_milei",         "Político",
  "patricia_bullrich",    "Político",
  "luis_petri",           "Político",
  "maximiliano_pullaro",  "Político",
  "pablo_javkin",         "Político",
  "pablo_cococcioni",     "Político"
)

# Publicaciones propias (no retuits) y en castellano. Para analizar CÓMO
# habla cada cuenta, los retuits no sirven: son palabras de otro.
# row_number() le pone a cada publicación un número de identificación. Lo
# vamos a necesitar para volver a juntar las palabras con su publicación.

propios <- datos |>
  rename(cuenta = nombre_normalizado, texto = description, fecha = `.fecha`) |>
  left_join(diccionario, by = "cuenta") |>
  filter(is_retweet == FALSE, lang == "es") |>
  mutate(id_post = row_number()) |>
  select(id_post, cuenta, tipo, fecha, texto,
         like_count, retweet_count, comment_count, view_count)

  
propios |> count(tipo, cuenta)

# Primera sorpresa, y conviene verla antes de seguir. De las más de 6.000
# publicaciones de Milei en la base, sólo 287 son propias: el resto son
# retuits. Del lado de los políticos quedan 861 publicaciones, contra más de
# 47.000 de medios, y Cococcioni aporta 7. Todo lo que digamos de "los
# políticos" descansa sobre pocas cuentas y pocos textos.


# -----------------------------------------------------------------------------
# 3. NIVEL 1. EL TEXTO ES UNA CADENA DE CARACTERES
# -----------------------------------------------------------------------------
#
# Para R, un texto es una "cadena" (string): una fila de caracteres. No sabe
# qué es una palabra ni qué significa. Todo lo que hagamos sobre el texto lo
# vamos a hacer con funciones que empiezan con str_ (del paquete stringr,
# que viene con el tidyverse).

# Miremos tres textos reales antes de tocar nada.
propios |> filter(cuenta == "patricia_bullrich") |> pull(texto) |> head(3)

# pull() saca una columna como vector suelto, para leerla cómoda.


## Medir ---------------------------------------------------------------------

# str_length() cuenta caracteres. str_count() cuenta cuántas veces aparece
# un patrón. "\\w+" quiere decir "una o más letras o números seguidos", que
# es una aproximación razonable a "una palabra".
propios <- propios |>
  mutate(
    caracteres = str_length(texto),
    palabras   = str_count(texto, "\\w+")                 # [regex] \\w  +
  )

propios |> with(cor.test(like_count, caracteres))

propios |>
  group_by(tipo) |>
  summarise(caracteres_mediana = median(caracteres),
            palabras_mediana   = median(palabras))

# Por qué dos barras en "\\w": dentro de las comillas de R, la barra
# invertida ya significa algo, así que para que le llegue UNA barra a la
# expresión regular hay que escribir DOS. Es la fuente de errores número uno
# con texto en R. Si algo no anda, revisen las barras.


## Limpiar -------------------------------------------------------------------

# Los enlaces (https://t.co/...) y las menciones (@usuario) no son palabras
# del autor: son direcciones. Las sacamos. Y pasamos todo a minúsculas,
# para que "Nosotros" y "nosotros" sean la misma cosa.
propios <- propios |>
  mutate(
    texto_limpio = texto |>
      str_to_lower() |>
      str_remove_all("https?://\\S+") |>                  # [regex] ?  \\S
      str_remove_all("@\\w+")
  )

# Leído en castellano:  "https?://\\S+"  es "http, una s optativa, ://, y
# después cualquier cosa que no sea un espacio, todas las veces que haga
# falta". O sea: un enlace entero, hasta el próximo espacio.

# Siempre comparar el antes y el después:
propios |> select(texto, texto_limpio) |> slice_sample(n = 3)


## Detectar ------------------------------------------------------------------

# str_detect() pregunta si un texto contiene un patrón. Devuelve TRUE o
# FALSE, y por eso se puede usar dentro de filter() o de mutate().
propios |>
  filter(str_detect(texto_limpio, "nosotros")) |>
  select(cuenta, texto) |>
  head(5)

# ¿Qué proporción de publicaciones de cada tipo dice "nosotros"?
# mean() de una columna TRUE/FALSE da la proporción de TRUE, porque R
# cuenta TRUE como 1 y FALSE como 0. Es un truco que se usa todo el tiempo.
propios |>
  group_by(tipo) |>
  summarise(dice_nosotros = mean(str_detect(texto_limpio, "nosotros")))

# Dos de cada cien publicaciones de políticos, y dos de cada mil de medios.
# Y fíjense en las de medios que imprimimos arriba: el "nosotros" está entre
# comillas. Es la voz de otro citada en un titular ("Son ellos o
# nosotros", dijo Milei). str_detect() no distingue quién habla. Nosotros sí.


# -----------------------------------------------------------------------------
# 4. NIVEL 2. UN DICCIONARIO PROPIO: NOSOTROS, YO, ELLOS
# -----------------------------------------------------------------------------
#
# Buscar sólo "nosotros" es muy pobre: casi nadie escribe "nosotros", se
# escribe "nuestra provincia". Armamos patrones que juntan varias formas.
#
# Esto es EXACTAMENTE lo que hacía el case_when del script 1: etiquetar con
# reglas escritas por nosotros. La diferencia es que ahora la regla mira el
# texto. Y es igual de teórica: decidir qué palabras cuentan como "ellos"
# es decidir qué es un exogrupo.

# [regex]  \\b   borde de palabra: que "mi" no encuentre "Milei" ni "mismo"
# [regex]  |     "o": cualquiera de las alternativas
# [regex]  ( )   agrupa las alternativas
# [regex]  s?    la s es optativa: encuentra singular y plural

patron_nosotros <- "\\b(nosotros|nosotras|nuestro|nuestra|nuestros|nuestras)\\b"
patron_yo       <- "\\b(yo|mi|mí|mis|me|conmigo)\\b"

# El "ellos" lo partimos en dos, porque son dos exogrupos distintos:
# el adversario político y la figura del delincuente.
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

propios |> 
  filter(tipo == "Político", nosotros = TRUE) |> 
  summarise(mediana_likes = mean(like_count))

# Proporción de publicaciones con cada marcador, por tipo de cuenta.
# across() aplica la misma función a varias columnas a la vez.
propios |>
  group_by(tipo) |>
  summarise(across(nosotros:exclamacion, mean)) |>       # [op] : acá es "de tal columna a tal columna"
  mutate(across(where(is.numeric), \(x) round(x * 100, 1)))

# Lo mismo por cuenta. Lean esta tabla con calma.
por_cuenta <- propios |>
  group_by(tipo, cuenta) |>
  summarise(n = n(), across(nosotros:exclamacion, mean), .groups = "drop") |>
  mutate(across(nosotros:exclamacion, \(x) round(x * 100, 1)))

por_cuenta

# QUÉ SE VE (en porcentaje de publicaciones de cada cuenta):
#
# 1) Los medios casi no usan ninguno de estos marcadores, y los políticos
#    sí. Pero ojo: eso es sobre todo un efecto de GÉNERO DISCURSIVO. Un
#    titular se escribe en tercera persona; un político habla en primera.
#    Comparar medios con políticos en esto es comparar titulares con
#    discursos, no dos psicologías.
#
# 2) Lo interesante está ADENTRO de los políticos, que no construyen la
#    identidad de la misma manera:
#      - Pullaro usa el "nosotros" en 6 de cada 10 publicaciones ("nuestra
#        provincia"): un nosotros institucional, de gestión.
#      - Bullrich nombra al "ellos" delictivo en 3 de cada 10 (narcos,
#        mafias, delincuentes): un exogrupo construido desde la seguridad.
#      - Milei casi no dice "nosotros" (menos de 5 de cada 100), usa el "yo"
#        en 1 de cada 10 y signos de exclamación en 1 de cada 5. Un estilo
#        personalista, y el que más nombra al adversario político ("casta",
#        "kirchnerismo"), seguido de cerca por Petri.
#    Tres formas distintas de construir un "nosotros contra ellos". Recuerden
#    que son cuentas con entre 100 y 300 publicaciones propias: describen a
#    estas cuentas en estos dos meses, no a "los políticos".


## La trampa: un patrón que parece bueno y no lo es --------------------------

# El "nosotros" también está en los verbos: "vamos", "trabajamos",
# "estamos". Una idea tentadora es buscar toda palabra terminada en -amos.
#
# str_extract_all() devuelve las palabras que encontró, no sólo TRUE/FALSE.
# unlist() las aplana en una sola lista para poder contarlas.
terminadas_en_amos <- propios$texto_limpio |>
  str_extract_all("\\b\\w+amos\\b") |>
  unlist()

tibble(palabra = terminadas_en_amos) |> count(palabra, sort = TRUE) |> print(n = 30)

# Ahí aparecen "reclamos", "ramos", "tramos", "gramos", "préstamos":
# sustantivos que terminan en -amos y no tienen nada de primera persona.
# El patrón era razonable y está mal. La única manera de enterarse es LEER
# lo que el patrón encontró. Ninguna función avisa.
#
# Regla de oro de todo este script: cada vez que una máquina clasifica
# textos, miren una muestra de lo que clasificó.

propios |>
  filter(ellos_delito) |>
  select(cuenta, texto) |>
  slice_sample(n = 5)


# -----------------------------------------------------------------------------
# 5. NIVEL 3. DE TEXTOS A PALABRAS: TOKENIZAR
# -----------------------------------------------------------------------------
#
# Hasta acá cada fila era una publicación. Para contar palabras necesitamos
# otra forma: una fila por cada palabra de cada publicación. Partir un texto
# en unidades se llama TOKENIZAR, y cada unidad es un TOKEN.
#
# unnest_tokens(nombre_nueva_columna, columna_de_texto)
# Además de partir, pasa a minúsculas y saca la puntuación.

palabras <- propios |>
  select(id_post, cuenta, tipo, texto_limpio) |>
  unnest_tokens(palabra, texto_limpio)

nrow(propios)    # publicaciones
nrow(palabras)   # palabras: la tabla se hizo mucho más larga

palabras |> head(10)

# Las palabras más frecuentes...
palabras |> count(palabra, sort = TRUE) |> head(15)

# ...son "de", "la", "el", "en", "que". Dicen mucho del castellano y nada de
# estas cuentas. Se llaman PALABRAS VACÍAS (stopwords) y se sacan.


## Sacar palabras vacías -------------------------------------------------------

vacias_estandar <- stopwords::stopwords("es")
length(vacias_estandar)
head(vacias_estandar, 20)

# La lista estándar no alcanza. En este corpus hay muletillas de titular
# ("tras", "cómo", "video", "mirá") y palabras muy generales que dominan
# todo sin decir nada. Esta lista la armamos nosotros mirando los
# resultados, y es una decisión: otro equipo haría otra.
vacias_propias <- c(
  "tras", "cómo", "qué", "quién", "dónde", "cuándo", "según", "así",
  "año", "años", "día", "días", "semana", "hoy", "ayer", "ahora", "mañana",
  "tarde", "noche", "marzo", "abril", "mayo",
  "dos", "tres", "cuatro", "mil", "millones", "primer", "primera", "gran",
  "nuevo", "nueva", "nuevos", "ser", "hacer", "ver", "dijo", "dice",
  "puede", "hace", "tiene", "tienen", "fue", "son", "está", "están", "era",
  "van", "va", "cada", "vez", "solo", "sólo", "después", "antes",
  "mientras", "además", "acá", "aquí", "video", "fotos", "foto", "mirá",
  "conocé", "enterate", "rosario3", "vía", "uno", "una"
)

vacias <- tibble(palabra = unique(c(vacias_estandar, vacias_propias)))

# anti_join() es el opuesto de left_join(): se queda con las filas de la
# izquierda que NO tienen pareja en la derecha. O sea, saca las vacías.
palabras_utiles <- palabras |>
  anti_join(vacias, by = "palabra") |>
  filter(!str_detect(palabra, "[0-9]"),                 # [op] ! negación   [regex] [0-9] un dígito
         str_length(palabra) > 2)

palabras_utiles |> count(palabra, sort = TRUE) |> head(20)


## Comparar medios y políticos -----------------------------------------------

# Como los medios tienen 50 veces más texto, comparar conteos no sirve:
# comparamos qué PROPORCIÓN de las palabras de cada grupo es cada palabra.
frecuencias <- palabras_utiles |>
  count(tipo, palabra) |>
  group_by(tipo) |>
  mutate(proporcion = n / sum(n)) |>
  slice_max(proporcion, n = 15) |>
  ungroup()

colores <- c("Medio" = "#00345E", "Político" = "#B4472C")

g1 <- ggplot(frecuencias,
             aes(x = proporcion,
                 y = reorder_within(palabra, proporcion, tipo),
                 fill = tipo)) +
  geom_col(show.legend = FALSE) +
  scale_y_reordered() +
  scale_x_continuous(labels = scales::percent) +
  scale_fill_manual(values = colores) +
  facet_wrap(~ tipo, scales = "free_y") +
  labs(title = "Las 15 palabras más frecuentes de cada tipo de cuenta",
       subtitle = "Como proporción del total de palabras del grupo, sin palabras vacías",
       x = NULL, y = NULL) +
  theme_minimal()

g1

# reorder_within() y scale_y_reordered() vienen de tidytext: ordenan las
# barras DENTRO de cada panel. Con fct_reorder() del script 1 el orden sería
# uno solo para los dos paneles.


## Bigramas: pares de palabras -----------------------------------------------

# Una palabra suelta pierde contexto: "provincia" no dice de quién.
# "nuestra provincia" sí. Un BIGRAMA es un par de palabras consecutivas.
bigramas <- propios |>
  select(id_post, cuenta, tipo, texto_limpio) |>
  unnest_tokens(bigrama, texto_limpio, token = "ngrams", n = 2) |>
  filter(!is.na(bigrama)) |>
  separate(bigrama, into = c("p1", "p2"), sep = " ", remove = FALSE) |>
  filter(!p1 %in% vacias$palabra, !p2 %in% vacias$palabra)   # [op] !  %in%

bigramas |> filter(tipo == "Político") |> count(cuenta, bigrama, sort = TRUE) |> head(20)

# Ojo: para encontrar "nuestra provincia" NO hay que sacar las vacías,
# porque "nuestra" es una palabra vacía de la lista estándar. Pruébenlo:
bigramas_con_vacias <- propios |>
  filter(tipo == "Político") |>
  unnest_tokens(bigrama, texto_limpio, token = "ngrams", n = 2) |>
  count(bigrama, sort = TRUE)

bigramas_con_vacias |> filter(str_detect(bigrama, patron_nosotros)) |> head(10)

# Ésta es la lección más importante del nivel: la lista de palabras vacías
# borra justamente los pronombres, que es lo que a nosotros nos interesa.
# Una herramienta pensada para encontrar TEMAS es ciega a la IDENTIDAD.
# Por eso en el nivel 2 buscamos los pronombres ANTES de sacar las vacías.


# -----------------------------------------------------------------------------
# 6. NIVEL 4. UN LÉXICO DE EMOCIONES PRESTADO
# -----------------------------------------------------------------------------
#
# En el nivel 2 armamos el diccionario nosotros. Ahora usamos uno hecho por
# otros: el léxico NRC (Mohammad y Turney), que asigna palabras a ocho
# emociones y a dos polos (positivo, negativo). La versión en castellano que
# trae syuzhet es una TRADUCCIÓN AUTOMÁTICA del inglés. Ya van a ver por qué
# eso importa.

nrc <- syuzhet::get_sentiment_dictionary("nrc", language = "spanish") |>
  as_tibble() |>
  distinct(word, sentiment) |>          # la traducción dejó filas repetidas
  rename(palabra = word, emocion_en = sentiment)

nrc |> count(emocion_en, sort = TRUE)

# Las etiquetas vienen en inglés. Las traducimos con una tabla de
# equivalencias y un left_join(): la "manera 2" de etiquetar del script 1.
traduccion <- tribble(
  ~emocion_en,     ~emocion,
  "anger",         "ira",
  "fear",          "miedo",
  "sadness",       "tristeza",
  "disgust",       "asco",
  "joy",           "alegría",
  "trust",         "confianza",
  "anticipation",  "anticipación",
  "surprise",      "sorpresa",
  "negative",      "negativo",
  "positive",      "positivo"
)

nrc <- nrc |> left_join(traduccion, by = "emocion_en")

# inner_join() se queda sólo con las filas que tienen pareja de los dos
# lados: las palabras de nuestro corpus que están en el léxico.
# Usamos las palabras SIN sacar las vacías, porque el léxico decide solo.
palabras_emocion <- palabras |>
  inner_join(nrc, by = "palabra", relationship = "many-to-many")

# ¿Qué proporción de las palabras de cada grupo expresa cada emoción?
total_palabras <- palabras |> count(tipo, name = "total")

emociones_tipo <- palabras_emocion |>
  filter(!emocion %in% c("positivo", "negativo")) |>
  count(tipo, emocion) |>
  left_join(total_palabras, by = "tipo") |>
  mutate(por_mil = n / total * 1000)    # cada cuántas mil palabras aparece

emociones_tipo |> select(tipo, emocion, por_mil) |>
  pivot_wider(names_from = tipo, values_from = por_mil) |>
  arrange(desc(Político))

# Los políticos usan más palabras de confianza, alegría y anticipación; los
# medios, más de miedo, tristeza e ira. Tiene sentido: el político habla de
# lo que va a hacer, el medio informa lo que pasó, y lo que es noticia
# suele ser malo. ¿Pero qué palabras están detrás de esos números?


## Validar: ¿qué palabras está contando el léxico? ---------------------------

# Esto NO es opcional. Miremos qué palabras de nuestro corpus pesan más en
# "miedo" y en "ira".
palabras_emocion |>
  filter(emocion %in% c("miedo", "ira")) |>
  count(emocion, palabra, sort = TRUE) |>
  group_by(emocion) |>
  slice_max(n, n = 10)

# La palabra que más "miedo" aporta es "gobierno", y por lejos: aparece casi
# 2.800 veces, más que "ataque", "violencia" y "policía" juntas. En un
# corpus de noticias políticas argentinas "gobierno" no expresa miedo de
# nadie: es el sujeto de la mitad de los titulares. "Inflación" y "dólar"
# también cuentan como miedo, y "defensa" (el ministerio) como ira.
# Y "casta", que en inglés (caste) es un término de estratificación social,
# quedó como negativa por traducción, no porque el léxico sepa qué quiere
# decir en la Argentina de 2024.
#
# ¿Qué parte del "miedo" de cada grupo es, en realidad, la palabra gobierno?
palabras_emocion |>
  filter(emocion == "miedo") |>
  count(tipo, es_gobierno = palabra == "gobierno") |>
  group_by(tipo) |>
  mutate(proporcion = round(n / sum(n), 3))

# Nueve de cada cien palabras de "miedo", en los dos grupos. Un léxico
# prestado trae decisiones teóricas de otros, de otra lengua y de otra
# época. Se puede usar, pero hay que auditarlo antes de creerle.

# Para el nivel 5 nos quedamos con una marca por publicación: si tiene al
# menos una palabra de ira según el léxico, sacando "gobierno".
posts_con_ira <- palabras_emocion |>
  filter(emocion == "ira", palabra != "gobierno") |>
  distinct(id_post) |>
  mutate(ira = TRUE)

propios <- propios |>
  left_join(posts_con_ira, by = "id_post") |>
  mutate(ira = replace_na(ira, FALSE))    # las que no tenían pareja quedan NA: las pasamos a FALSE

propios |> group_by(tipo) |> summarise(ira = mean(ira))

# Tres de cada diez publicaciones, en los dos grupos. Una marca que se
# prende en tantos textos discrimina poco: guarden esa sospecha para el
# nivel 5.


# -----------------------------------------------------------------------------
# 7. NIVEL 5. VOLVER A LA PREGUNTA: ¿SE ASOCIA CON LA REPERCUSIÓN?
# -----------------------------------------------------------------------------
#
# El problema: una publicación de Milei tiene una mediana de 10.000 likes y
# una de El Ciudadano, de 0. Si comparamos likes crudos, cualquier marcador
# que use más Milei va a "ganar", y estaríamos midiendo a Milei, no al
# marcador.
#
# La solución: comparar cada publicación CON LAS DE SU PROPIA CUENTA.
# percent_rank() dice qué lugar ocupa cada publicación dentro de su cuenta,
# de 0 (la de menos likes) a 1 (la de más). Un 0,8 quiere decir "le fue
# mejor que al 80% de las publicaciones de esa misma cuenta".

propios <- propios |>
  group_by(cuenta) |>
  mutate(percentil_likes = percent_rank(like_count)) |>
  ungroup()

# Si no hubiera ninguna relación, las publicaciones CON un marcador y las
# SIN él tendrían en promedio el mismo percentil. (No va a dar exactamente
# 0,5: cuando muchas publicaciones empatan, por ejemplo con 0 likes,
# percent_rank() les da a todas el lugar más bajo, y el promedio baja. Lo
# que importa es la DIFERENCIA entre con y sin.)

marcadores <- c("nosotros", "yo", "ellos_politico", "ellos_delito",
                "exclamacion", "ira")

comparacion <- propios |>
  pivot_longer(all_of(marcadores), names_to = "marcador", values_to = "presente") |>
  group_by(tipo, marcador, presente) |>
  summarise(n = n(), percentil = mean(percentil_likes), .groups = "drop")

comparacion

# pivot_longer() apila las seis columnas TRUE/FALSE en una sola, para poder
# agrupar por marcador. Es pasar de una tabla "ancha" a una "larga".

diferencias <- comparacion |>
  select(-n) |>                                          # [op] - en select(): todas menos ésta
  pivot_wider(names_from = presente, values_from = percentil) |>
  mutate(diferencia = (`TRUE` - `FALSE`) * 100)          # en puntos percentiles

diferencias

g2 <- ggplot(diferencias,
             aes(x = diferencia, y = fct_reorder(marcador, diferencia), fill = tipo)) +
  geom_col(position = "dodge") +
  geom_vline(xintercept = 0) +
  scale_fill_manual(values = colores) +
  labs(title = "¿Cuánto mejor le va a una publicación que tiene cada marcador?",
       subtitle = "Diferencia de percentil de likes dentro de su propia cuenta, con y sin el marcador",
       x = "Puntos percentiles", y = NULL, fill = NULL) +
  theme_minimal()

g2

# En los dos grupos, nombrar al adversario político es lo que más se asocia
# con likes: unos 20 puntos percentiles. Pero miren la columna n de la
# tabla "comparacion" antes de entusiasmarse: en los políticos son 19
# publicaciones, y 13 son de Milei.


## Un control: el largo del texto ---------------------------------------------

# Todos los marcadores dan positivo, y eso es sospechoso. Un texto más
# largo tiene más chances de contener CUALQUIER palabra, y además los
# textos largos suelen tener más likes. Si eso fuera todo, los marcadores
# no dirían nada: estarían midiendo el largo.
#
# Un modelo lineal (lm) estima el efecto de cada variable "manteniendo
# constantes" las demás. Lo van a ver con más detalle en la clase de
# estadística; acá alcanza con leer los coeficientes.
#
#   percentil_likes ~ marcadores + largo + cuenta
#
# [op] ~  en un modelo se lee "explicado por". Lo de la izquierda es lo que
#         queremos explicar; lo de la derecha, con qué.

modelo_politicos <- lm(
  percentil_likes ~ nosotros + yo + ellos_politico + ellos_delito +
    exclamacion + ira + log(palabras + 1) + cuenta,      # [op] +  acá suma variables al modelo
  data = filter(propios, tipo == "Político")
)

modelo_medios <- lm(
  percentil_likes ~ nosotros + yo + ellos_politico + ellos_delito +
    exclamacion + ira + log(palabras + 1) + cuenta,
  data = filter(propios, tipo == "Medio")
)

# broom::tidy() ordena el resultado del modelo como tabla. Nos quedamos con
# los marcadores. "estimate" está en proporción: 0,10 son 10 puntos
# percentiles. "p.value" chico (menor a 0,05) quiere decir que sería raro
# ver una diferencia así por azar.
resultados <- bind_rows(
  broom::tidy(modelo_politicos) |> mutate(tipo = "Político"),
  broom::tidy(modelo_medios)    |> mutate(tipo = "Medio")
) |>
  filter(str_detect(term, "TRUE")) |>
  mutate(term = str_remove(term, "TRUE"),
         puntos = round(estimate * 100, 1),
         p.value = signif(p.value, 2)) |>
  select(tipo, term, puntos, p.value)

resultados

# CÓMO SE LEE: controlando el largo y la cuenta, una publicación de medio
# que nombra un exogrupo político se ubica 17,6 puntos percentiles más
# arriba que una de la misma cuenta y el mismo largo que no lo hace.
#
# Lo que sobrevive al control:
#   - En MEDIOS, todo sigue siendo positivo y muy poco probable por azar
#     (son 47.000 publicaciones: con tantos casos, casi cualquier diferencia
#     da significativa). Lo que importa es el TAMAÑO: el exogrupo político
#     (17,6) y el delictivo (12,7) son los más grandes; la ira, apenas 1,9.
#   - En POLÍTICOS, el resultado más firme es el "nosotros": 13 puntos, con
#     155 publicaciones. Al armar el script probamos sacar a Pullaro (que
#     aporta 65 de esas 155) y sacar a Milei, y da 14 y 13,5: no depende de
#     una sola cuenta. El exogrupo político da 14, pero con 19 casos: si se
#     saca a Milei queda en 34 con sólo 6 publicaciones. Un número que salta
#     así no es un hallazgo, es ruido. Y el "ellos" delictivo no llega a ser
#     significativo (p = 0,055).


# -----------------------------------------------------------------------------
# 8. NIVEL 6. TF-IDF: QUÉ PALABRAS SON PROPIAS DE CADA CUENTA
# -----------------------------------------------------------------------------
#
# Las palabras más frecuentes de cada político se parecen mucho entre sí
# ("gobierno", "argentina"). Lo que queremos ver es lo DISTINTIVO: palabras
# que una cuenta usa mucho y las demás poco.
#
#   tf   (term frequency)   qué tan frecuente es la palabra en esa cuenta
#   idf  (inverse document frequency)  qué tan rara es entre las cuentas:
#        si la usan todas, vale 0
#   tf-idf = tf × idf      alto si es frecuente acá y rara en el resto

tfidf_politicos <- palabras_utiles |>
  filter(tipo == "Político", cuenta != "pablo_cococcioni") |>   # 7 publicaciones no alcanzan
  count(cuenta, palabra) |>
  bind_tf_idf(palabra, cuenta, n) |>
  group_by(cuenta) |>
  slice_max(tf_idf, n = 10, with_ties = FALSE) |>
  ungroup()

g3 <- ggplot(tfidf_politicos,
             aes(x = tf_idf, y = reorder_within(palabra, tf_idf, cuenta))) +
  geom_col(fill = colores["Político"]) +
  scale_y_reordered() +
  facet_wrap(~ cuenta, scales = "free", ncol = 3) +
  labs(title = "Las palabras más distintivas de cada político (tf-idf)",
       x = "tf-idf", y = NULL) +
  theme_minimal()

g3

# tf-idf encuentra el TERRITORIO de cada uno: Bullrich es droga, narcos,
# PFA; Petri, fuerzas armadas; Javkin, pavimento, cuadras, contenedores;
# Pullaro, "santafesinos" e "invencible provincia"; Milei, "carajo" y
# "fenómeno barrial". Pero los pronombres no aparecen, porque los sacamos
# como vacíos y porque "nuestra" la usan casi todos. Es otra vez la misma
# lección: cada técnica ve una cosa y es ciega a otra.


# -----------------------------------------------------------------------------
# 9. NIVEL 7. MODELO DE TÓPICOS (LDA)
# -----------------------------------------------------------------------------
#
# Hasta ahora nosotros le decíamos a R qué buscar. Un modelo de tópicos hace
# al revés: le damos los textos y un NÚMERO de temas, y él busca grupos de
# palabras que tienden a aparecer juntas. LDA (Latent Dirichlet Allocation)
# supone que:
#   - cada tema es una mezcla de palabras (con distintos pesos), y
#   - cada publicación es una mezcla de temas.
# Es aprendizaje NO supervisado: nadie le dice cuáles son los temas. Los
# nombres se los ponemos nosotros, después, leyendo.


## Preparar la matriz documento-término --------------------------------------

# LDA no trabaja con la tabla larga sino con una matriz: una fila por
# publicación, una columna por palabra, y en cada celda cuántas veces
# aparece. Casi toda la matriz son ceros.
#
# Sacamos las palabras que aparecen en menos de 30 publicaciones: son
# demasiado raras para formar un tema y hacen todo más lento.
vocabulario <- palabras_utiles |>
  distinct(id_post, palabra) |>
  count(palabra) |>
  filter(n >= 30)

nrow(vocabulario)   # cuántas palabras distintas entran al modelo

matriz <- palabras_utiles |>
  semi_join(vocabulario, by = "palabra") |>   # semi_join: quedarse con las que SÍ están
  count(id_post, palabra) |>
  cast_dtm(id_post, palabra, n)

matriz   # "documents" son publicaciones, "terms" son palabras


## Estimar el modelo -----------------------------------------------------------

# k es el número de temas. Lo decidimos nosotros. Probamos con 8.
# seed fija el punto de partida al azar: con la misma semilla, el mismo
# resultado. method = "Gibbs" da temas más claros en textos cortos.
# Tarda entre medio minuto y un par de minutos según la computadora.
modelo_lda <- LDA(matriz, k = 8, method = "Gibbs",
                  control = list(seed = 2026, iter = 500))

# Si con su versión de los paquetes los temas salen en otro orden, o un
# poco distintos, es normal: LDA es un procedimiento con azar. Por eso hay
# que leer los temas cada vez, y no copiar los nombres de otro.


## Leer los temas: beta ------------------------------------------------------

# beta es el peso de cada palabra en cada tema.
temas_palabras <- tidy(modelo_lda, matrix = "beta") |>
  group_by(topic) |>
  slice_max(beta, n = 10, with_ties = FALSE) |>
  ungroup()

g4 <- ggplot(temas_palabras,
             aes(x = beta, y = reorder_within(term, beta, topic))) +
  geom_col(fill = colores["Medio"]) +
  scale_y_reordered() +
  facet_wrap(~ topic, scales = "free", ncol = 4, labeller = label_both) +
  labs(title = "Las 10 palabras con más peso en cada tema (LDA, k = 8)",
       x = "beta", y = NULL) +
  theme_minimal()

g4

# Ahora viene la parte que la máquina no hace: leer y nombrar. Ésta es la
# tabla con los nombres que les pusimos al armar el script, mirando el
# gráfico. ANTES de usarla, comparen con su gráfico: si a ustedes el tema 2
# no es fútbol, cambien los nombres. Un nombre equivocado arruina todo lo
# que sigue sin dar ningún error.

nombres_temas <- tribble(
  ~topic, ~tema,
  1,      "Milei, la figura presidencial",
  2,      "Deportes",
  3,      "Interés general",
  4,      "Policiales e internacional",
  5,      "Gobierno y ley Bases",
  6,      "Economía y precios",
  7,      "Rosario: ciudad y clima",
  8,      "Santa Fe: seguridad y paros"
)

# Miren el tema 5: "gobierno", "ley", "bases", "diputados"... y "casa" y
# "hermano". LDA juntó la Casa Rosada con Gran Hermano, porque las dos
# cosas aparecían en los mismos días y con palabras parecidas. El modelo
# no entiende: agrupa coincidencias. Y el tema 4 mezcla policiales con la
# guerra en Medio Oriente, porque comparten "ataque", "muerte", "hombre".
# Con k = 10 o 12 probablemente se separen. Ése es el ejercicio 4.


## De qué habla cada publicación: gamma --------------------------------------

# gamma es cuánto de cada tema tiene cada publicación. A cada publicación le
# asignamos su tema principal: el de gamma más alto.
tema_principal <- tidy(modelo_lda, matrix = "gamma") |>
  group_by(document) |>
  slice_max(gamma, n = 1, with_ties = FALSE) |>
  ungroup() |>
  transmute(id_post = as.integer(document), topic) |>
  left_join(nombres_temas, by = "topic")

# Algunas publicaciones quedaron sin tema porque, después de limpiar, no les
# quedó ninguna palabra del vocabulario. Las marcamos como "Sin tema".
propios <- propios |>
  left_join(tema_principal, by = "id_post") |>
  mutate(tema = replace_na(tema, "Sin tema"))

# ¿En qué temas aparece el "ellos"?
propios |>
  group_by(tema) |>
  summarise(publicaciones  = n(),
            ellos_delito   = round(mean(ellos_delito) * 100, 1),
            ellos_politico = round(mean(ellos_politico) * 100, 1)) |>
  arrange(desc(ellos_delito))

# El "ellos" delictivo se concentra en policiales (5 de cada 100) y en
# Santa Fe: seguridad (casi 3 de cada 100); en el resto de los temas casi no
# aparece. El "ellos" político se concentra en "Gobierno y ley Bases".


## El cierre: ¿el "ellos" sobrevive si controlamos por el tema? --------------

# Si el "ellos delictivo" se concentra en las noticias policiales, y las
# noticias policiales tienen más likes por ser policiales, entonces lo que
# vimos en el nivel 5 podría ser un efecto del TEMA y no del exogrupo.
# El modelo de tópicos nos da la variable para controlarlo.

modelo_medios_tema <- lm(
  percentil_likes ~ nosotros + yo + ellos_politico + ellos_delito +
    exclamacion + ira + log(palabras + 1) + cuenta + tema,
  data = filter(propios, tipo == "Medio")
)

bind_rows(
  broom::tidy(modelo_medios)      |> mutate(modelo = "Sin controlar tema"),
  broom::tidy(modelo_medios_tema) |> mutate(modelo = "Controlando tema")
) |>
  filter(term %in% c("ellos_politicoTRUE", "ellos_delitoTRUE", "nosotrosTRUE")) |>
  mutate(puntos = round(estimate * 100, 1), p.value = signif(p.value, 2)) |>
  select(modelo, term, puntos, p.value)

# El tema explicaba una parte, no todo. Al controlarlo, el exogrupo
# político baja de 17,6 a 13,8 puntos y el delictivo de 12,7 a 8,6: cerca
# de un tercio de lo que parecía efecto del "ellos" delictivo era, en
# realidad, que las noticias policiales rinden más. Pero lo que queda sigue
# siendo claro. Lo encontramos porque un modelo que no sabe nada de
# identidad social nos dio la variable para controlar.

# Con los políticos no lo hacemos: 861 publicaciones repartidas en ocho
# temas, cinco cuentas y siete marcadores son demasiadas variables para tan
# pocos casos.


## Guardar los gráficos --------------------------------------------------------

ggsave("nlp_1_palabras_frecuentes.png", g1, width = 9, height = 5, dpi = 150)
ggsave("nlp_2_marcadores_repercusion.png", g2, width = 9, height = 5, dpi = 150)
ggsave("nlp_3_tfidf_politicos.png", g3, width = 10, height = 6, dpi = 150)
ggsave("nlp_4_temas_lda.png", g4, width = 12, height = 7, dpi = 150)


# -----------------------------------------------------------------------------
# 10. QUÉ PODEMOS CONCLUIR, Y QUÉ NO
# -----------------------------------------------------------------------------
#
# LO QUE LOS DATOS SOSTIENEN
#
# 1) Medios y políticos usan el lenguaje de la identidad en proporciones
#    muy distintas (el "nosotros", en 7 de cada 1.000 publicaciones de
#    medios y en 18 de cada 100 de políticos). Pero eso es sobre todo
#    género discursivo: titulares en tercera persona contra discurso en
#    primera. No es un hallazgo psicológico.
#
# 2) Entre los políticos hay al menos tres maneras de construir la
#    identidad: el nosotros institucional (Pullaro), el exogrupo delictivo
#    (Bullrich) y el yo personalista con exclamación (Milei).
#
# 3) En los MEDIOS, dentro de cada cuenta y con el mismo largo, los
#    titulares que nombran un exogrupo político tienen más likes (unos 14
#    puntos percentiles más, aun controlando el tema). Con las RESPUESTAS
#    en lugar de los likes, la diferencia llega a casi 30 puntos: nombrar al
#    adversario genera, sobre todo, conversación. Es la misma dirección que
#    encontraron Rathje, Van Bavel y van der Linden (2021).
#
# 4) En los POLÍTICOS, las publicaciones en clave de "nosotros" rinden
#    unos 13 puntos percentiles más que las demás de la misma cuenta, y el
#    resultado se sostiene aunque se saque a Pullaro o a Milei.
#
# LO QUE LOS DATOS NO SOSTIENEN
#
# 1) Que nombrar al exogrupo CAUSE más repercusión. Es una asociación. Ya
#    vimos que una parte la explicaba el tema; puede haber otras variables
#    que no medimos (el día, la hora, si hay foto o video, qué pasaba ese
#    día en Rosario).
#
# 2) Nada sobre "los políticos" en general: son cinco cuentas útiles, 861
#    publicaciones, con fuerte peso de Santa Fe, en dos meses de 2024 que
#    incluyen la crisis de violencia narco de marzo en Rosario.
#
# 3) Que el exogrupo político funcione igual en los políticos: 19 casos,
#    13 de Milei. No alcanza.
#
# 4) Que un like sea aprobación. No sabemos quién da like: puede ser un
#    seguidor convencido, un bot, o alguien que discute. Lo que medimos es
#    repercusión, no persuasión.
#
# 5) Que el léxico de emociones mida emociones. Mide palabras traducidas
#    por una máquina, y en este corpus marca "ira" en 3 de cada 10
#    publicaciones de los dos grupos. Discrimina poco.
#
# Y la más importante: con otras palabras en los diccionarios, otras
# palabras vacías u otro número de temas, los números cambian. Que cambien
# no es un defecto del análisis. Es la prueba de que las decisiones
# teóricas están adentro del código, y por eso hay que escribirlas.


# -----------------------------------------------------------------------------
# 11. FUNCIONES Y SÍMBOLOS NUEVOS, TODOS JUNTOS
# -----------------------------------------------------------------------------
#
# Expresiones regulares (el idioma de los patrones de texto)
#   \\w     una letra, número o guión bajo        "\\w+"  una palabra
#   \\S     cualquier cosa que no sea un espacio   "https?://\\S+"  un enlace
#   \\b     borde de palabra                       "\\bmi\\b"  no encuentra "Milei"
#   +       una o más veces lo anterior
#   ?       lo anterior es optativo                "narcos?"  narco y narcos
#   |       o                                      "casta|kukas"
#   ( )     agrupa alternativas                    "\\b(yo|mi|me)\\b"
#   [ ]     cualquiera de estos caracteres         "[!¡]"   "[0-9]"
#   Recuerden: en R la barra invertida se escribe DOBLE.
#
# Texto (stringr)
#   str_length()       cuántos caracteres
#   str_count()        cuántas veces aparece un patrón
#   str_to_lower()     a minúsculas
#   str_remove_all()   borrar todo lo que coincida con un patrón
#   str_detect()       ¿contiene el patrón?  TRUE / FALSE
#   str_extract_all()  devolver lo que coincide
#
# Texto como tabla (tidytext)
#   unnest_tokens()    una fila por palabra (o por bigrama, con token = "ngrams")
#   bind_tf_idf()      calcular tf, idf y tf-idf
#   cast_dtm()         pasar a matriz documento-término, para LDA
#   tidy()             volver de un modelo a una tabla
#   reorder_within()   ordenar barras dentro de cada panel
#
# Uniones (dplyr): las cuatro que usamos
#   left_join()   todas las de la izquierda, con lo que tengan a la derecha
#   inner_join()  sólo las que tienen pareja de los dos lados
#   anti_join()   las de la izquierda que NO tienen pareja (sacar vacías)
#   semi_join()   las de la izquierda que SÍ tienen pareja, sin agregar columnas
#
# Operadores nuevos o con otro sentido
#   ::     función de tal paquete                stopwords::stopwords("es")
#   :      de tal columna a tal columna          across(nosotros:exclamacion, mean)
#   -      en select(), todas menos ésa          select(-n)
#   ~      en un modelo, "explicado por"         lm(y ~ x)
#   +      en un modelo, agregar una variable    lm(y ~ x1 + x2)
#   \(x)   una función chiquita, en el lugar     \(x) round(x * 100, 1)


# -----------------------------------------------------------------------------
# 12. PARA SEGUIR PRACTICANDO
# -----------------------------------------------------------------------------
#
# 1) Agreguen palabras al patrón de "ellos político" (o saquen alguna) y
#    vuelvan a correr los niveles 2 y 5. ¿Cambia la conclusión? Anoten en la
#    bitácora qué palabra agregaron y por qué la consideran un exogrupo.
#
# 2) Armen un patrón para el "nosotros" verbal que no caiga en la trampa de
#    "reclamos" y "préstamos". Pista: en vez de un patrón general, una
#    lista de verbos concretos ("vamos", "estamos", "trabajamos"...).
#
# 3) Cambien like_count por comment_count en el nivel 5 (en la línea del
#    percent_rank). Las respuestas miden otra cosa que los likes. ¿Qué
#    marcador cambia más? ¿Por qué nombrar a un adversario podría generar
#    más respuestas que likes?
#
# 4) Corran el LDA con k = 5 y con k = 12. ¿Cuál se lee mejor? No hay una
#    respuesta correcta: hay una que sirve más para su pregunta.
#
# 5) Busquen en el léxico NRC otras tres palabras que, en este corpus,
#    estén mal clasificadas, como "gobierno". Discutan qué harían con ellas.
#
# 6) Pídanle a una IA que les explique qué hace la línea de cast_dtm() y
#    verifiquen su respuesta mirando el objeto "matriz" en la consola.
