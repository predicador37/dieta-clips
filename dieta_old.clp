(defrule calcula-geb-1 "Calcula GEB varones 3 años"
         (persona (edad ?e&: (< ?e 3)))
         (persona (sexo ?s&: (eq ?s masculino)))
         (persona (peso ?p))
         =>
         (assert (geb (- (* 60.9 ?p) 54)))
         )

(defrule calcula-geb-2 "Calcula GEB varones 3-10 años"
         (persona (edad ?e&: (>= ?e 3) &: (< ?e 10)))
         (persona (sexo ?s&: (eq ?s masculino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 22.7 ?p) 495)))
         )

(defrule calcula-geb-3 "Calcula GEB varones 10-18 años"
         (persona (edad ?e&: (>= ?e 10) &: (< ?e 18)))
         (persona (sexo ?s&: (eq ?s masculino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 17.5 ?p) 651)))
         )

(defrule calcula-geb-4 "Calcula GEB varones 18-30 años"
         (persona (edad ?e&: (>= ?e 18) &: (< ?e 30)))
         (persona (sexo ?s&: (eq ?s masculino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 15.3 ?p) 679)))
         )

(defrule calcula-geb-5 "Calcula GEB varones 30-60 años"
         (persona (edad ?e&: (>= ?e 30) &: (<= ?e 60)))
         (persona (sexo ?s&: (eq ?s masculino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 11.6 ?p) 879)))
         )

(defrule calcula-geb-6 "Calcula GEB varones 60 años"
         (persona (edad ?e&: (>= ?e 60)))
         (persona (sexo ?s&: (eq ?s masculino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 13.5 ?p) 487)))
         )

(defrule calcula-geb-7 "Calcula GEB mujeres 3 años"
         (persona (edad ?e&: (< ?e 3)))
         (persona (sexo ?s&: (eq ?s femenino)))
         (persona (peso ?p))
         =>
         (assert (geb (- (* 61.0 ?p) 51)))
         )

(defrule calcula-geb-8 "Calcula GEB mujeres 3-10 años"
         (persona (edad ?e&: (>= ?e 3) &: (< ?e 10)))
         (persona (sexo ?s&: (eq ?s femenino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 22.5 ?p) 499)))
         )

(defrule calcula-geb-9 "Calcula GEB mujeres 10-18 años"
         (persona (edad ?e&: (>= ?e 10) &: (< ?e 18)))
         (persona (sexo ?s&: (eq ?s femenino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 12.2 ?p) 746)))
         )

(defrule calcula-geb-10 "Calcula GEB mujeres 18-30 años"
         (persona (edad ?e&: (>= ?e 18) &: (< ?e 30)))
         (persona (sexo ?s&: (eq ?s femenino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 14.7 ?p) 496)))
         )

(defrule calcula-geb-11 "Calcula GEB mujeres 30-60 años"
         (persona (edad ?e&: (>= ?e 30) &: (<= ?e 60)))
         (persona (sexo ?s&: (eq ?s femenino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 8.7 ?p) 829)))
         )

(defrule calcula-geb-12 "Calcula GEB mujeres 60 años"
         (persona (edad ?e&: (>= ?e 60)))
         (persona (sexo ?s&: (eq ?s femenino)))
         (persona (peso ?p))
         =>
         (assert (geb (+ (* 10.5 ?p) 596)))
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
         (assert (fase grupo-inicial))
         )

(defrule grupo-inicial "Elige aleatoriamente un grupo inicial"
         ?fase <- (fase grupo-inicial)
         =>
         (assert (grupo-inicial (random 1 7)))
         (retract ?fase)
         )

