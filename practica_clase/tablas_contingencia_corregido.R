# =====================================================================
# TABLAS DE CONTINGENCIA - CODIGO CORREGIDO
# =====================================================================
# Correccion principal: el bloque de Titanic usaba xtabs(..., data = df)
# pero 'Titanic' es un array de tabla (no un data.frame), y 'df' no
# estaba definido en este contexto. Se agrega la conversion con
# as.data.frame(Titanic) antes de construir la tabla de contingencia.

# Librerias
library(tidyverse)

# ---------------------------------------------------------------------
# EJEMPLO 1: Encuesta de opinion segun ciudad (sin cambios, ya funcionaba)
# ---------------------------------------------------------------------
observados <- matrix(c(82, 93, 25,
                       70, 62, 18,
                       62, 67, 21),
                     nrow = 3, byrow = FALSE,
                     dimnames = list(
                       Opinion = c("A favor", "En contra", "Sin decisión"),
                       Ciudad = c("Barranquilleros", "Samarios", "Cartageneros")
                     ))

filas_totales   <- rowSums(observados)
col_totales     <- colSums(observados)
total_general   <- sum(observados)

esperados <- outer(filas_totales, col_totales,
                    FUN = function(f, c) f * c / total_general)

# Chi cuadrado calculado a mano ----
chi_cuadrado <- sum((observados - esperados)^2 / esperados)
gl <- (nrow(observados) - 1) * (ncol(observados) - 1)

# Chi cuadrado tabulado ----
alpha <- 0.05
chi_cuadrado_tab <- qchisq(1 - alpha, gl)

# p-valor ----
p_valor <- pchisq(chi_cuadrado, gl, lower.tail = FALSE)

# La prueba chi cuadrado indica que NO hay diferencia significativa en las
# proporciones de las ciudades segun los niveles a favor/en contra/indecision
# frente a la nueva ley (chi-cuadrado(2) = 1.52, p-valor = 0.8218 aprox.)

# Verificacion con la funcion nativa
chisq.test(observados)

# ---------------------------------------------------------------------
# EJEMPLO 2: Conjunto de datos del Titanic (CORREGIDO)
# ---------------------------------------------------------------------
data("Titanic")

# 'Titanic' es un objeto de clase table/array, no un data.frame.
# Hay que convertirlo primero para poder usar xtabs()/dplyr sobre el:
titanic_df <- as.data.frame(Titanic)

# Ahora si se puede construir la tabla de contingencia
xtabs(Freq ~ Class + Survived, data = titanic_df) -> tabla_titanic
tabla_titanic
chisq.test(tabla_titanic)

# ---------------------------------------------------------------------
# EJEMPLO 3: Conjunto de datos iris (sin cambios, ya funcionaba)
# ---------------------------------------------------------------------
data("iris")
iris$Sepal.Length_Cat <- ifelse(iris$Sepal.Length <= median(iris$Sepal.Length),
                                 "Corta", "Largo")

x <- iris$Species
y <- iris$Sepal.Length_Cat
tabla_iris <- as.matrix(table(x, y))

total_g  <- sum(tabla_iris)
esperado <- outer(rowSums(tabla_iris), colSums(tabla_iris),
                   FUN = function(f, c) f * c / total_g)

# Chi cuadrado calculado a mano ----
chi_cuadrado_iris <- sum((tabla_iris - esperado)^2 / esperado)
gl_iris <- (nrow(tabla_iris) - 1) * (ncol(tabla_iris) - 1)

# Chi cuadrado tabulado ----
chi_cuadrado_tab_iris <- qchisq(1 - alpha, gl_iris)

# p-valor ----
p_valor_iris <- pchisq(chi_cuadrado_iris, gl_iris, lower.tail = FALSE)

# Verificacion con la funcion nativa
chisq.test(tabla_iris)
