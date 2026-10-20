# =============================================================================
# TALLER DE CIENCIA DE DATOS Y PSICOLOGÍA
# Script 1. Explorar, transformar y visualizar
#
# Datos: df_trabajo_1.csv (publicaciones de X de medios y de políticos, 2024)
#
# Cómo usar este archivo:
#   Se corre de arriba hacia abajo, línea por línea, con Ctrl+Enter
#   (Cmd+Enter en Mac). No hace falta entender todo la primera vez.
#   Todo lo que empieza con # es un comentario: R lo ignora, está escrito
#   para ustedes.
#
#   Cada vez que aparece un operador nuevo está señalado con la marca [op].
#   Si quieren ver todos juntos, busquen "[op]" con Ctrl+F, o vuelvan a la
#   sección 1, que es la lista completa con ejemplos.
#
# Este archivo está guardado en UTF-8. Si ven caracteres raros en los
# acentos, en RStudio: File > Reopen with Encoding > UTF-8.
# =============================================================================


# -----------------------------------------------------------------------------
# 0. PREPARACIÓN
# -----------------------------------------------------------------------------

# La primera vez, y sólo la primera vez, hay que instalar el paquete.
# Después de instalarlo, volvemos a comentar esta línea.
# install.packages("tidyverse")

# Instalar es bajar el paquete a la computadora. Cargarlo con library() es
# ponerlo sobre la mesa de trabajo. Son dos cosas distintas: se instala una
# vez, se carga en cada sesión de R.
library(tidyverse)

# R busca los archivos en su "carpeta de trabajo". Para que el CSV se cargue,
# tiene que estar en la misma carpeta que este script.
# Si da error, en RStudio: Session > Set Working Directory > To Source File Location.
getwd()


# -----------------------------------------------------------------------------
# 1. LOS OPERADORES
# -----------------------------------------------------------------------------
#
# Un operador es un símbolo que hace algo. Son pocos y se repiten siempre.
# Esta sección no toca los datos: son ejemplos mínimos para correr y mirar el
# resultado en la consola. Vale la pena volver acá cada vez que aparezca un
# símbolo que no reconozcan.


## Asignar ------------------------------------------------------------------

# [op]  <-   guardar algo con un nombre. Se lee "guardá esto ahí".
#            Atajo de teclado en RStudio: Alt + guión.

x <- 10
x

nombre <- "Infobae"
nombre

# Los nombres son etiquetas nuestras: R no entiende qué significan.
# Si le ponemos "datos" a una tabla de gatos, R la va a llamar datos igual.


## Aritmética ---------------------------------------------------------------

# [op]  + - * /   sumar, restar, multiplicar, dividir
# [op]  ^         elevar a una potencia

2 + 3
10 / 4
2 ^ 3

# [op]  :   armar una secuencia de números enteros

1:5


## Juntar varios valores ----------------------------------------------------

# c() no es un operador sino una función, pero se usa tanto que va acá.
# Arma un vector, que es una lista de valores del mismo tipo.

c(10, 20, 30)
c("clarin", "infobae")

# Casi todo en R trabaja sobre vectores enteros, no sobre un valor por vez.
# Por eso esto devuelve tres resultados y no uno:

c(10, 20, 30) * 2


## Comparar -----------------------------------------------------------------

# Comparar devuelve TRUE o FALSE. Esa es la materia prima de todo filtro.

# [op]  ==   ¿es igual a?          OJO: son DOS signos igual, no uno.
# [op]  !=   ¿es distinto de?
# [op]  <  >  <=  >=   menor, mayor, menor o igual, mayor o igual

5 == 5
5 == 3
5 != 3
5 > 3
5 <= 5

# El error más común del principio es escribir = donde va ==.
# Un solo = sirve para pasarle argumentos a una función, no para comparar.

"Medio" == "medio"   # FALSE: R distingue mayúsculas de minúsculas

# Comparar un vector contra un valor devuelve un TRUE o FALSE por elemento:
c(1, 5, 10) < 6


## Preguntar si algo está en una lista --------------------------------------

# [op]  %in%   ¿este valor está dentro de este conjunto?
#              Reemplaza a escribir  x == "a" | x == "b" | x == "c"

