# =============================================================================
# TALLER DE CIENCIA DE DATOS Y PSICOLOGÍA
# Script 3. TP 2. Auditar un informe
#
# Datos: df_trabajo_1.csv (publicaciones de X de medios y de políticos, 2024)
#
# Cómo usar este archivo:
#   Igual que los anteriores. De arriba hacia abajo, línea por línea, con
#   Ctrl+Enter (Cmd+Enter en Mac). Todo lo que empieza con # es un comentario.
#
#   Las secciones 0 a 4 ya están escritas: reproducen lo que dice el
#   párrafo 8 del informe que tienen que auditar. Córranlas tal cual.
#
#   Las secciones 5 y 6 dicen "TU TURNO". Ahí el código lo completan ustedes,
#   con ayuda de la IA si hace falta, pero lo corren ustedes en su máquina.
#
#   El CSV tiene que estar en la misma carpeta que este script, y antes de
#   empezar: Session > Set Working Directory > To Source File Location.
# =============================================================================


# -----------------------------------------------------------------------------
# 0. PAQUETES
# -----------------------------------------------------------------------------

# Si ya corrieron el script 1, tidyverse ya está instalado. Si no, saquen el
# # de la línea de abajo, córranla UNA vez, y vuelvan a ponérselo.
# OJO: sin punto ni nada después del paréntesis.
# install.packages("tidyverse")

library(tidyverse)


# -----------------------------------------------------------------------------
# 1. CARGAR LOS DATOS
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
) |>
  rename(
    cuenta = nombre_normalizado,
    texto  = description,
    fecha  = `.fecha`
  )

nrow(datos)   # Tiene que dar 55355. Si no da eso, paren y revisen.


# -----------------------------------------------------------------------------
# 2. QUEDARNOS CON LO QUE VAMOS A ANALIZAR
# -----------------------------------------------------------------------------

# Igual que en el script 1: publicaciones propias (no retuits) y en castellano.
# Esta vez además nos quedamos sólo con los seis POLÍTICOS, porque el párrafo
# 8 del informe habla de ellos.

politicos <- c("javier_milei", "patricia_bullrich", "luis_petri",
               "pablo_javkin", "maximiliano_pullaro", "pablo_cococcioni")

pol <- datos |>
  filter(is_retweet == FALSE, lang == "es", cuenta %in% politicos) |>
  select(cuenta, fecha, texto, like_count, view_count, comment_count)

nrow(pol)     # Tiene que dar 861.

# Antes de cualquier cosa, la pregunta que en la actividad anterior casi
# nadie se hizo: ¿cuántas publicaciones tiene cada cuenta?
pol |> count(cuenta, sort = TRUE)


# -----------------------------------------------------------------------------
# 3. MARCAR LAS PUBLICACIONES QUE HABLAN EN "NOSOTROS"
# -----------------------------------------------------------------------------

# Es el mismo diccionario del script de texto (clase 7). str_detect()
# devuelve TRUE si el texto contiene alguna de esas palabras y FALSE si no.
# \\b quiere decir "borde de palabra": así "nuestro" no se confunde con
# otra palabra que lo contenga.

patron_nosotros <- "\\b(nosotros|nosotras|nuestro|nuestra|nuestros|nuestras)\\b"

pol <- pol |>
  mutate(nosotros = str_detect(str_to_lower(texto), patron_nosotros))

# Siempre contar una etiqueta recién creada:
pol |> count(nosotros)

# Y leer algunos ejemplos, para ver que marca lo que creemos que marca:
pol |> filter(nosotros) |> select(cuenta, texto) |> slice_sample(n = 5)


# -----------------------------------------------------------------------------
# 4. REPRODUCIR LO QUE DICE EL INFORME
# -----------------------------------------------------------------------------

# La comparación tal como la hizo la IA: todos los políticos juntos.
pol |>
  group_by(nosotros) |>
  summarise(
    publicaciones = n(),
    likes_mediana = median(like_count)
  )

# Y la prueba t. Usamos log1p() por lo mismo que vieron con la profe Nati
# con el ingreso: los likes son muy asimétricos (unos pocos posts enormes),
# y el logaritmo los "aplasta". log1p() suma 1 antes, para tolerar los ceros.
t.test(log1p(like_count) ~ nosotros, data = pol)

# Hasta acá, los números coinciden con el informe. El problema no está en
# la cuenta: está en lo que se concluye. Ese es su trabajo.


# -----------------------------------------------------------------------------
# 5. TU TURNO (Parte 3.1, obligatoria). ABRIR LA COMPARACIÓN POR CUENTA
# -----------------------------------------------------------------------------

# a) ¿Quiénes están en cada grupo? Contá las publicaciones por "nosotros" Y
#    por cuenta al mismo tiempo. Pista: count() acepta más de una columna,
#    separadas por coma.

pol |> count(nosotros, cuenta)

# b) Repetí la tabla de la sección 4, pero calculando la mediana por cuenta
#    y por "nosotros". Pista: miren qué va adentro de group_by() en la
#    sección 4, y piensen qué habría que agregarle.

pol |>
  group_by(nosotros, cuenta) |>
  summarise(
    publicaciones = n(),
    likes_mediana = median(like_count)
  )


# -----------------------------------------------------------------------------
# 6. TU TURNO (Parte 3.2, elegí UNA de las dos)
# -----------------------------------------------------------------------------

## Opción A. Rehacer un gráfico del informe ----------------------------------
#
# Este es el punto de partida del gráfico 1 del script 1. Adaptalo para
# rehacer el gráfico 1 o el gráfico 2 del informe, con los criterios de la
# clase de visualización: un título que diga el hallazgo, barras ordenadas,
# color con significado, eje desde cero y todo en castellano.

totales <- propios |>
  count(tipo) |>
  mutate(
    grupo = if_else(tipo == "Medio", "Medios", "Políticos"),
    porcentaje = round(n / sum(n) * 100, 1),
    etiqueta  = paste0(grupo, " — ",
                       format(n, big.mark = ".", decimal.mark = ",", trim = TRUE),
                       " publicaciones (",
                       format(porcentaje, decimal.mark = ",", trim = TRUE), "%)")
  )
resumen <- propios |>
  count(tipo, cuenta) |>
  left_join(totales |> select(tipo, etiqueta), by = "tipo")
ggplot(resumen, aes(x = n, y = fct_reorder(cuenta, n), fill = tipo)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ etiqueta, scales = "free") +
  scale_fill_manual(values = c("Medio" = "firebrick", "Político" = "steelblue")) +
  labs(title = "Cantidad de publicaciones por cuenta",
       x = NULL, y = NULL) +
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(t = 5.5, r = 15, b = 5.5, l = 5.5))

## Opción B. La prueba t dentro de una sola cuenta ----------------------------
#
# Elegí UNA de estas tres cuentas: luis_petri, pablo_javkin o
# maximiliano_pullaro (son las que tienen suficientes casos en los dos
# grupos). Filtrá sus publicaciones y repetí la prueba t de la sección 4
# sólo con ellas.

# una_cuenta <- pol |> filter(cuenta == "...")
# t.test(log1p(like_count) ~ nosotros, data = una_cuenta)
