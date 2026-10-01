# =====================================================================
# CORRELACION - EJERCICIO DE LA GASEOSA - CODIGO CORREGIDO
# =====================================================================
# Correcciones:
# 1. Faltaba library(readxl) para poder usar read_excel().
# 2. rename() fallaba porque los nombres originales de las columnas
#    tienen espacios y parentesis ("Tiempo de entrega (min)", "Peso en Kg").
#    En R, un nombre de columna con espacios/parentesis se debe escribir
#    entre backticks (`), de lo contrario se interpreta como codigo R
#    y arroja "unexpected ','".

# Librerias
library(tidyverse)
library(readxl)

# Datos
df <- read_excel("METODOS ESTADISTICOS/Correlacion/datos_entrega_gaseosa.xlsx")

# Transformacion (con backticks en los nombres originales)
df <- df |>
  rename(tiempo  = `Tiempo de entrega (min)`,
         peso_kg = `Peso en Kg`)

# Diagrama de dispersion
df |>
  ggplot(aes(x = peso_kg, y = tiempo)) +
  geom_point() +
  theme_bw() +
  labs(title = "Diagrama de dispersión",
       x = "Peso en Kg",
       y = "Tiempo en minutos")

# Supuesto de normalidad
shapiro.test(df$tiempo)
shapiro.test(df$peso_kg)

# Coeficiente de correlacion de Pearson (calculo manual)
x <- df$tiempo
y <- df$peso_kg
xbar <- mean(x)
ybar <- mean(y)
xc <- x - xbar
yc <- y - ybar
sxy <- sum(xc * yc)
sxx <- sum(xc^2)
syy <- sum(yc^2)
r <- sxy / sqrt(sxx * syy)

# Con la funcion cor()
cor(x, y, method = "pearson")

# Con cor.test(): prueba de hipotesis y el intervalo de confianza
cor.test(x, y, method = "pearson")

# Prueba de hipotesis paso a paso de la correlacion de Pearson
n <- nrow(df)
gl <- n - 2
t_0 <- r * sqrt(n - 2) / sqrt(1 - r^2)
alpha <- 0.05
t_tab <- qt(1 - alpha / 2, df = gl)
p_valor <- 2 * pt(-abs(t_0), df = gl)
