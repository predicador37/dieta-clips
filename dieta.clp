(deftemplate persona
(slot nombre (type SYMBOL))
(multislot apellidos (type SYMBOL))
(slot edad (type INTEGER) (range 0 99))
(slot sexo (type SYMBOL) (allowed-symbols masculino femenino))
(slot peso (type NUMBER) (range 3 150))
(slot actividad (type SYMBOL) (allowed-symbols reposo ligera moderada intensa))
)

(assert (persona (nombre Miguel) (apellidos Expósito Martín) (edad 7) (sexo masculino) (peso 83) (actividad moderada)))

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

(defrule print-results "Muestra resultados por pantalla"
(geb ?g)
(geba ?ga)
=>
(printout t "GEB: " ?g ", GEBA: " ?ga crlf)
)