"clarin" %in% c("clarin", "infobae", "la_nacion")
"milei"  %in% c("clarin", "infobae", "la_nacion")

# Los operadores rodeados de % siempre se leen como una pregunta o una
# operación con nombre. Más adelante van a ver otros del mismo estilo.


## Combinar condiciones -----------------------------------------------------

# [op]  &   y   (tienen que cumplirse las dos)
# [op]  |   o   (alcanza con que se cumpla una)
# [op]  !   no  (da vuelta el valor)

TRUE  & FALSE
TRUE  | FALSE
!TRUE

(5 > 3) & (2 > 1)
(5 > 3) & (2 > 8)


## El dato que falta --------------------------------------------------------

# NA es "no sé", el valor faltante. No es cero ni es texto vacío.
# Cuidado con esto, porque rompe la intuición:

NA == NA     # devuelve NA, no TRUE: no sabemos si dos cosas que no sabemos
             # son iguales entre sí

# Por eso, para preguntar si algo falta, se usa una función y no ==
is.na(NA)


## Sacar una columna de una tabla -------------------------------------------

# [op]  $   agarra una sola columna de una tabla, como un vector suelto.
#           Lo vamos a usar poco, porque el tidyverse casi no lo necesita,
#           pero aparece en todos lados.

# (Ejemplo con una tabla mínima construida a mano.)
tabla_ejemplo <- data.frame(cuenta = c("clarin", "infobae"),
                            likes  = c(10, 5))
tabla_ejemplo
tabla_ejemplo$likes


## Encadenar pasos ----------------------------------------------------------

# [op]  |>   el "pipe" o tubería. Se lee "y después".
#            Toma lo que está a la izquierda y se lo pasa a la función de la
#            derecha como primer argumento.
#            Atajo de teclado en RStudio: Ctrl + Shift + M.

# Estas dos líneas hacen exactamente lo mismo:
sum(c(1, 2, 3))
c(1, 2, 3) |> sum()

# Con un solo paso no se nota la ventaja. Con cuatro pasos encadenados sí,
# porque se lee en el orden en que ocurren las cosas y no de adentro hacia
# afuera. Van a verlo en la sección 4.


## Dos que aparecen más adelante --------------------------------------------

# [op]  ~   la virgulilla. En case_when() separa la condición del resultado
#           y se lee "entonces":   condición ~ valor
#           Atajo de teclado: Alt Gr + 4 en teclados latinoamericanos.

# [op]  +   en ggplot NO suma: agrega una capa al gráfico.
#           El mismo símbolo significa dos cosas distintas según dónde esté.
#           R está lleno de esto, y es una de las razones por las que conviene
#           leer el contexto antes que memorizar símbolos.

# Un tercero que van a encontrar en cualquier tutorial de internet:
# [op]  ::  indica de qué paquete sale una función.  dplyr::filter() quiere
#           decir "el filter de dplyr, no el de otro paquete".


# -----------------------------------------------------------------------------
# 2. CARGAR LOS DATOS
# -----------------------------------------------------------------------------

# read_csv() lee el archivo y lo guarda en un objeto que llamamos "datos".
#
# El argumento col_types es una precaución. Los identificadores de X son
# números de 19 dígitos y R, si los toma como números, los redondea y los
# arruina. Le pedimos que los lea como texto. No los vamos a usar hoy, pero
# conviene ver desde el principio que cargar un dato ya es tomar decisiones.

datos <- read_csv(                                  # [op] <- guardamos el resultado
  "df_trabajo_1.csv",
  col_types = cols(                                 # [op] =  pasar un argumento (no es comparar)
    .default             = col_guess(),
    id                   = col_character(),
    account_id           = col_character(),
    conversation_id      = col_character(),
    in_reply_to_tweet_id = col_character(),
    quoted_tweet_id      = col_character(),
    `.id`                = col_character()
  )
)


# -----------------------------------------------------------------------------
# 3. PRIMERA MIRADA: QUÉ HAY ADENTRO
# -----------------------------------------------------------------------------

# Antes de calcular nada, mirar. Cuatro preguntas básicas.

datos            # ¿Qué forma tiene? Se imprimen las primeras filas.
dim(datos)       # ¿Cuántas filas y cuántas columnas?
names(datos)     # ¿Cómo se llaman las columnas?
glimpse(datos)   # Una línea por columna, con su tipo y sus primeros valores.