(defrule primer-alimento-1 "Elige el primer alimento al azar del grupo 1"
         ;(racion (cantidad ?racion))
         ?gi <- (grupo-inicial 1)
         ?ultimos <- (alimentos-usados (grupo1 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         (rcd ?rcd)
         ?d <- (dieta (dia lunes) (kcal 0) (kcal-proteinas ?kcal-proteinas) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5))
         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento) (proteinas ?proteinas) (grupo 1))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) 0) ?rcd))
         ;(test (<= ?kcal-alimento ?rcd))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))

         =>

         (modify ?d (alimentos ?nombre-alimento ?racion) (kcal (/ (* ?kcal-alimento ?racion) 100)) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo1 (+ ?grupo1 1)))
         ;(modify ?a (lunes ?racion))
         (modify ?ultimos (grupo1 $?usados ?nombre-alimento))
         (assert (fase grupo2))
         ;falta añadir alimento a lista de alimentos usados
         (retract ?gi)
         )

(defrule primer-alimento-2 "Elige el primer alimento al azar del grupo 2"
         ;(racion (cantidad ?racion))
         ?gi <- (grupo-inicial 2)
         ?ultimos <- (alimentos-usados (grupo2 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         (rcd ?rcd)
         ?d <- (dieta (dia lunes) (kcal 0) (kcal-proteinas ?kcal-proteinas) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5))
         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento) (proteinas ?proteinas) (grupo 2))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) 0) ?rcd))
         ;(test (<= (* ?kcal-alimento 2) ?rcd))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         =>

         (modify ?d (alimentos ?nombre-alimento ?racion) (kcal (/ (* ?kcal-alimento ?racion) 100)) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo2 (+ ?grupo2 1)))
         ;(modify ?a (lunes ?racion))
         (modify ?ultimos (grupo2 $?usados ?nombre-alimento))
         (assert (fase grupo3))
         ;falta añadir alimento a lista de alimentos usados
         (retract ?gi)
         )

(defrule primer-alimento-3 "Elige el primer alimento al azar del grupo 3"
         ;(racion (cantidad ?racion))
         ?gi <- (grupo-inicial 3)
         ?ultimos <- (alimentos-usados (grupo3 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         (rcd ?rcd)
         ?d <- (dieta (dia lunes) (kcal 0) (kcal-proteinas ?kcal-proteinas) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5))
         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento) (proteinas ?proteinas) (grupo 3))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) 0) ?rcd))
         ;(test (<= ?kcal-alimento ?rcd))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         =>

         (modify ?d (alimentos ?nombre-alimento ?racion) (kcal (/ (* ?kcal-alimento ?racion) 100)) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupos36 (+ ?grupos36 1)))
         ;(modify ?a (lunes ?racion))
         (modify ?ultimos (grupo3 $?usados ?nombre-alimento))
         (assert (fase grupo4))
         ;falta añadir alimento a lista de alimentos usados
         (retract ?gi)
         )

(defrule primer-alimento-4 "Elige el primer alimento al azar del grupo 4"
         ;(racion (cantidad ?racion))
         ?gi <- (grupo-inicial 4)
         ?ultimos <- (alimentos-usados (grupo4 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         (rcd ?rcd)
         ?d <- (dieta (dia lunes) (kcal 0) (kcal-proteinas ?kcal-proteinas) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5))
         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento) (proteinas ?proteinas) (grupo 4))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) 0) ?rcd))
         ;(test (<= ?kcal-alimento ?rcd))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         =>

         (modify ?d (alimentos ?nombre-alimento ?racion) (kcal (/ (* ?kcal-alimento ?racion) 100)) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo4 (+ ?grupo4 1)))
         ;(modify ?a (lunes ?racion))
         (modify ?ultimos (grupo4 $?usados ?nombre-alimento))
         (assert (fase grupo5))
         ;falta añadir alimento a lista de alimentos usados
         (retract ?gi)
         )

(defrule primer-alimento-5 "Elige el primer alimento al azar del grupo 5"
         ;(racion (cantidad ?racion))
         ?gi <- (grupo-inicial 5)
         ?ultimos <- (alimentos-usados (grupo5 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         (rcd ?rcd)
         ?d <- (dieta (dia lunes) (kcal 0) (kcal-proteinas ?kcal-proteinas) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5))
         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento) (proteinas ?proteinas) (grupo 5))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) 0) ?rcd))
         ;(test (<= ?kcal-alimento ?rcd))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         =>

         (modify ?d (alimentos ?nombre-alimento ?racion) (kcal (/ (* ?kcal-alimento ?racion) 100)) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo5 (+ ?grupo5 1)))
         ;(modify ?a (lunes ?racion))
         (modify ?ultimos (grupo5 $?usados ?nombre-alimento))
         (assert (fase grupo6))
         ;falta añadir alimento a lista de alimentos usados
         (retract ?gi)
         )

