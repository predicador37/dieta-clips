# Introducción

El presente documento sintetiza las decisiones tomadas a la hora de llevar a cabo la presente práctica. Cabe destacar que, como autor de este material, es la primera vez que mantengo un contacto con un sistema basado en reglas en general y con el entorno CLIPS en particular.

# Entorno y ejecución

Dada la similitud de la sintaxis de CLIPS con LISP, se optó por utilizar un Entorno Integrado de Desarrollo (IDE) para aprovechar funcionalidades como el resaltado de sintaxis. En concreto, se ha utilizado [IntelliJ IDEA](https://www.jetbrains.com/idea/) con un plugin de Clojure, cuya sintaxis es similar.

El código se ha ejecutado con éxito tanto en entornos Windows como en entornos Linux. Para replicar su ejecución, y suponiendo que el ejecutable de clips esté en la variable de entorno `$PATH` del sistema correspondiente, desde el directorio raíz de la práctica en el que se encuentran todos los fuentes, hay que ejecutar las siguientes acciones **en orden**:

        clips
        (load ./hechos_iniciales.clp)
        (load ./dieta.clp)
        (reset)
        (run)
        
Es decir, primero se cargan las plantillas y hechos iniciales y posteriormente las reglas. Con el comando `reset()` se inicializa la base de datos de hechos y las reglas quedan listas para ejecutarse.        

# Enfoque

La planificación del desarrollo de la práctica se ha dividido en cuatro grandes bloques:

- Cálculo de los gastos energéticos y requerimiento calórico diario
- Generación de combinaciones de alimentos (dietas) diarias
- Reparto de alimentos de cada dieta en 5 comidas
- Salida y entrada de datos

La primera parte no revistió prácticamente dificultad, pudiéndose programar los cálculos en un tiempo razonable. En cambio, la generación de combinaciones de alimentos ha requerido de mucho tiempo y esfuerzo. La tercera parte presentó una dificultad media y la última fue muy sencilla.



# Modelo de conocimiento

# Sistema de reglas

## Primeros pasos

En primer lugar, se trató de plantear el problema siguiendo como modelo el ejercicio número 11 de la colección de problemas (composición de programas musicales en emisoras de radio). Debido a mi conocimiento, formación y experiencia en lenguajes procedimentales y orientados a objetos, este enfoque trataba de conseguir que las reglas se ejecutaran como si de uno de estos lenguajes se trataran, lo cual resultó contraproducente. Se generaron muchas reglas, muchas variables de control por fases, muchas excepciones a los casos generales... 







Reglas:

suma total de calorias < geb + geba

4-6 raciones/día de alimentos de los grupos 3 y 6
2-4 raciones/día del grupo 4
2-3 raciones del grupo 5
2-3 raciones del grupo 1
2-3 raciones del grupo 2
40-60 gramos de grasa

es crucial para nuestra práctica que las dietas que se generen
sean variadas.

La contribución porcentual de
macro-nutrientes a las calorías totales debe ser aproximadamente de:
50 − 55% carbohidratos
30 − 35% grasas. (15 − 20% monoinsaturados)
10 − 15% proteínas.


los carbohidratos aportan 4 Kcal/g, las grasas 9
Kcal/g y las proteínas 4 kcal/g.
--------------------------
seleccionar alimentos al azar, de uno en uno
si se cumplen las condiciones, se añaden a la lista
contadores necesarios:
grupo-36
grupo-4
grupo-5
grupo-1
grupo-2
gramos-grasa
carbohidratos
grasas
proteinas

reglas:
4 < grupo-36 < 6
2 < grupo-4 < 4
2 < grupo-5 < 3
2 < grupo-1 < 3
2 < grupo-2 < 3
40 < ggrasa < 60
rcd*50/100 < carbohidratos * 4 <  rcd*55/100
rcd*30/100 < grasas * 9 <  rcd*35/100
rcd*10/100 < proteinas * 4 <  rcd*15/100
100*carbohidratos/rcd + 100*grasas/rcd + 100*proteinas/rcd = 100

hay que distribuir los requisitos calóricos diarios en 5 comidas
desayuna como un rey, come como un príncipe y cena como un mendigo
las otras dos, ligeritas
40
10
30
5
15

rcd = geb + geba

opción 1:
- obtener listado de alimentos qeu cumplan requisitos diarios
- distribuir en 5 comidas (por adecuación y calorías)

opcion 2:
- obtener listado de desayunos con alimentos que cumplan requisitos calóricos y de macronutrientes para el desayuno
-obtener listado de almuerzos...
- para cada comida, almacenar el número de alimentos de cada grupo
- buscar una combinación que satisfaga los requisitos



desayuno - lunes
seleccionar pares (alimentos, gramos) tales que
suma de calorias de todas las cantidades de alimentos > 0.39*rcd && < 0.40 * rcd
suma de (g proteinas * 4 


Prueba de concepto

Listado de alimentos que aportan el rcd


#IDEAS
- Dividir grupos de alimentos en subgrupos, según su aporte
- Cambiar alimentos para ajustar los subgrupos
- OK Introducir grasas
- Mirar por qué no se elige el más adecuado en cada iteración
- ¿Cuál es el más adecuado?
- Implementar comprobación de grupos (máximos)
- Introducir más raciones de los mismos alimentos en la base de hechos para tener más donde seleccionar