# Atención a una trampa del mundo real. La columna se llama "description",
# que suena a la biografía de la cuenta, y sin embargo contiene el TEXTO de
# la publicación. El nombre de una columna es una promesa que a veces no se
# cumple: siempre hay que mirar el contenido.

datos |> select(name, description) |> head(3)       # [op] |> dos pasos encadenados

# Renombramos tres columnas para trabajar más cómodos. Las que empiezan con
# punto (.fecha, .user) hay que escribirlas entre acentos invertidos, porque
# si no R se confunde. Mejor sacárselas de encima ahora.
datos <- datos |>
  rename(
    cuenta = nombre_normalizado,
    texto  = description,
    fecha  = `.fecha`
  )


# -----------------------------------------------------------------------------
# 4. EXPLORAR
# -----------------------------------------------------------------------------

# count() cuenta cuántas filas hay de cada valor. Es la función que más van
# a usar en su vida.
datos |> count(cuenta, sort = TRUE)

# ¿Cuántos idiomas hay, y cuánto pesa cada uno?
datos |> count(lang, sort = TRUE)

# ¿Cuántas publicaciones son retuits de otro, y cuántas son respuestas?
datos |> count(is_retweet)
datos |> count(is_reply)

# summary() de una variable numérica: mínimo, cuartiles, mediana, promedio,
# máximo. Miren la distancia entre la mediana y el promedio de los likes.
# Eso ya nos está diciendo algo: hay unas pocas publicaciones enormes que
# tiran el promedio para arriba.
summary(datos$like_count)                           # [op] $ agarramos una sola columna

# ¿Qué período cubre la base?
range(datos$fecha)


# -----------------------------------------------------------------------------
# 5. ETIQUETAR: EL CORAZÓN DE LA CLASE
# -----------------------------------------------------------------------------
#
# La base trae 12 cuentas sueltas. Nosotros sabemos algo que la base no sabe:
# seis son medios de comunicación y seis son políticos. Esa distinción no
# está en ninguna columna del archivo. La ponemos nosotros.
#
# Eso es etiquetar (o codificar, o clasificar): agregarle al dato una
# categoría que viene de nuestro conocimiento del tema, no de la medición.
# Es la operación más teórica de todo el proceso, aunque parezca la más
# técnica. Quien decide que Infobae entra en "medio" y no en "empresa" está
# tomando una decisión conceptual, y el resultado del análisis va a depender
# de esa decisión más que de cualquier función que usemos después.
#
# Vamos a hacer lo mismo de dos maneras distintas.


## --- Manera 1: case_when(), la etiqueta escrita en el código ----------------

# case_when() se lee como una lista de reglas:
#     condición ~ valor que corresponde
# Se evalúa de arriba hacia abajo y GANA LA PRIMERA que se cumple.
# El orden importa. Es lo más fácil de olvidar y lo que más errores produce.

datos <- datos |>
  mutate(
    tipo = case_when(
      cuenta %in% c("infobae", "clarin", "la_nacion",              # [op] %in% pertenencia
                    "diario_la_capital", "rosario3_com", "el_ciudadano") ~ "Medio",
      cuenta %in% c("javier_milei", "patricia_bullrich", "luis_petri",
                    "pablo_javkin", "maximiliano_pullaro", "pablo_cococcioni") ~ "Político",
      .default = "Sin clasificar"                                  # [op] ~ separa condición y resultado
    )
  )

# mutate() crea una columna nueva. El .default es el cajón de lo que no entró
# en ninguna regla. Nunca lo dejen afuera: si no lo escriben, R pone NA en
# silencio y ustedes se enteran tres pasos después.
# (En versiones viejas de dplyr, el .default se escribía como  TRUE ~ "...")

# Siempre, siempre, revisar una etiqueta recién creada contándola:
datos |> count(tipo)

# Y contra el detalle, para ver que ninguna cuenta haya quedado mal asignada:
datos |> count(tipo, cuenta)

