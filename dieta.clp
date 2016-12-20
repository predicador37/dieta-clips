(deftemplate persona
(slot nombre (type SYMBOL))
(multislot apellidos (type SYMBOL))
(slot edad (type INTEGER) (range 0 99))
(slot sexo (type SYMBOL) (allowed-symbols masculino femenino))
(slot peso (type NUMBER) (range 3 150))
(slot actividad (type SYMBOL) (allowed-symbols reposo ligera moderada intensa))
(slot objetivo (type SYMBOL) (allowed-symbols mantener reducir))
)

(deftemplate alimento
(slot nombre (type SYMBOL))
(slot descripcion (type SYMBOL))
(slot grupo (type SYMBOL) (allowed-symbols 1 2 3 4 5 6 7))
(slot tipo (type SYMBOL) (allowed-symbols plasticos energeticos reguladores))
(slot kcal (type NUMBER))
(slot proteinas (type NUMBER))
(slot grasas (type NUMBER))
(slot hidratos (type NUMBER))
)

(assert (persona (nombre Miguel) (apellidos Expósito Martín) (edad 7) (sexo masculino) (peso 83) (actividad moderada) (objetivo reducir)))

(defrule calcula-geb-1 "Calcula GEB varones 3 años"
(persona (edad ?e&: (< ?e 3)))
(persona (sexo ?s&: (eq ?s masculino)))
(persona (peso ?p))
=>
(assert (geb (- (* 60.9 ?p) 54 )))
)

(defrule calcula-geb-2 "Calcula GEB varones 3-10 años"
(persona (edad ?e&:(>= ?e 3) &: (< ?e 10)))
(persona (sexo ?s&: (eq ?s masculino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 22.7 ?p) 495 )))
)

(defrule calcula-geb-3 "Calcula GEB varones 10-18 años"
(persona (edad ?e&:(>= ?e 10) &: (< ?e 18)))
(persona (sexo ?s&: (eq ?s masculino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 17.5 ?p) 651 )))
)

(defrule calcula-geb-4 "Calcula GEB varones 18-30 años"
(persona (edad ?e&:(>= ?e 18) &: (< ?e 30)))
(persona (sexo ?s&: (eq ?s masculino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 15.3 ?p) 679 )))
)

(defrule calcula-geb-5 "Calcula GEB varones 30-60 años"
(persona (edad ?e&:(>= ?e 30) &: (<= ?e 60)))
(persona (sexo ?s&: (eq ?s masculino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 11.6 ?p) 879 )))
)

(defrule calcula-geb-6 "Calcula GEB varones 60 años"
(persona (edad ?e&:(>= ?e 60)
(persona (sexo ?s&: (eq ?s masculino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 13.5 ?p) 487 )))
)

(defrule calcula-geb-7 "Calcula GEB mujeres 3 años"
(persona (edad ?e&: (< ?e 3)))
(persona (sexo ?s&: (eq ?s femenino)))
(persona (peso ?p))
=>
(assert (geb (- (* 61.0 ?p) 51 )))
)

(defrule calcula-geb-8 "Calcula GEB mujeres 3-10 años"
(persona (edad ?e&:(>= ?e 3) &: (< ?e 10)))
(persona (sexo ?s&: (eq ?s femenino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 22.5 ?p) 499 )))
)

(defrule calcula-geb-9 "Calcula GEB mujeres 10-18 años"
(persona (edad ?e&:(>= ?e 10) &: (< ?e 18)))
(persona (sexo ?s&: (eq ?s femenino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 12.2 ?p) 746 )))
)

(defrule calcula-geb-10 "Calcula GEB mujeres 18-30 años"
(persona (edad ?e&:(>= ?e 18) &: (< ?e 30)))
(persona (sexo ?s&: (eq ?s femenino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 14.7 ?p) 496 )))
)