(defrule primer-alimento-6 "Elige el primer alimento al azar del grupo 6"
         ;(racion (cantidad ?racion))
         ?gi <- (grupo-inicial 6)
         ?ultimos <- (alimentos-usados (grupo6 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         (rcd ?rcd)
         ?d <- (dieta (dia lunes) (kcal 0) (kcal-proteinas ?kcal-proteinas) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5))
         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento) (proteinas ?proteinas) (grupo 6))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) 0) ?rcd))
         ;(test (<= ?kcal-alimento ?rcd))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         =>

         (modify ?d (alimentos ?nombre-alimento ?racion) (kcal (/ (* ?kcal-alimento ?racion) 100)) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupos36 (+ ?grupos36 1)))
         ;(modify ?a (lunes ?racion))
         (modify ?ultimos (grupo6 $?usados ?nombre-alimento))
         (assert (fase grupo7))
         ;falta añadir alimento a lista de alimentos usados
         (retract ?gi)
         )
(defrule primer-alimento-7 "Elige el primer alimento al azar del grupo 7"
         ;(racion (cantidad ?racion))
         ?gi <- (grupo-inicial 7)
         ?ultimos <- (alimentos-usados (grupo7 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         (rcd ?rcd)
         ?d <- (dieta (dia lunes) (kcal 0) (kcal-proteinas ?kcal-proteinas) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7) (gramos-grasa ?gramos-grasa))
         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento) (proteinas ?proteinas) (grupo 7))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) 0) ?rcd))
         ;(test (<= ?kcal-alimento ?rcd))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         =>

         (modify ?d (alimentos ?nombre-alimento ?racion) (kcal (/ (* ?kcal-alimento ?racion) 100)) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo7 (+ ?grupo7 1))(gramos-grasa (+ ?gramos-grasa ?racion)))
         ;(modify ?a (lunes ?racion))
         (modify ?ultimos (grupo7 $?usados ?nombre-alimento))
         (assert (fase grupo1))
         ;falta añadir alimento a lista de alimentos usados
         (retract ?gi)
         )

;--------------------------------------------------------------------------

(defrule configurar-dieta-1 "Elige un alimento del grupo 1 al azar"
         ?ultimos <- (alimentos-usados (grupo1 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?fase <- (fase grupo1)
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 1))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))
         (test (or (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                   (and (> (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                        (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.15 ?rcd)))))
         (test (< ?grupo1 3))
         =>

         (modify ?d (alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100))) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo1 (+ ?grupo1 1)))
         (modify ?ultimos (grupo1 $?usados ?nombre-alimento))
         (retract ?fase)
         (assert (fase grupo2))

         )
;---------------------------------------------------------------------------
(defrule configurar-dieta-1-no-mas "No elige mas alimentos del grupo 1"
         ?fase <- (fase grupo1)

         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))

         (test (= ?grupo1 3))
         =>
         (retract ?fase)
         (assert (fase grupo2))
         )