# case_when() también sirve para cortar una variable NUMÉRICA en tramos, que
# es algo que una tabla de equivalencias no puede hacer. Acá el orden de las
# reglas es todo: si "Bajo" estuviera primero, se comería a "Sin likes",
# porque 0 también es menor que 10.
datos <- datos |>
  mutate(
    tramo_likes = case_when(
      like_count == 0  ~ "Sin likes",                              # [op] == igualdad
      like_count < 10  ~ "Bajo",                                   # [op] <  comparación
      like_count < 100 ~ "Medio",
      .default         = "Alto"
    )
  )

datos |> count(tramo_likes)

# Cuando la etiqueta tiene sólo dos valores posibles, if_else() alcanza y se
# lee mejor. case_when() es su versión para muchos casos.
datos <- datos |>
  mutate(es_original = if_else(is_retweet == FALSE, "Propio", "Retuit"))

datos |> count(es_original)


## --- Manera 2: una tabla de equivalencias y un left_join() ------------------

# La misma etiqueta, hecha de otra forma. En vez de escribir las reglas
# adentro del código, armamos una tablita aparte con una fila por cuenta.

diccionario <- tribble(
  ~cuenta,                ~tipo_dic,   ~alcance,      ~provincia,   # [op] ~ acá nombra las columnas
  "infobae",              "Medio",     "Nacional",    "CABA",
  "clarin",               "Medio",     "Nacional",    "CABA",
  "la_nacion",            "Medio",     "Nacional",    "CABA",
  "diario_la_capital",    "Medio",     "Provincial",  "Santa Fe",
  "rosario3_com",         "Medio",     "Provincial",  "Santa Fe",
  "el_ciudadano",         "Medio",     "Provincial",  "Santa Fe",
  "javier_milei",         "Político",  "Nacional",    "CABA",
  "patricia_bullrich",    "Político",  "Nacional",    "CABA",
  "luis_petri",           "Político",  "Nacional",    "Mendoza",
  "maximiliano_pullaro",  "Político",  "Provincial",  "Santa Fe",
  "pablo_javkin",         "Político",  "Municipal",   "Santa Fe",
  "pablo_cococcioni",     "Político",  "Provincial",  "Santa Fe"
)

diccionario

# left_join() pega las columnas del diccionario a los datos, haciendo
# coincidir la columna "cuenta" de una tabla con la de la otra.
# "left" quiere decir: no se pierde ninguna fila de la tabla de la izquierda.
datos <- datos |>
  left_join(diccionario, by = "cuenta")

# La prueba de que las dos maneras dan lo mismo. Si en esta tabla aparece
# algo fuera de la diagonal, alguna de las dos está mal escrita.
datos |> count(tipo, tipo_dic)

# Y la pregunta que hay que hacerse siempre después de un join:
# ¿quedó alguna cuenta sin etiquetar?
datos |> filter(is.na(tipo_dic)) |> count(cuenta)   # [op] is.na() para preguntar por lo que falta

# CUÁNDO CONVIENE CADA UNA
#   case_when()   pocas categorías, y reglas que dependen de comparaciones
#                 (mayor que, contiene tal palabra, entre tal y tal fecha).
#                 Es la única de las dos que puede cortar números en tramos.
#
#   diccionario   muchas categorías fijas, o cuando la etiqueta necesita
#                 varias columnas a la vez (acá sumamos alcance y provincia
#                 sin escribir tres case_when). Se corrige en una planilla,
#                 sin tocar el código, y queda como documento escrito de las
#                 decisiones que tomaron. Con 500 cuentas, case_when es
#                 inmanejable; una planilla de 500 filas, no.


# -----------------------------------------------------------------------------
# 6. TRANSFORMAR
# -----------------------------------------------------------------------------

# Nos quedamos con lo que nos interesa: publicaciones propias (no retuits) y
# en castellano. filter() se queda con FILAS, select() con COLUMNAS.
#
# Las dos condiciones separadas por coma dentro de filter() funcionan como un
# "y": tienen que cumplirse las dos. Escribirlo con & da lo mismo.
#
# Nos guardamos las seis columnas de repercusión (likes, retuits, citas,
# respuestas, vistas y guardados), no sólo la que vamos a usar recién, para
# que después puedan rehacer el análisis con cualquiera de ellas.
propios <- datos |>
  filter(is_retweet == FALSE, lang == "es") |>      # [op] == dos condiciones, ambas obligatorias
  select(cuenta, name, tipo, alcance, provincia, fecha, texto,
         like_count, retweet_count, quote_count, comment_count,
         view_count, bookmark_count, tramo_likes)