(defrule calcula-geb-11 "Calcula GEB mujeres 30-60 años"
(persona (edad ?e&:(>= ?e 30) &: (<= ?e 60)))
(persona (sexo ?s&: (eq ?s femenino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 8.7 ?p) 829 )))
)

(defrule calcula-geb-12 "Calcula GEB mujeres 60 años"
(persona (edad ?e&:(>= ?e 60)
(persona (sexo ?s&: (eq ?s femenino)))
(persona (peso ?p))
=>
(assert (geb (+ (* 10.5 ?p) 596 )))
)

(defrule calcula-geba-reposo
(persona (actividad ?a))
=>
(switch ?a
(case reposo then (assert (geba 0)))
(case ligera then (assert (geba 200)))
(case moderada then (assert (geba 400)))
(case intensa then (assert (geba 1000)))
)
)

(defrule calcula-rcd
(geb ?g)
(geba ?ga)
(persona (objetivo ?o))
=>
(switch ?o
(case mantener then (assert (rcd (+ ?g ?ga))))
(case reducir then (assert (rcd (* (+ ?g ?ga) 0.9))))
)
)

(defrule print-results "Muestra resultados por pantalla"
(geb ?g)
(geba ?ga)
=>
(printout t "GEB: " ?g ", GEBA: " ?ga crlf)
)


(assert (alimento (nombre leche-desnatada) (descripcion Leche desnatada) (grupo 1) (tipo plasticos) (kcal 33) (proteinas 3,4) (grasas 0,2) (hidratos 4,7)))
(assert (alimento (nombre yogur-desnatado) (descripcion Yogur desnatado) (grupo 1) (tipo plasticos) (kcal 36) (proteinas 3,3) (grasas 0,9) (hidratos 4)))
(assert (alimento (nombre requeson) (descripcion Requesón) (grupo 1) (tipo plasticos) (kcal 96) (proteinas 13,6) (grasas 4) (hidratos 1,4)))
(assert (alimento (nombre queso-fresco) (descripcion Queso fresco) (grupo 1) (tipo plasticos) (kcal 307) (proteinas 24) (grasas 23) (hidratos 1)))
(assert (alimento (nombre yogur-con-frutas) (descripcion Yogur con frutas) (grupo 1) (tipo plasticos) (kcal 89) (proteinas 2,8) (grasas 3,3) (hidratos 12,6)))
(assert (alimento (nombre queso-edam) (descripcion Queso edam) (grupo 1) (tipo plasticos) (kcal 306) (proteinas 26) (grasas 22) (hidratos 1)))
(assert (alimento (nombre yogur-con-cereales) (descripcion Yogur con cereales) (grupo 1) (tipo plasticos) (kcal 48) (proteinas 3) (grasas 0,05) (hidratos 9)))
(assert (alimento (nombre queso-philadelphia) (descripcion Queso Philadelphia) (grupo 1) (tipo plasticos) (kcal 200) (proteinas 10) (grasas 16,6) (hidratos 6,6)))
(assert (alimento (nombre roquefort) (descripcion Roquefort) (grupo 1) (tipo plasticos) (kcal 413) (proteinas 23) (grasas 35) (hidratos 2)))
(assert (alimento (nombre yogur-descr-saborizado) (descripcion Yogur descr saborizado) (grupo 1) (tipo plasticos) (kcal 34,5) (proteinas 3,6) (grasas 0,05) (hidratos 4,4)))
(assert (alimento (nombre huevo-entero) (descripcion Huevo entero) (grupo 2) (tipo plasticos) (kcal 156) (proteinas 13) (grasas 11,1) (hidratos 0)))
(assert (alimento (nombre bistec-de-ternera) (descripcion Bistec de ternera) (grupo 2) (tipo plasticos) (kcal 92) (proteinas 20,7) (grasas 1) (hidratos 0,5)))
(assert (alimento (nombre pollo-pechuga) (descripcion Pollo pechuga) (grupo 2) (tipo plasticos) (kcal 108) (proteinas 22,4) (grasas 2,1) (hidratos 0)))
(assert (alimento (nombre cerdo-carne-magra) (descripcion Cerdo carne magra) (grupo 2) (tipo plasticos) (kcal 146) (proteinas 19,9) (grasas 6,8) (hidratos 0)))
(assert (alimento (nombre lacon) (descripcion Lacón) (grupo 2) (tipo plasticos) (kcal 361) (proteinas 19,2) (grasas 31,6) (hidratos 0)))
(assert (alimento (nombre merluza) (descripcion Merluza) (grupo 2) (tipo plasticos) (kcal 71) (proteinas 17) (grasas 0,3) (hidratos 0)))
(assert (alimento (nombre salmon) (descripcion Salmón) (grupo 2) (tipo plasticos) (kcal 176) (proteinas 18,4) (grasas 12) (hidratos 0)))
(assert (alimento (nombre bacalao) (descripcion Bacalao) (grupo 2) (tipo plasticos) (kcal 122) (proteinas 29) (grasas 0,7) (hidratos 0)))
(assert (alimento (nombre atun-fresco) (descripcion Atún fresco) (grupo 2) (tipo plasticos) (kcal 158) (proteinas 21,5) (grasas 8) (hidratos 0)))
(assert (alimento (nombre lubina) (descripcion Lubina) (grupo 2) (tipo plasticos) (kcal 82) (proteinas 16,6) (grasas 1,5) (hidratos 0,6)))
(assert (alimento (nombre patatas-asadas) (descripcion Patatas asadas) (grupo 3) (tipo energeticos) (kcal 142) (proteinas 2,9) (grasas 0,3) (hidratos 31,7)))
(assert (alimento (nombre patatas-guisadas) (descripcion Patatas guisadas) (grupo 3) (tipo energeticos) (kcal 89) (proteinas 0,7) (grasas 3,5) (hidratos 13,7)))
(assert (alimento (nombre garbanzos-cocidos) (descripcion Garbanzos cocidos) (grupo 3) (tipo energeticos) (kcal 90) (proteinas 4) (grasas 3,4) (hidratos 10)))
(assert (alimento (nombre lentejas-guisadas) (descripcion Lentejas guisadas) (grupo 3) (tipo energeticos) (kcal 120) (proteinas 6,6) (grasas 3,5) (hidratos 15,5)))
(assert (alimento (nombre judias-blancas-guisadas) (descripcion Judías blancas guisadas) (grupo 3) (tipo energeticos) (kcal 109) (proteinas 4) (grasas 5) (hidratos 11)))
(assert (alimento (nombre almendra) (descripcion Almendra) (grupo 3) (tipo energeticos) (kcal 499) (proteinas 16) (grasas 51,4) (hidratos 22)))
(assert (alimento (nombre avellana) (descripcion Avellana) (grupo 3) (tipo energeticos) (kcal 625) (proteinas 13) (grasas 62,9) (hidratos 10)))
(assert (alimento (nombre nuez) (descripcion Nuez) (grupo 3) (tipo energeticos) (kcal 670) (proteinas 15,6) (grasas 63,3) (hidratos 11,2)))
(assert (alimento (nombre judias-blancas-estofadas) (descripcion Judias blancas estofadas) (grupo 3) (tipo energeticos) (kcal 113) (proteinas 3,7) (grasas 6,4) (hidratos 10)))
(assert (alimento (nombre ciruela-pasa) (descripcion Ciruela pasa) (grupo 3) (tipo energeticos) (kcal 177) (proteinas 2,2) (grasas 0,5) (hidratos 43,7)))
(assert (alimento (nombre acelga) (descripcion Acelga) (grupo 4) (tipo reguladores) (kcal 25) (proteinas 2,4) (grasas 0,3) (hidratos 4,6)))
(assert (alimento (nombre lechuga) (descripcion Lechuga) (grupo 4) (tipo reguladores) (kcal 19) (proteinas 1,8) (grasas 0,4) (hidratos 2,2)))
(assert (alimento (nombre tomate) (descripcion Tomate) (grupo 4) (tipo reguladores) (kcal 16) (proteinas 1) (grasas 0,2) (hidratos 2,9)))
(assert (alimento (nombre zanahoria) (descripcion Zanahoria) (grupo 4) (tipo reguladores) (kcal 37) (proteinas 1) (grasas 0,2) (hidratos 7,8)))
(assert (alimento (nombre espinacas-cocidas) (descripcion Espinacas cocidas) (grupo 4) (tipo reguladores) (kcal 134) (proteinas 2,2) (grasas 13) (hidratos 0,4)))
(assert (alimento (nombre puerro) (descripcion Puerro) (grupo 4) (tipo reguladores) (kcal 26) (proteinas 2,1) (grasas 0,1) (hidratos 6)))
(assert (alimento (nombre calabacin) (descripcion Calabacín) (grupo 4) (tipo reguladores) (kcal 12) (proteinas 1,3) (grasas 0,1) (hidratos 1,4)))
(assert (alimento (nombre brecol) (descripcion Brécol) (grupo 4) (tipo reguladores) (kcal 31) (proteinas 3,3) (grasas 0,2) (hidratos 4)))
(assert (alimento (nombre cebolla) (descripcion Cebolla) (grupo 4) (tipo reguladores) (kcal 24) (proteinas 1) (grasas 0) (hidratos 5,2)))
(assert (alimento (nombre apio) (descripcion Apio) (grupo 4) (tipo reguladores) (kcal 22) (proteinas 2,3) (grasas 0,2) (hidratos 2,4)))
(assert (alimento (nombre kiwi) (descripcion Kiwi) (grupo 5) (tipo reguladores) (kcal 53) (proteinas 0,8) (grasas 0,6) (hidratos 10,8)))
(assert (alimento (nombre manzana) (descripcion Manzana) (grupo 5) (tipo reguladores) (kcal 45) (proteinas 0,2) (grasas 0,3) (hidratos 10,4)))
(assert (alimento (nombre platano) (descripcion Plátano) (grupo 5) (tipo reguladores) (kcal 85) (proteinas 1,2) (grasas 0,3) (hidratos 19,5)))
(assert (alimento (nombre naranja) (descripcion Naranja) (grupo 5) (tipo reguladores) (kcal 53) (proteinas 1) (grasas 0,2) (hidratos 11,7)))
(assert (alimento (nombre piña) (descripcion Piña) (grupo 5) (tipo reguladores) (kcal 55) (proteinas 0,5) (grasas 0,2) (hidratos 12,7)))
(assert (alimento (nombre limon) (descripcion Limón) (grupo 5) (tipo reguladores) (kcal 14) (proteinas 0,6) (grasas 0) (hidratos 3,2)))
(assert (alimento (nombre pera) (descripcion Pera) (grupo 5) (tipo reguladores) (kcal 58) (proteinas 0,7) (grasas 0,1) (hidratos 15)))
(assert (alimento (nombre arandano) (descripcion Arandano) (grupo 5) (tipo reguladores) (kcal 41) (proteinas 0,6) (grasas 0,4) (hidratos 10,1)))
(assert (alimento (nombre melocoton) (descripcion Melocotón) (grupo 5) (tipo reguladores) (kcal 30) (proteinas 0,8) (grasas 0,1) (hidratos 6,9)))
(assert (alimento (nombre sandia) (descripcion Sandía) (grupo 5) (tipo reguladores) (kcal 15) (proteinas 0,7) (grasas 0) (hidratos 3,7)))
(assert (alimento (nombre arroz-cocido) (descripcion Arroz Cocido) (grupo 6) (tipo energeticos) (kcal 123) (proteinas 2,2) (grasas 0,3) (hidratos 27,9)))
(assert (alimento (nombre pan-integral) (descripcion Pan Integral) (grupo 6) (tipo energeticos) (kcal 230) (proteinas 9) (grasas 1) (hidratos )))
(assert (alimento (nombre avena-salvado-de) (descripcion Avena salvado de) (grupo 6) (tipo energeticos) (kcal 383) (proteinas 17) (grasas 8,8) (hidratos 58,9)))
(assert (alimento (nombre galleta-tipo-maria) (descripcion Galleta tipo María) (grupo 6) (tipo energeticos) (kcal 409) (proteinas 6,8) (grasas 8,1) (hidratos 82,3)))
(assert (alimento (nombre pasta-seca-al-huevo) (descripcion Pasta seca al huevo) (grupo 6) (tipo energeticos) (kcal 368) (proteinas 19) (grasas 0,2) (hidratos 73,4)))
(assert (alimento (nombre fideos-de-harina-integral) (descripcion Fideos de harina integral) (grupo 6) (tipo energeticos) (kcal 359) (proteinas 15,4) (grasas 1,7) (hidratos 70)))
(assert (alimento (nombre miel) (descripcion Miel) (grupo 6) (tipo energeticos) (kcal 300) (proteinas 0,6) (grasas 0) (hidratos 80)))
(assert (alimento (nombre mermelada) (descripcion Mermelada) (grupo 6) (tipo energeticos) (kcal 272) (proteinas 0,6) (grasas 0,1) (hidratos 70)))
(assert (alimento (nombre chocolate-amargo) (descripcion Chocolate amargo) (grupo 6) (tipo energeticos) (kcal 570) (proteinas 5,5) (grasas 52,9) (hidratos 18)))
(assert (alimento (nombre pan-tostado) (descripcion Pan Tostado) (grupo 6) (tipo energeticos) (kcal 420) (proteinas 11,3) (grasas 6) (hidratos 83)))
(assert (alimento (nombre aceite-de-oliva) (descripcion Aceite de oliva) (grupo 7) (tipo energeticos) (kcal 900) (proteinas 0) (grasas 100) (hidratos 0)))
(assert (alimento (nombre mantequilla) (descripcion Mantequilla) (grupo 7) (tipo energeticos) (kcal 750) (proteinas 0,6) (grasas 83) (hidratos 0,3)))
(assert (alimento (nombre nata-liquida) (descripcion Nata liquida) (grupo 7) (tipo energeticos) (kcal 422) (proteinas 1,7) (grasas 45) (hidratos 2,5)))
(assert (alimento (nombre margarina) (descripcion Margarina) (grupo 7) (tipo energeticos) (kcal 747) (proteinas 0) (grasas 99) (hidratos 0,3)))
(assert (alimento (nombre manteca-de-cerdo) (descripcion Manteca de cerdo) (grupo 7) (tipo energeticos) (kcal 891) (proteinas 0,3) (grasas 82,8) (hidratos 0,2)))
(assert (alimento (nombre manteca-de-cacao) (descripcion Manteca de cacao) (grupo 7) (tipo energeticos) (kcal 925) (proteinas 0) (grasas 94,5) (hidratos 0)))
(assert (alimento (nombre aceite-de-semillas) (descripcion Aceite de semillas) (grupo 7) (tipo energeticos) (kcal 900) (proteinas 0) (grasas 100) (hidratos 0)))
(assert (alimento (nombre mayonesa) (descripcion Mayonesa) (grupo 7) (tipo energeticos) (kcal 800) (proteinas 1) (grasas 81,3) (hidratos 1,5)))
(assert (alimento (nombre aceite-de-palma) (descripcion Aceite de palma) (grupo 7) (tipo energeticos) (kcal 899) (proteinas 0) (grasas 99,9) (hidratos 0)))
(assert (alimento (nombre margarina-ligera) (descripcion Margarina ligera) (grupo 7) (tipo energeticos) (kcal 368) (proteinas 1,6) (grasas 40) (hidratos 0,4)))