;---------------------------------------------------------------------------
(defrule configurar-dieta-1-no-proteinas "Elige un alimento del grupo 1 al azar y se pasa de proteinas"
         ?ultimos <- (alimentos-usados (grupo1 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?fase <- (fase grupo1)
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 1))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))
         (test (not (or (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                   (and (> (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                        (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.15 ?rcd))))))

         =>
         (retract ?fase)
         (assert (fase grupo2))
         )

;---------------------------------------------------------------------------
(defrule configurar-dieta-1-no "Elige un alimento del grupo 1 al azar y no se cumple requisito calorico"
         ?fase <- (fase grupo1)
         ?ultimos <- (alimentos-usados (grupo1 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 1))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (> (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))

         =>
         (printout t "Termina proceso con grupo 1" crlf)
         (printout t "RCD: " ?rcd crlf)
         (printout t "Dieta: " ?alimentos crlf)
         (printout t "Calorias totales: " ?kcal crlf)
         (printout t "Calorias proteinas: " ?kcal-proteinas crlf)
         (printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
         (printout t "Grupo 1: " ?grupo1 crlf)
         (printout t "Grupo 2: " ?grupo2 crlf)
         (printout t "Grupo 3-6: " ?grupos36 crlf)
         (printout t "Grupo 4: " ?grupo4 crlf)
         (printout t "Grupo 5: " ?grupo5 crlf)
         (printout t "Grupo 7: " ?grupo7 crlf)
         (retract ?fase)
         (assert (dieta (dia lunes)))
         (assert (fase grupo-inicial))
         )

;----------------------------------------------------------------------------

(defrule configurar-dieta-2 "Elige un alimento del grupo 2 al azar"
         ?fase <- (fase grupo2)
         ?ultimos <- (alimentos-usados (grupo2 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 2))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))
         (test (or (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                   (and (> (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                        (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.15 ?rcd)))))
         ;con dos alimentos del grupo 2 satisfacemos la cuota de proteinas
         (test (< ?grupo2 3))
         =>
         ;alimentos del grupo 2, raciones de 200g
         (modify ?d (alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100))) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo2 (+ ?grupo2 1)))
         (modify ?ultimos (grupo2 $?usados ?nombre-alimento))
         (retract ?fase)
         (assert (fase grupo3))

         )
;---------------------------------------------------------------------------
(defrule configurar-dieta-2-no-mas "No elige mas alimentos del grupo 2"
         ?fase <- (fase grupo2)

         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))

         (test (= ?grupo2 3))
         =>
         (retract ?fase)
         (assert (fase grupo3))
         )
;----------------------------------------------------------------------------

(defrule configurar-dieta-2-no "Elige un alimento del grupo 2 al azar y no se cumple requisito calorico"
         ?fase <- (fase grupo2)
         ?ultimos <- (alimentos-usados (grupo2 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 2))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (> (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))

         =>

         (printout t "Termina proceso con grupo 2" crlf)
         (printout t "RCD: " ?rcd crlf)
         (printout t "Dieta: " ?alimentos crlf)
         (printout t "Calorias totales: " ?kcal crlf)
         (printout t "Calorias proteinas: " ?kcal-proteinas crlf)
         (printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
         (printout t "Grupo 1: " ?grupo1 crlf)
         (printout t "Grupo 2: " ?grupo2 crlf)
         (printout t "Grupo 3-6: " ?grupos36 crlf)
         (printout t "Grupo 4: " ?grupo4 crlf)
         (printout t "Grupo 5: " ?grupo5 crlf)
         (printout t "Grupo 7: " ?grupo7 crlf)
         (retract ?fase)
         (assert (dieta (dia lunes)))
         (assert (fase grupo-inicial))
         )

;----------------------------------------------------------------------------

(defrule configurar-dieta-3 "Elige un alimento del grupo 3 al azar"
         ?fase <- (fase grupo3)
         ?ultimos <- (alimentos-usados (grupo3 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 3))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))
         (test (< ?grupos36 6))
         (test (or (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                   (and (> (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                        (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.15 ?rcd)))))


         =>

         (modify ?d (alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100))) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupos36 (+ ?grupos36 1)))
         (modify ?ultimos (grupo3 $?usados ?nombre-alimento))
         (retract ?fase)
         (assert (fase grupo4))
         )

;----------------------------------------------------------------------------
(defrule configurar-dieta-3-no-mas "No elige mas alimentos del grupo 3"
         ?fase <- (fase grupo3)
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))

         (test (= ?grupos36 6))
         =>
         (retract ?fase)
         (assert (fase grupo4))
         )

;----------------------------------------------------------------------------