nrow(datos)     # con cuántas filas empezamos
nrow(propios)   # con cuántas seguimos

# Pruébenlo también así, para ver el & y el ! en acción sobre datos reales:
# datos |> filter(is_retweet == FALSE & lang == "es") |> nrow()
# datos |> filter(!is_retweet) |> nrow()

# group_by() + summarise() es la pinza fundamental del análisis:
# "partime la tabla en grupos y calculame una cosa por grupo".
resumen_tipo <- propios |>
  group_by(tipo) |>
  summarise(
    publicaciones  = n(),
    participacion  = n() / nrow(propios),           # [op] / división
    likes_mediana  = median(like_count),
    likes_promedio = mean(like_count)
  )

resumen_tipo

# Miren esa tabla con atención, porque ahí está la lección del día.
#
# En cantidad de publicaciones, los medios son casi todo y los políticos casi
# nada. En likes por publicación, la relación se da vuelta por completo.
# "Quién tiene más presencia en la plataforma" no es una pregunta: son dos, y
# se contestan distinto según lo que uno haya decidido contar.
#
# Miren también la distancia entre la mediana y el promedio de los políticos.
# El promedio está arrastrado por un puñado de publicaciones de Milei. La
# mediana, que es el valor del medio, aguanta mucho mejor esos extremos.

# Lo mismo, abierto por cuenta.
resumen_cuenta <- propios |>
  group_by(tipo, cuenta) |>
  summarise(
    publicaciones = n(),
    likes_mediana  = median(like_count),
    vistas_mediana = median(view_count),
    vistas_totales = sum(view_count),
    likes_totales = sum(like_count),
    .groups = "drop"
  ) |>
  arrange(desc(vistas_totales))

resumen_cuenta

propios |>
  select(like_count, view_count) |> 
  cor()

# -----------------------------------------------------------------------------
# 7. VISUALIZAR
# -----------------------------------------------------------------------------

# Un gráfico de ggplot se arma sumando capas con el signo +
#   ggplot(datos, aes(...))   qué datos y qué variable va en cada eje
#   geom_col(), geom_line()   con qué forma dibujarlos
#   labs(), theme_...()       los rótulos y el aspecto
#
# [op]  +  acá NO suma números: agrega una capa. Tiene que quedar al FINAL de
#          la línea, nunca al principio de la siguiente, o R piensa que el
#          gráfico ya terminó.

colores <- c("Medio" = "#00345E", "Político" = "#B4472C")


## Gráfico 1. Cuánto publica cada cuenta -------------------------------------

g1 <- ggplot(resumen_cuenta,
             aes(x = publicaciones,
                 y = fct_reorder(cuenta, publicaciones),
                 fill = tipo)) +
  geom_col() +
  scale_fill_manual(values = colores) +
  labs(
    title    = "Volumen de publicación por cuenta",
    subtitle = "Publicaciones propias en castellano, marzo a mayo de 2024",
    x = "Publicaciones", y = NULL, fill = NULL
  ) +
  theme_minimal()

g1

# fct_reorder() ordena las barras por su valor. Sin eso quedan en orden
# alfabético, que casi nunca es lo que uno quiere mostrar.


## Gráfico 2. Cuántos likes junta cada publicación ---------------------------

g2 <- ggplot(resumen_cuenta,
             aes(x = likes_mediana,
                 y = fct_reorder(cuenta, likes_mediana),
                 fill = tipo)) +
  geom_col() +
  scale_fill_manual(values = colores) +
  labs(
    title    = "Likes por publicación (mediana) según cuenta",
    subtitle = "El orden se da vuelta respecto del gráfico anterior",
    x = "Likes por publicación (mediana)", y = NULL, fill = NULL
  ) +
  theme_minimal()

g2


## Gráfico 3. Cómo se reparte en el tiempo -----------------------------------

por_dia <- propios |>
  mutate(dia = as_date(fecha)) |>
  count(dia, tipo)

por_dia

