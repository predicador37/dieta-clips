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
(persona (edad ?e&:(>= ?e 60)))
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
(persona (edad ?e&:(>= ?e 60)))
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

(defrule generar-dietas-12 "Genera dietas de 12 alimentos"

(rcd ?rcd)
(alimento (nombre ?nombre-alimento-1) (grupo ?grupo-alimento-1)(kcal ?kcal-alimento-1)(proteinas ?proteinas-alimento-1)(grasas ?grasas-alimento-1)(hidratos ?hidratos-alimento-1))
(alimento (nombre ?nombre-alimento-2) (grupo ?grupo-alimento-2)(kcal ?kcal-alimento-2)(proteinas ?proteinas-alimento-2)(grasas ?grasas-alimento-2)(hidratos ?hidratos-alimento-2))
(alimento (nombre ?nombre-alimento-3) (grupo ?grupo-alimento-3)(kcal ?kcal-alimento-3)(proteinas ?proteinas-alimento-3)(grasas ?grasas-alimento-3)(hidratos ?hidratos-alimento-3))
(alimento (nombre ?nombre-alimento-4) (grupo ?grupo-alimento-4)(kcal ?kcal-alimento-4)(proteinas ?proteinas-alimento-4)(grasas ?grasas-alimento-4)(hidratos ?hidratos-alimento-4))
(alimento (nombre ?nombre-alimento-5) (grupo ?grupo-alimento-5)(kcal ?kcal-alimento-5)(proteinas ?proteinas-alimento-5)(grasas ?grasas-alimento-5)(hidratos ?hidratos-alimento-5))
(alimento (nombre ?nombre-alimento-6) (grupo ?grupo-alimento-6)(kcal ?kcal-alimento-6)(proteinas ?proteinas-alimento-6)(grasas ?grasas-alimento-6)(hidratos ?hidratos-alimento-6))
(alimento (nombre ?nombre-alimento-7) (grupo ?grupo-alimento-7)(kcal ?kcal-alimento-7)(proteinas ?proteinas-alimento-7)(grasas ?grasas-alimento-7)(hidratos ?hidratos-alimento-7))
(alimento (nombre ?nombre-alimento-8) (grupo ?grupo-alimento-8)(kcal ?kcal-alimento-8)(proteinas ?proteinas-alimento-8)(grasas ?grasas-alimento-8)(hidratos ?hidratos-alimento-8))
(alimento (nombre ?nombre-alimento-9) (grupo ?grupo-alimento-9)(kcal ?kcal-alimento-9)(proteinas ?proteinas-alimento-9)(grasas ?grasas-alimento-9)(hidratos ?hidratos-alimento-9))
(alimento (nombre ?nombre-alimento-10) (grupo ?grupo-alimento-10)(kcal ?kcal-alimento-10)(proteinas ?proteinas-alimento-10)(grasas ?grasas-alimento-10)(hidratos ?hidratos-alimento-10))
(alimento (nombre ?nombre-alimento-11) (grupo ?grupo-alimento-11)(kcal ?kcal-alimento-11)(proteinas ?proteinas-alimento-11)(grasas ?grasas-alimento-11)(hidratos ?hidratos-alimento-11))
(alimento (nombre ?nombre-alimento-12) (grupo ?grupo-alimento-12)(kcal ?kcal-alimento-12)(proteinas ?proteinas-alimento-12)(grasas ?grasas-alimento-12)(hidratos ?hidratos-alimento-12))



(test (<= (+ ?kcal-alimento-1 ?kcal-alimento-2 ?kcal-alimento-3 ?kcal-alimento-4 ?kcal-alimento-5 ?kcal-alimento-6 ?kcal-alimento-7
                            ?kcal-alimento-8 ?kcal-alimento-9 ?kcal-alimento-10 ?kcal-alimento-11 ?kcal-alimento-12) ?rcd))

=>
(bind ?kcal-dieta  (+ ?kcal-alimento-1 ?kcal-alimento-2 ?kcal-alimento-3 ?kcal-alimento-4 ?kcal-alimento-5 ?kcal-alimento-6 ?kcal-alimento-7
                  ?kcal-alimento-8 ?kcal-alimento-9 ?kcal-alimento-10 ?kcal-alimento-11 ?kcal-alimento-12))
;(assert (dieta (kcal ?kcal-dieta) (alimento1 ?nombre-alimento-1) (alimento2 ?nombre-alimento-2) (alimento3 ?nombre-alimento-3)
;(alimento4 ?nombre-alimento-4) (alimento5 ?nombre-alimento-5) (alimento6 ?nombre-alimento-6) (alimento7 ?nombre-alimento-7)
;(alimento8 ?nombre-alimento-8) (alimento9 ?nombre-alimento-9) (alimento10 ?nombre-alimento-10) (alimento11 ?nombre-alimento-11)
;(alimento12 ?nombre-alimento-12)))
(printout t "RCD: " ?rcd  crlf)
(printout t "Calorias totales: " ?kcal-dieta crlf)
(printout t "Dieta: " ?nombre-alimento-1 " " ?nombre-alimento-2 " " ?nombre-alimento-3 " " ?nombre-alimento-4 " "
?nombre-alimento-5 " " ?nombre-alimento-7 " " ?nombre-alimento-7 " " ?nombre-alimento-8 " " ?nombre-alimento-9 " "
?nombre-alimento-10 " " ?nombre-alimento-11 " " ?nombre-alimento-12 crlf)

)


(defrule print-results "Muestra resultados por pantalla"
(rcd ?rcd)
(dieta (kcal ?kcal-dieta) (alimento1 ?nombre-alimento-1) (alimento2 ?nombre-alimento-2) (alimento3 ?nombre-alimento-3)
(alimento4 ?nombre-alimento-4) (alimento5 ?nombre-alimento-5) (alimento6 ?nombre-alimento-6) (alimento7 ?nombre-alimento-7)
(alimento8 ?nombre-alimento-8) (alimento9 ?nombre-alimento-9) (alimento10 ?nombre-alimento-10) (alimento11 ?nombre-alimento-11)
(alimento12 ?nombre-alimento-12))

=>

(printout t "Dieta: " ?nombre-alimento-1 " " ?nombre-alimento-2 " " ?nombre-alimento-3 " " ?nombre-alimento-4 " "
?nombre-alimento-5 " " ?nombre-alimento-7 " " ?nombre-alimento-7 " " ?nombre-alimento-8 " " ?nombre-alimento-9 " "
?nombre-alimento-10 " " ?nombre-alimento-11 " " ?nombre-alimento-12 crlf)
(printout t "RCD: " ?rcd  crlf)
(printout t "Calorias totales: " ?kcal-dieta crlf)
;(printout t "Calorias proteinas: " ?kcal-proteinas crlf)
;(printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
;(printout t "Grupo 1: " ?grupo1 crlf)
;(printout t "Grupo 2: " ?grupo2 crlf)
;(printout t "Grupo 3-6: " ?grupos36 crlf)
;(printout t "Grupo 4: " ?grupo4 crlf)
;(printout t "Grupo 5: " ?grupo5 crlf)


)