(defrule configurar-dieta-3-no "Elige un alimento del grupo 3 al azar y no se cumple requisito calorico"
         ?fase <- (fase grupo3)
         ?ultimos <- (alimentos-usados (grupo3 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 3))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (> (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))

         =>
         (retract ?fase)
         (assert (fase grupo3-check))

         )

;----------------------------------------------------------------------------
(defrule configurar-dieta-3-check "Grupo 3, comprobar si se ha acabado correctamente, caso afirmativo"
         ?fase <- (fase grupo3-check)
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (test (>= ?grupo1 2))
         (test (>= ?grupo2 2))
         (test (>= ?grupos36 4))
         (test (>= ?grupo4 2))
         (test (>= ?grupo5 2))
         ;(test (>= ?grupo7 2))
         =>
         (printout t "Termina proceso con grupo 3" crlf)
         (printout t "RCD: " ?rcd crlf)
         (printout t "Dieta: " ?alimentos crlf)
         (printout t "Calorias totales: " ?kcal crlf)
         (printout t "Calorias proteinas: " ?kcal-proteinas crlf)
         (printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
         (printout t "Grupo 1: " ?grupo1 crlf)
         (printout t "Grupo 2: " ?grupo2 crlf)
         (printout t "Grupo 3-6: " ?grupos36 crlf)
         (printout t "Grupo 4: " ?grupo4 crlf)
         (printout t "Grupo 5: " ?grupo5 crlf)
         (printout t "Grupo 7: " ?grupo7 crlf)
         (retract ?fase)
         (assert (dieta (dia lunes)))
         (assert (fase grupo-inicial))
         )

;----------------------------------------------------------------------------
(defrule configurar-dieta-3-check-no "Grupo 3, comprobar si se ha acabado correctamente, caso negativo"
         ?fase <- (fase grupo3-check)
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (test (or(< ?grupo1 2) (< ?grupo2 2) (< ?grupos36 4)(< ?grupo4 2)(< ?grupo5 2)))

         ;alguna de las comprobaciones anteriores falla. Entonces, se ha de seguir con el grupo siguiente.
         =>

         (retract ?fase)
         (assert (fase grupo4))
         )
;----------------------------------------------------------------------------

(defrule configurar-dieta-4 "Elige un alimento del grupo 4 al azar"
         ?fase <- (fase grupo4)
         ?ultimos <- (alimentos-usados (grupo4 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 4))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))
         (test (or (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                   (and (> (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                        (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.15 ?rcd)))))
         (test (< ?grupo4 4))
         =>

         (modify ?d (alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100))) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo4 (+ ?grupo4 1)))
         (modify ?ultimos (grupo4 $?usados ?nombre-alimento))
         (retract ?fase)
         (assert (fase grupo5))
         )

;---------------------------------------------------------------------------
(defrule configurar-dieta-4-no-mas "No elige mas alimentos del grupo 4"
         ?fase <- (fase grupo4)

         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))

         (test (= ?grupo4 4))
         =>
         (retract ?fase)
         (assert (fase grupo5))
         )
;----------------------------------------------------------------------------


(defrule configurar-dieta-4-no "Elige un alimento del grupo 4 al azar y no se cumple el requisito calorico"
         ?fase <- (fase grupo4)
         ?ultimos <- (alimentos-usados (grupo4 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 4))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (> (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))

         =>

         (printout t "Termina proceso con grupo 4" crlf)
         (printout t "RCD: " ?rcd crlf)
         (printout t "Dieta: " ?alimentos crlf)
         (printout t "Calorias totales: " ?kcal crlf)
         (printout t "Calorias proteinas: " ?kcal-proteinas crlf)
         (printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
         (printout t "Grupo 1: " ?grupo1 crlf)
         (printout t "Grupo 2: " ?grupo2 crlf)
         (printout t "Grupo 3-6: " ?grupos36 crlf)
         (printout t "Grupo 4: " ?grupo4 crlf)
         (printout t "Grupo 5: " ?grupo5 crlf)
         (printout t "Grupo 7: " ?grupo7 crlf)
         (retract ?fase)
         (assert (dieta (dia lunes)))
         (assert (fase grupo-inicial))
         )

;----------------------------------------------------------------------------

(defrule configurar-dieta-5 "Elige un alimento del grupo 5 al azar"
         ?fase <- (fase grupo5)
         ?ultimos <- (alimentos-usados (grupo5 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 5))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))
         (test (or (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                   (and (> (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                        (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.15 ?rcd)))))
         (test (< ?grupo5 3))
         =>

         (modify ?d (alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100))) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo5 (+ ?grupo5 1)))
         (modify ?ultimos (grupo5 $?usados ?nombre-alimento))
         (retract ?fase)
         (assert (fase grupo6))
         )