g3 <- ggplot(por_dia, aes(x = dia, y = n, colour = tipo)) +
  geom_line(linewidth = 0.7) +
  scale_colour_manual(values = colores) +
  labs(
    title = "Publicaciones por día",
    x = NULL, y = "Publicaciones", colour = NULL
  ) +
  theme_minimal()

g3

# Los medios publican todos los días con un piso alto; los políticos aparecen
# a los saltos. Son dos regímenes de uso distintos de la misma plataforma.


publicaciones_tipo <- propios |>
  count(tipo, name = "publicaciones") |>
  mutate(porcentaje = publicaciones / sum(publicaciones) * 100)

ggplot(publicaciones_tipo, aes(x = "", y = publicaciones, fill = tipo)) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  geom_text(aes(label = paste0(round(porcentaje, 1), "%")),
            position = position_stack(vjust = 0.5),
            color = "white", size = 5) +
  scale_fill_manual(values = c("Medio" = "firebrick", "Político" = "steelblue")) +
  labs(title = "Comparación de cantidad de publicaciones\nentre medios de comunicación y políticos",
       fill = NULL) +
  theme_void()


## Guardar los gráficos como imagen ------------------------------------------

ggsave("grafico_1_volumen.png", g1, width = 8, height = 5, dpi = 150)
ggsave("grafico_2_likes.png",   g2, width = 8, height = 5, dpi = 150)
ggsave("grafico_3_por_dia.png", g3, width = 8, height = 5, dpi = 150)


# -----------------------------------------------------------------------------
# 8. LOS OPERADORES, TODOS JUNTOS
# -----------------------------------------------------------------------------
#
#   <-     guardar con un nombre                 x <- 10
#   =      pasar un argumento a una función      sort = TRUE
#   ==     ¿es igual a?                          lang == "es"
#   !=     ¿es distinto de?                      lang != "es"
#   < > <= >=   comparaciones                    like_count < 10
#   %in%   ¿está en esta lista?                  cuenta %in% c("clarin", "infobae")
#   &      y                                     a > 1 & b > 1
#   |      o                                     a > 1 | b > 1
#   !      no                                    !is_retweet
#   |>     y después (pipe)                      datos |> count(cuenta)
#   $      una columna suelta                    datos$like_count
#   ~      condición entonces resultado          like_count == 0 ~ "Sin likes"
#   + - * / ^   aritmética                       2 + 3
#   +      en ggplot, agregar una capa           ggplot(...) + geom_col()
#   :      secuencia de enteros                  1:5
#   ::     función de tal paquete                dplyr::filter()
#   #      comentario, R lo ignora
#
# Los dos errores clásicos: escribir = donde va ==, y preguntar x == NA
# en lugar de is.na(x).


# -----------------------------------------------------------------------------
# 9. PARA SEGUIR PRACTICANDO
# -----------------------------------------------------------------------------
#
# 1) Agreguen al diccionario una columna nueva con una etiqueta que les
#    interese (por ejemplo, si la cuenta es de una persona o de una
#    institución) y rehagan el resumen agrupando por esa columna.
#
# 2) Cambien el orden de las reglas del case_when de tramo_likes: pongan
#    "Bajo" antes que "Sin likes" y vuelvan a contar. ¿Qué pasó y por qué?
#
# 3) Comparen los medios nacionales con los provinciales usando la columna
#    alcance, en lugar de comparar medios con políticos.
#
# 4) Escriban un filter() que use & y otro que use |, sobre las condiciones
#    que quieran, y comparen cuántas filas devuelve cada uno. ¿Cuál da más
#    siempre, y por qué?
#
# 5) Descomenten las tres líneas de abajo. Es la distribución completa de los
#    likes, no sólo su resumen. La escala logarítmica sirve cuando los valores
#    van de 0 a 170.000 y en escala normal no se ve nada.
#
ggplot(propios, aes(x = tipo, y = like_count + 1, fill = tipo)) +
  geom_boxplot() + scale_y_log10() + scale_fill_manual(values = colores) +
  labs(title = "Distribución de likes por tipo de cuenta") + theme_minimal()
#
# 6) Anoten en la bitácora una decisión de etiquetado que les haya generado
#    dudas, y por qué la resolvieron como la resolvieron.

nombre_archivo <- "datos.csv"
write.csv(datos, nombre_archivo, row.names = FALSE)
