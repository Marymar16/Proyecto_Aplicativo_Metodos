# Práctica de clase (fuera del proyecto principal)

Estos dos scripts NO son parte del proyecto aplicativo de "campañas de
mercadeo en el hogar" (ese análisis está en 01-intro.Rmd, 02-literature.Rmd
y 03-method.Rmd). Son ejercicios sueltos de clase que usan otros datasets
(encuesta de opinión por ciudad, Titanic, iris, entrega de gaseosa), y se
dejan aparte para no mezclarlos con los capítulos del proyecto.

- `tablas_contingencia_corregido.R`: se corrigió el bloque del Titanic,
  que fallaba porque `Titanic` es un array de tabla (no un data.frame) y
  se usaba `data = df` sin que `df` existiera en ese contexto. Se agregó
  `as.data.frame(Titanic)` antes de construir la tabla de contingencia.

- `correlacion_gaseosa_corregido.R`: se agregó `library(readxl)` (faltaba
  para poder usar `read_excel()`) y se corrigieron los nombres de columna
  en `rename()`, que necesitan comillas invertidas (`` ` ``) por tener
  espacios y paréntesis ("Tiempo de entrega (min)", "Peso en Kg").