;---------------------------------------------------------------------------
(defrule configurar-dieta-5-no-mas "No elige mas alimentos del grupo 5"
         ?fase <- (fase grupo5)

         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))

         (test (= ?grupo5 3))
         =>
         (retract ?fase)
         (assert (fase grupo6))
         )

;----------------------------------------------------------------------------

(defrule configurar-dieta-5-no "Elige un alimento del grupo 5 al azar y no se cumple el requisito calorico"
         ?fase <- (fase grupo5)
         ?ultimos <- (alimentos-usados (grupo5 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 5))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (> (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))

         =>

         (printout t "Termina proceso con grupo 5" crlf)
         (printout t "RCD: " ?rcd crlf)
         (printout t "Dieta: " ?alimentos crlf)
         (printout t "Calorias totales: " ?kcal crlf)
         (printout t "Calorias proteinas: " ?kcal-proteinas crlf)
         (printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
         (printout t "Grupo 1: " ?grupo1 crlf)
         (printout t "Grupo 2: " ?grupo2 crlf)
         (printout t "Grupo 3-6: " ?grupos36 crlf)
         (printout t "Grupo 4: " ?grupo4 crlf)
         (printout t "Grupo 5: " ?grupo5 crlf)
         (printout t "Grupo 7: " ?grupo7 crlf)
         (retract ?fase)
         (assert (dieta (dia lunes)))
         (assert (fase grupo-inicial))
         )

;----------------------------------------------------------------------------

(defrule configurar-dieta-6 "Elige un alimento del grupo 6 al azar"
         (declare (salience 3))
         ?fase <- (fase grupo6)
         ?ultimos <- (alimentos-usados (grupo6 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 6))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))
         (test (< ?grupos36 6))
         (test (or (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                   (and (> (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                        (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.15 ?rcd)))))
         =>

         (modify ?d (alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100))) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupos36 (+ ?grupos36 1)))
         (modify ?ultimos (grupo6 $?usados ?nombre-alimento))
         (retract ?fase)
         (assert (fase grupo7))
         )

;----------------------------------------------------------------------------
(defrule configurar-dieta-6-no-mas "No elige mas alimentos del grupo 6"
         (declare (salience 2))
         ?fase <- (fase grupo6)

         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (test (= ?grupos36 6))
         =>
         (retract ?fase)
         (assert (fase grupo7))
         )
;----------------------------------------------------------------------------

(defrule configurar-dieta-6-no "Elige un alimento del grupo 6 al azar y no se cumple el requisito calorico"
         ?fase <- (fase grupo6)
         ?ultimos <- (alimentos-usados (grupo6 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 6))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (> (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))

         =>

         (printout t "Termina proceso con grupo 6" crlf)
         (printout t "RCD: " ?rcd crlf)
         (printout t "Dieta: " ?alimentos crlf)
         (printout t "Calorias totales: " ?kcal crlf)
         (printout t "Calorias proteinas: " ?kcal-proteinas crlf)
         (printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
         (printout t "Grupo 1: " ?grupo1 crlf)
         (printout t "Grupo 2: " ?grupo2 crlf)
         (printout t "Grupo 3-6: " ?grupos36 crlf)
         (printout t "Grupo 4: " ?grupo4 crlf)
         (printout t "Grupo 5: " ?grupo5 crlf)
         (printout t "Grupo 7: " ?grupo7 crlf)
         (retract ?fase)
         (assert (dieta (dia lunes)))
         (assert (fase grupo-inicial))
         )


;----------------------------------------------------------------------------


(defrule configurar-dieta-7 "Elige un alimento del grupo 7 al azar"
         ?fase <- (fase grupo7)
         ?ultimos <- (alimentos-usados (grupo7 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos)(grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7)(gramos-grasa ?gramos-grasa))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 7))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))
        ; (test (< ?grupos36 6))
         (test (< (+ ?gramos-grasa ?racion) 60))
         (test (or (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                   (and (> (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.1 ?rcd))
                        (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.15 ?rcd)))))
         =>

         (modify ?d (alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100))) (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100))) (grupo7 (+ ?grupo7 1))(gramos-grasa (+ ?gramos-grasa ?racion)))
         (modify ?ultimos (grupo7 $?usados ?nombre-alimento))
         (retract ?fase)
         (assert (fase grupo1))
         )

;----------------------------------------------------------------------------
(defrule configurar-dieta-7-no-mas "No elige mas alimentos del grupo 7"
         ?fase <- (fase grupo7)

         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos)(grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7)(gramos-grasa ?gramos-grasa))
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 7))
         (test (> (+ ?gramos-grasa ?racion) 60))
         =>
         (retract ?fase)
         (assert (fase grupo1))
         )
;----------------------------------------------------------------------------

(defrule configurar-dieta-7-no "Elige un alimento del grupo 7 al azar y no se cumple el requisito calorico"
         ?fase <- (fase grupo7)
         ?ultimos <- (alimentos-usados (grupo7 $?usados))
         (repetibles (alimentos $?alimentos-repetibles))
         ?d <- (dieta (dia lunes) (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))
         (rcd ?rcd)
         (alimento (id ?id-alimento) (nombre ?nombre-alimento) (racion ?racion) (kcal ?kcal-alimento)
                   (proteinas ?proteinas) (grupo 7))
         (test (not (member$ ?nombre-alimento $?alimentos)))
         (test (or (not (member$ ?nombre-alimento $?usados)) (member$ ?nombre-alimento $?alimentos-repetibles)))
         (test (> (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) ?rcd))

         =>

         (printout t "Termina proceso con grupo 7" crlf)
         (printout t "RCD: " ?rcd crlf)
         (printout t "Dieta: " ?alimentos crlf)
         (printout t "Calorias totales: " ?kcal crlf)
         (printout t "Calorias proteinas: " ?kcal-proteinas crlf)
         (printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
         (printout t "Calorias hidratos: " ?kcal-hidratos crlf)
         (printout t "% Calorias hidratos: " (/ (* ?kcal-hidratos 100) ?kcal) crlf)
         (printout t "Grupo 1: " ?grupo1 crlf)
         (printout t "Grupo 2: " ?grupo2 crlf)
         (printout t "Grupo 3-6: " ?grupos36 crlf)
         (printout t "Grupo 4: " ?grupo4 crlf)
         (printout t "Grupo 5: " ?grupo5 crlf)
         (printout t "Grupo 7: " ?grupo7 crlf)
         (retract ?fase)
         (assert (dieta (dia lunes)))
         (assert (fase grupo-inicial))
         )


;----------------------------------------------------------------------------


;(defrule print-results "Muestra resultados por pantalla"
;(rcd ?rcd)
;(dieta (kcal ?kcal)(kcal-proteinas ?kcal-proteinas)  (alimentos $?alimentos)(grupo1 ?grupo1)
;      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5))

;=>
;(printout t "RCD: " ?rcd  crlf)
;(printout t "Dieta: " ?alimentos crlf)
;(printout t "Calorias totales: " ?kcal crlf)
;(printout t "Calorias proteinas: " ?kcal-proteinas crlf)
;(printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
;(printout t "Grupo 1: " ?grupo1 crlf)
;(printout t "Grupo 2: " ?grupo2 crlf)
;(printout t "Grupo 3-6: " ?grupos36 crlf)
;(printout t "Grupo 4: " ?grupo4 crlf)
;(printout t "Grupo 5: " ?grupo5 crlf)
;)
