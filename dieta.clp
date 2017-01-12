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



;--------------------------------------------------------------------------

(defrule operador-grupo-1 "Elige un alimento del grupo 1"
         (rcd ?rcd)
         (usados (alimentos $?alimentos-usados))
         (dia (nombre ?dia-turno))

         ?d <- (dieta (dia ?dia) (estado cerrado) (kcal ?kcal) (total-alimentos ?total-alimentos)(ids $?idents)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)(kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos)
                      (grupo1 ?grupo1&:(< ?grupo1 3)) (grupo2 ?grupo2) (grupo3 ?grupo3)(grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)
                      (grupo6 ?grupo6)(grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento&: (not (member$ ?nombre-alimento $?alimentos)))
                         (veces ?veces&:(or (= ?veces 5)
                                            (and (= ?veces 2) (or (eq ?dia martes) (eq ?dia jueves)))
                                            (and (= ?veces 3) (or (eq ?dia lunes) (eq ?dia miercoles) (eq ?dia viernes)))
                                            (and (= ?veces 1) (not (member$ ?nombre-alimento $?alimentos-usados)))))

                         (racion ?racion) (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) (* ?rcd 1.05)))
                         (proteinas ?proteinas&: (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.16 ?rcd)))
                         (grasas ?grasas&:  (<= (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)) (* 0.36 ?rcd)))
                         (hidratos ?hidratos&: (<= (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)) (* 0.56 ?rcd))) (grupo 1))



         =>

         (assert (dieta (dia ?dia-turno)(alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100)))
                        (ids $?idents ?id-alimento)
                        (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)))
                        (kcal-hidratos (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)))
                        (kcal-grasas (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)))
                        (kcal-grasas-mono ?kcal-grasas-mono)
                        (gramos-grasa ?gramos-grasa)
                        (grupo1 (+ ?grupo1 1))
                        (grupo2 ?grupo2) (grupo3 ?grupo3)(grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7)
                        (total-alimentos (+ ?total-alimentos 1))))

         )
;---------------------------------------------------------------------------
(defrule operador-grupo-2 "Elige un alimento del grupo 2"
         (rcd ?rcd)
         (usados (alimentos $?alimentos-usados))
         (dia (nombre ?dia-turno))
         ?d <- (dieta (dia ?dia) (estado cerrado) (kcal ?kcal) (total-alimentos ?total-alimentos)(ids $?idents)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)(kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2&:(< ?grupo2 3))(grupo3 ?grupo3) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento)  (nombre ?nombre-alimento&: (not (member$ ?nombre-alimento $?alimentos)))
                         (veces ?veces&:(or (= ?veces 5)
                                            (and (= ?veces 2) (or (eq ?dia martes) (eq ?dia jueves)))
                                            (and (= ?veces 3) (or (eq ?dia lunes) (eq ?dia miercoles) (eq ?dia viernes)))
                                            (and (= ?veces 1) (not (member$ ?nombre-alimento $?alimentos-usados)))))
                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) (* ?rcd 1.05)))
                         (proteinas ?proteinas&: (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.16 ?rcd)))
                         (grasas ?grasas&:  (<= (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)) (* 0.36 ?rcd)))
                         (hidratos ?hidratos&: (<= (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)) (* 0.56 ?rcd))) (grupo 2))



         =>

         (assert (dieta (dia ?dia-turno)(alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100)))
                        (ids $?idents ?id-alimento)
                        (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)))
                        (kcal-hidratos (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)))
                        (kcal-grasas (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)))
                        (kcal-grasas-mono ?kcal-grasas-mono)
                        (gramos-grasa ?gramos-grasa)
                        (grupo1 ?grupo1) (grupo2 (+ ?grupo2 1))(grupo3 ?grupo3)
                        (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7)
                        (total-alimentos (+ ?total-alimentos 1))))

         )
;---------------------------------------------------------------------------
(defrule operador-grupo-3 "Elige un alimento del grupo 3"
         (rcd ?rcd)
         (usados (alimentos $?alimentos-usados))
         (dia (nombre ?dia-turno))
         ?d <- (dieta (dia ?dia) (estado cerrado) (kcal ?kcal) (total-alimentos ?total-alimentos)(ids $?idents)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)(kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupo3 ?grupo3)(grupos36 ?grupos36&:(< ?grupos36 6)) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento&: (not (member$ ?nombre-alimento $?alimentos)))
                         (veces ?veces&:(or (= ?veces 5)
                                            (and (= ?veces 2) (or (eq ?dia martes) (eq ?dia jueves)))
                                            (and (= ?veces 3) (or (eq ?dia lunes) (eq ?dia miercoles) (eq ?dia viernes)))
                                            (and (= ?veces 1) (not (member$ ?nombre-alimento $?alimentos-usados)))))
                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) (* ?rcd 1.05)))
                         (proteinas ?proteinas&: (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.16 ?rcd)))
                         (grasas ?grasas&:  (<= (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)) (* 0.36 ?rcd)))
                         (grasas-mono ?grasas-mono&: (<= (+ ?kcal-grasas-mono (/ (* ?grasas-mono 9 ?racion) 100)) (* 0.21 ?rcd)))
                         (hidratos ?hidratos&: (<= (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)) (* 0.56 ?rcd))) (grupo 3))



         =>


         (assert (dieta (dia ?dia-turno)(alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100)))
                        (ids $?idents ?id-alimento)
                        (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)))
                        (kcal-hidratos (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)))
                        (kcal-grasas (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)))
                        (kcal-grasas-mono (+ ?kcal-grasas-mono (/ (* ?grasas-mono 9 ?racion) 100)))
                        (gramos-grasa ?gramos-grasa)
                        (grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 (+ ?grupo3 1)) (grupos36 (+ ?grupos36 1))
                        (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo6 ?grupo6) (grupo7 ?grupo7)
                        (total-alimentos (+ ?total-alimentos 1))))

         )
;---------------------------------------------------------------------------
(defrule operador-grupo-4 "Elige un alimento del grupo 4"
         (rcd ?rcd)
         (usados (alimentos $?alimentos-usados))
         (dia (nombre ?dia-turno))
         ?d <- (dieta (dia ?dia) (estado cerrado) (kcal ?kcal) (total-alimentos ?total-alimentos)(ids $?idents)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)(kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupo3 ?grupo3) (grupos36 ?grupos36) (grupo4 ?grupo4&:(< ?grupo4 4)) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento)  (nombre ?nombre-alimento&: (not (member$ ?nombre-alimento $?alimentos)))
                         (veces ?veces&:(or (= ?veces 5)
                                            (and (= ?veces 2) (or (eq ?dia martes) (eq ?dia jueves)))
                                            (and (= ?veces 3) (or (eq ?dia lunes) (eq ?dia miercoles) (eq ?dia viernes)))
                                            (and (= ?veces 1) (not (member$ ?nombre-alimento $?alimentos-usados)))))
                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) (* ?rcd 1.05)))
                         (proteinas ?proteinas&: (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.16 ?rcd)))
                         (grasas ?grasas&:  (<= (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)) (* 0.36 ?rcd)))
                         (hidratos ?hidratos&: (<= (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)) (* 0.56 ?rcd))) (grupo 4))


         =>

         (assert (dieta (dia ?dia-turno)(alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100)))
                        (ids $?idents ?id-alimento)
                        (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)))
                        (kcal-hidratos (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)))
                        (kcal-grasas (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)))
                        (kcal-grasas-mono ?kcal-grasas-mono)
                        (gramos-grasa ?gramos-grasa)
                        (grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)(grupos36 ?grupos36)
                        (grupo4 (+ ?grupo4 1)) (grupo5 ?grupo5) (grupo6 ?grupo6) (grupo7 ?grupo7)
                        (total-alimentos (+ ?total-alimentos 1))))

         )
;---------------------------------------------------------------------------
(defrule operador-grupo-5 "Elige un alimento del grupo 5"
         (rcd ?rcd)
         (usados (alimentos $?alimentos-usados))
         (dia (nombre ?dia-turno))
         ?d <- (dieta (dia ?dia) (estado cerrado) (kcal ?kcal) (total-alimentos ?total-alimentos)(ids $?idents)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)(kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2)(grupo3 ?grupo3) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5&:(< ?grupo5 3))(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento) (nombre ?nombre-alimento&: (not (member$ ?nombre-alimento $?alimentos)))
                         (veces ?veces&:(or (= ?veces 5)
                                            (and (= ?veces 2) (or (eq ?dia martes) (eq ?dia jueves)))
                                            (and (= ?veces 3) (or (eq ?dia lunes) (eq ?dia miercoles) (eq ?dia viernes)))
                                            (and (= ?veces 1) (not (member$ ?nombre-alimento $?alimentos-usados)))))
                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) (* ?rcd 1.05)))
                         (proteinas ?proteinas&: (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.16 ?rcd)))
                         (grasas ?grasas&:  (<= (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)) (* 0.36 ?rcd)))
                         (grasas-mono ?grasas-mono&:  (<= (+ ?kcal-grasas-mono (/ (* ?grasas-mono 9 ?racion) 100)) (* 0.21 ?rcd)))
                         (hidratos ?hidratos&: (<= (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)) (* 0.56 ?rcd))) (grupo 5))


         =>

         (assert (dieta (dia ?dia-turno)(alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100)))
                        (ids $?idents ?id-alimento)
                        (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)))
                        (kcal-hidratos (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)))
                        (kcal-grasas (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)))
                        (kcal-grasas-mono (+ ?kcal-grasas-mono (/ (* ?grasas-mono 9 ?racion) 100)))
                        (gramos-grasa ?gramos-grasa)
                        (grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)(grupos36 ?grupos36)
                        (grupo4 ?grupo4) (grupo5 (+ ?grupo5 1)) (grupo6 ?grupo6)(grupo7 ?grupo7)
                        (total-alimentos (+ ?total-alimentos 1))))

         )
;---------------------------------------------------------------------------
(defrule operador-grupo-6 "Elige un alimento del grupo 6"
         (rcd ?rcd)
         (usados (alimentos $?alimentos-usados))
         (dia (nombre ?dia-turno))
         ?d <- (dieta (dia ?dia) (estado cerrado) (kcal ?kcal) (total-alimentos ?total-alimentos)(ids $?idents)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)(kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupo3 ?grupo3) (grupos36 ?grupos36&:(< ?grupos36 6)) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento)  (nombre ?nombre-alimento&: (not (member$ ?nombre-alimento $?alimentos)))
                         (veces ?veces&:(or (= ?veces 5)
                                            (and (= ?veces 2) (or (eq ?dia martes) (eq ?dia jueves)))
                                            (and (= ?veces 3) (or (eq ?dia lunes) (eq ?dia miercoles) (eq ?dia viernes)))
                                            (and (= ?veces 1) (not (member$ ?nombre-alimento $?alimentos-usados)))))
                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) (* ?rcd 1.05)))
                         (proteinas ?proteinas&: (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.16 ?rcd)))
                         (grasas ?grasas&:  (<= (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)) (* 0.36 ?rcd)))
                         (hidratos ?hidratos&: (<= (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)) (* 0.56 ?rcd))) (grupo 6))


         =>

         (assert (dieta (dia ?dia-turno)(alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100)))
                        (ids $?idents ?id-alimento)
                        (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)))
                        (kcal-hidratos (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)))
                        (kcal-grasas (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)))
                        (kcal-grasas-mono ?kcal-grasas-mono)
                        (gramos-grasa ?gramos-grasa)
                        (grupo1 ?grupo1) (grupo3 ?grupo3) (grupo2 ?grupo2) (grupos36 (+ ?grupos36 1))
                        (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo6 (+ ?grupo6 1))(grupo7 ?grupo7)
                        (total-alimentos (+ ?total-alimentos 1))))

         )

;---------------------------------------------------------------------------
(defrule operador-grupo-7 "Elige un alimento del grupo 7"
         (rcd ?rcd)
         (usados (alimentos $?alimentos-usados))
         (dia (nombre ?dia-turno))
         ?d <- (dieta (dia ?dia) (estado cerrado) (total-alimentos ?total-alimentos)(ids $?idents)
                      (kcal ?kcal) (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)(kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2)(grupo3 ?grupo3) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento)  (nombre ?nombre-alimento&: (not (member$ ?nombre-alimento $?alimentos)))
                         (veces ?veces&:(or (= ?veces 5)
                                            (and (= ?veces 2) (or (eq ?dia martes) (eq ?dia jueves)))
                                            (and (= ?veces 3) (or (eq ?dia lunes) (eq ?dia miercoles) (eq ?dia viernes)))
                                            (and (= ?veces 1) (not (member$ ?nombre-alimento $?alimentos-usados)))))
                         (racion ?racion&:(< (+ ?gramos-grasa ?racion) 60))
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal) (* ?rcd 1.05)))
                         (proteinas ?proteinas&: (<= (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)) (* 0.16 ?rcd)))
                         (grasas ?grasas&:  (<= (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)) (* 0.36 ?rcd)))
                         (grasas-mono ?grasas-mono&:  (<= (+ ?kcal-grasas-mono (/ (* ?grasas-mono 9 ?racion) 100)) (* 0.21 ?rcd)))
                         (hidratos ?hidratos&: (<= (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)) (* 0.56 ?rcd))) (grupo 7))


         =>


         (assert (dieta(dia ?dia-turno) (alimentos $?alimentos ?nombre-alimento ?racion) (kcal (+ ?kcal (/ (* ?kcal-alimento ?racion) 100)))
                       (ids $?idents ?id-alimento)
                       (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas 4 ?racion) 100)))
                        (kcal-hidratos (+ ?kcal-hidratos (/ (* ?hidratos 4 ?racion) 100)))
                        (kcal-grasas (+ ?kcal-grasas (/ (* ?grasas 9 ?racion) 100)))
                       (kcal-grasas-mono (+ ?kcal-grasas-mono (/ (* ?grasas-mono 9 ?racion) 100)))
                        (gramos-grasa (+ ?gramos-grasa ?racion))
                        (grupo1 ?grupo1) (grupo2 ?grupo2)(grupo3 ?grupo3) (grupos36 ?grupos36)
                        (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo6 ?grupo6) (grupo7 (+ ?grupo7 1))
                        (total-alimentos (+ ?total-alimentos 1))))

         )
;---------------------------------------------------------------------------
;;; Regla de selección de la dieta de mayor aporte calórico.


;(defrule cierra-dieta-menor-costo-inicial
;         (declare (salience -7))
;         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
;                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
;                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
;                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
;         (test (= ?total-alimentos 1))
; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
; (not (exists (dieta (kcal ?kcal2&: (> ?kcal2 ?kcal)) (total-alimentos ?total-alimentos))))
;         =>
;         (modify ?d (estado cerrado))
;         )

(defrule cierra-dieta-menor-costo-hidratos-1
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 1)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono&:(and (>= ?kcal-grasas-mono (* ?rcd 0.02)) (<= ?kcal-grasas-mono (* ?rcd 0.05)))) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupo3 1) (grupos36 1) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.5)))
         ;(test (>= ?kcal-hidratos (/ (* ?rcd 0.45) 6)))
         (test (<= ?kcal-proteinas (* ?rcd 0.05)))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-2
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 2)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)(kcal-grasas-mono ?kcal-grasas-mono&:(<= ?kcal-grasas-mono (* ?rcd 0.12))) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupo3 2)(grupos36 2) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.45)))
         (test (<= ?kcal-proteinas (* ?rcd 0.06)))


         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-3
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 3)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 3) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.45)))
         (test (>= ?kcal-hidratos (/ (* ?rcd 0.45) 2)))
         (test (<= ?kcal-proteinas (* ?rcd 0.07)))
         (test (<= ?kcal-grasas (* ?rcd 0.35 0.2)))
         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-4
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 4)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 4) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.45)))
         (test (<= ?kcal-proteinas (* ?rcd 0.075)))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-5
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 5)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 5) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.45)))
         (test (<= ?kcal-proteinas (* ?rcd 0.08)))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-6
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 6)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 6) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.45)))
         (test (>= ?kcal-hidratos (* ?rcd 0.40)))
         (test (<= ?kcal-proteinas (* ?rcd 0.08)))
         (test (<= ?kcal-grasas (* ?rcd 0.35 0.3)))
         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-grupo4-1
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 7)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 6) (grupo4 1) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.48)))
         (test (<= ?kcal-proteinas (* ?rcd 0.09)))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-grupo4-2
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 8)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 6) (grupo4 2) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.49)))
         (test (<= ?kcal-proteinas (* ?rcd 0.1)))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-grupo4-3
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 9)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 6) (grupo4 3) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.5)))
         (test (<= ?kcal-proteinas (* ?rcd 0.11)))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-grupo5-1
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 10)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 6) (grupo4 3) (grupo5 1) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.52)))
         (test (<= ?kcal-proteinas (* ?rcd 0.12)))
         (test (<= ?kcal-grasas-mono (* ?rcd 0.13)))
         (test (<= ?kcal-grasas (* ?rcd 0.35 0.55)))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-grupo5-2
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 11)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)  (kcal-grasas-mono ?kcal-grasas-mono)(gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.54)))
         (test (<= ?kcal-proteinas (* ?rcd 0.13)))
         (test (<= ?kcal-grasas-mono (* ?rcd 0.12)))
         (test (<= ?kcal-grasas (* ?rcd 0.35 0.55)))
         =>
         (modify ?d (estado cerrado))
         )

(defrule cierra-dieta-menor-costo-lacteos-1
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 12)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 1)
                      (grupo2 ?grupo2) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.56)))
         (test (<= ?kcal-proteinas (* ?rcd 0.14)))
         (test (<= ?kcal-grasas (* ?rcd 0.35 0.6)))
         =>
         (modify ?d (estado cerrado))
         )

(defrule cierra-dieta-menor-costo-lacteos-2
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 13)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 2)
                      (grupo2 ?grupo2) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         ;(test (<= ?kcal-hidratos (* ?rcd 0.55)))
         (test (<= ?kcal-proteinas (* ?rcd 0.14)))
         (test (<= ?kcal-grasas (* ?rcd 0.35 0.6)))
         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-proteinas-1
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 14)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 2)
                      (grupo2 1) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
        ;(test (<= ?kcal-hidratos (* ?rcd 0.55)))
         (test (<= ?kcal-proteinas (* ?rcd 0.15)))
         (test (<= ?kcal-grasas (* ?rcd 0.35 0.63)))
         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-proteinas-2
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 15)
                      (kcal-proteinas ?kcal-proteinas&:(<= ?kcal-proteinas (* ?rcd 0.16))) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas&: (<= ?kcal-grasas (* ?rcd 0.35 0.8))) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 2)
                      (grupo2 2) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 ?grupo7))


         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         ;(test (<= ?kcal-hidratos (* ?rcd 0.55)))



         =>
         (modify ?d (estado cerrado))
         )

(defrule cierra-dieta-menor-costo-grasas-1
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 16 )
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)
                      (kcal-grasas-mono ?kcal-grasas-mono&:(and (<= ?kcal-grasas-mono (* ?rcd 0.21)) (>= ?kcal-grasas-mono (* ?rcd 0.14)) ))
                      (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 2)
                      (grupo2 2) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 1))

         (not (exists (dieta (estado abierto) (kcal ?kcal2) (total-alimentos 16)
                                   (kcal-proteinas ?kcal-proteinas2) (kcal-hidratos ?kcal-hidratos2)
                                   (kcal-grasas ?kcal-grasas2)
                                   (kcal-grasas-mono ?kcal-grasas-mono2&:(and (<= ?kcal-grasas-mono2 (* ?rcd 0.21)) (>= ?kcal-grasas-mono2 (* ?rcd 0.14)) ))
                                   (gramos-grasa ?gramos-grasa2&: (> ?gramos-grasa2 ?gramos-grasa)) (alimentos $?alimentos2) (grupo1 2)
                                   (grupo2 2) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 1))))

         =>
         (modify ?d (estado cerrado))
         )

(defrule cierra-dieta-menor-costo-grasas-2
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 17 )
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)
                      (kcal-grasas-mono ?kcal-grasas-mono&:(and (<= ?kcal-grasas-mono (* ?rcd 0.21)) (>= ?kcal-grasas-mono (* ?rcd 0.14)) ))
                      (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 2)
                      (grupo2 2) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 1))

         (not (exists (dieta (estado abierto) (kcal ?kcal2) (total-alimentos  17 )
                             (kcal-proteinas ?kcal-proteinas2) (kcal-hidratos ?kcal-hidratos2)
                             (kcal-grasas ?kcal-grasas2)
                             (kcal-grasas-mono ?kcal-grasas-mono2&:(and (<= ?kcal-grasas-mono2 (* ?rcd 0.21)) (>= ?kcal-grasas-mono2 (* ?rcd 0.14)) ))
                             (gramos-grasa ?gramos-grasa2&: (> ?gramos-grasa2 ?gramos-grasa)) (alimentos $?alimentos2) (grupo1 2)
                             (grupo2 2) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 2))))

         =>
         (modify ?d (estado cerrado))
         )





(defrule cierra-dieta-menor-costo
         (declare (salience -10))
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (test (!= ?total-alimentos 1))
         (test (!= ?total-alimentos 2))
         (test (!= ?total-alimentos 3))
         (test (!= ?total-alimentos 4))
         (test (!= ?total-alimentos 5))
         (test (!= ?total-alimentos 6))
         (test (!= ?total-alimentos 7))
         (test (!= ?total-alimentos 8))
         (test (!= ?total-alimentos 9))
         (test (!= ?total-alimentos 10))
         (test (!= ?total-alimentos 11))
         (test (!= ?total-alimentos 12))
         (test (!= ?total-alimentos 13))
        (test (!= ?total-alimentos 14))
         (test (!= ?total-alimentos 15))
         (test (!= ?total-alimentos 16))
         (test (!= ?total-alimentos 17))
         (not (exists (dieta (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos)) (estado abierto))))
         ;(not (exists (dieta (kcal ?kcal2&: (> ?kcal2 ?kcal)) (total-alimentos ?total-alimentos))))
         =>
         (modify ?d (estado cerrado))
         )

;----------------------------------------------------------------------------
;;; Regla que se dispara solamente si ya no es posible encontrar la solución


;;; Regla que identifica un nodo solución
(defrule identifica-solucion

         (declare (salience 99))
         (rcd ?rcd)
         ?a <- (usados (alimentos $?alimentos-usados))

         ?d <- (dieta (dia ?dia-dieta) (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas)(kcal-grasas-mono ?kcal-grasas-mono&: (>= ?kcal-grasas-mono (* ?rcd 0.14)))
                      (alimentos $?alimentos) (ids $?idents)
                      (grupo1 ?grupo1&:(>= ?grupo1 2))
                      (grupo2 ?grupo2 &:(>= ?grupo2 2)) (grupos36 ?grupos36&:(>= ?grupos36 4)) (grupo4 ?grupo4&:(>= ?grupo4 2))
                      (grupo5 ?grupo5&:(>= ?grupo5 2)) (grupo7 ?grupo7&:(>= ?grupo7 1))(gramos-grasa ?gramos-grasa&: (>= ?gramos-grasa 40))
                      (estado ?estado&: (not (eq ?estado solucion))))
         =>
        ; (printout t "RCD: " ?rcd crlf)
        ; (printout t "Dieta: " ?alimentos crlf)
        ; (printout t "Dieta: " ?idents crlf)
        ; (printout t "Calorias totales: " ?kcal crlf)
        ; (printout t "Calorias proteinas: " ?kcal-proteinas crlf)
        ; (printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
        ; (printout t "Calorias hidratos: " ?kcal-hidratos crlf)
        ; (printout t "% Calorias hidratos: " (/ (* ?kcal-hidratos 100) ?kcal) crlf)
        ; (printout t "Calorias grasas: " ?kcal-grasas crlf)
        ; (printout t "% Calorias grasas: " (/ (* ?kcal-grasas 100) ?kcal) crlf)
        ; (printout t "Calorias grasas monoinsaturadas: " ?kcal-grasas-mono crlf)
        ; (printout t "% Calorias grasas monoinsaturadas: " (/ (* ?kcal-grasas-mono 100) ?kcal) crlf)
        ; (printout t "Grupo 1: " ?grupo1 crlf)
        ; (printout t "Grupo 2: " ?grupo2 crlf)
        ; (printout t "Grupo 3-6: " ?grupos36 crlf)
        ; (printout t "Grupo 4: " ?grupo4 crlf)
        ; (printout t "Grupo 5: " ?grupo5 crlf)
        ; (printout t "Grupo 7: " ?grupo7 crlf)
         (modify ?d (estado solucion))
         (modify ?a (alimentos $?alimentos-usados $?alimentos))
         ;borrar todas las dietas generadas
         ;conseguir que las siguientes dietas no repitan estos alimentos
         ;añadir lógica de alimentos repetibles
         (assert (solucion-encontrada))
         )
(defrule limpieza
         (declare (salience 100))
         (solucion-encontrada)
         ?d <- (dieta (estado ?estado&: (not (eq ?estado solucion))))
         =>
         (retract ?d)

         )
(defrule reinicio
         (declare (salience 99))
         ?d <- (dia (nombre ?dia))
         ?s <- (solucion-encontrada)
         =>
         (retract ?s)
         (switch ?dia
                 (case lunes then (and(assert (dieta (dia martes))) (modify ?d (nombre martes))))
                 (case martes then (and(assert (dieta (dia miercoles)))(modify ?d (nombre miercoles))))
                 (case miercoles then (and(assert (dieta (dia jueves))) (modify ?d (nombre jueves))))
                 (case jueves then (and(assert (dieta (dia viernes))) (modify ?d (nombre viernes))))
                 (case viernes then (halt))
                 )

         )
;;; Regla que se dispara solamente si ya no es posible encontrar la solución
(defrule sin-solucion
         (declare (salience -100))
         (not (solucion-encontrada))
         =>
         (printout t crlf "Actualmente no hay alimentos que cumplan la dieta " crlf)
         )


;--------------------------------------------------------------------------------------------------------------------------------------------------------

(defrule dieta-desayuno-lacteos "Recupera lacteos para desayuno"
         (declare (salience 102))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (desayuno-dieta (dia-desayuno ?dia&:(eq ?dia ?dia-dieta)) (kcal-desayuno ?kcal-desayuno) (alimentos-desayuno $?alimentos-desayuno)
                               (ids-desayuno $?ids-desayuno)(grupo1 ?grupo1&: (< ?grupo1 1)) (grupo2 ?grupo2)
                               (grupo3 ?grupo3) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-desayuno) (* ?kcal 0.5)))
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (almuerzo ?almuerzo)
                         (comida ?comida)
                         (merienda ?merienda)
                         (cena ?cena)
                         (desayuno si)
                         (grupo 1))


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-desayuno $?alimentos-desayuno ?nombre-alimento) (ids-desayuno $?ids-desayuno ?id-alimento)
                 (kcal-desayuno (+ ?kcal-desayuno ?kcal-alimento)) (grupo1 (+ ?grupo1 1) ) )


         )

(defrule dieta-desayuno-cereales "Recupera cereales para el desayuno"
         (declare (salience 101))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (desayuno-dieta (dia-desayuno ?dia&:(eq ?dia ?dia-dieta)) (kcal-desayuno ?kcal-desayuno) (alimentos-desayuno $?alimentos-desayuno)
                               (ids-desayuno $?ids-desayuno)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                               (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6&: (< ?grupo6 2)) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-desayuno) (* ?kcal 0.5)))
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (almuerzo ?almuerzo)
                         (comida ?comida)
                         (merienda ?merienda)
                         (cena ?cena)
                         (desayuno si)
                         (grupo 6))


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-desayuno $?alimentos-desayuno ?nombre-alimento) (ids-desayuno $?ids-desayuno ?id-alimento)
                 (kcal-desayuno (+ ?kcal-desayuno ?kcal-alimento)) (grupo6 (+ ?grupo6 1) ))

         )
(defrule dieta-desayuno "Recupera alimentos para el desayuno"
         (declare (salience 100))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (desayuno-dieta (dia-desayuno ?dia&:(eq ?dia ?dia-dieta)) (kcal-desayuno ?kcal-desayuno) (alimentos-desayuno $?alimentos-desayuno)
                               (ids-desayuno $?ids-desayuno)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                               (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-desayuno) (* ?kcal 0.5)))
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (almuerzo ?almuerzo)
                         (comida ?comida)
                         (merienda ?merienda)
                         (cena ?cena)
                         (desayuno si)
                         (grupo ?grupo&~1 &~5)
                         )


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-desayuno $?alimentos-desayuno ?nombre-alimento) (ids-desayuno $?ids-desayuno ?id-alimento) (kcal-desayuno (+ ?kcal-desayuno ?kcal-alimento)))


         )

(defrule dieta-almuerzo-fruta "Recupera fruta para el almuerzo"
         (declare (salience 99))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (almuerzo-dieta (dia-almuerzo ?dia&:(eq ?dia ?dia-dieta)) (kcal-almuerzo ?kcal-almuerzo) (alimentos-almuerzo $?alimentos-almuerzo)
                               (ids-almuerzo $?ids-almuerzo)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                               (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5&:(< ?grupo5 1))(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-almuerzo) (* ?kcal 0.2)))
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (comida ?comida)
                         (merienda ?merienda)
                         (cena ?cena)
                         (almuerzo si)
                         (grupo 5))


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-almuerzo $?alimentos-almuerzo ?nombre-alimento) (ids-almuerzo $?ids-almuerzo ?id-alimento)
                 (kcal-almuerzo (+ ?kcal-almuerzo ?kcal-alimento)) (grupo5 (+ ?grupo5 1) ))

         )

(defrule dieta-almuerzo-alimentos "Recupera alimentos para el almuerzo"
         (declare (salience 98))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (almuerzo-dieta (dia-almuerzo ?dia&:(eq ?dia ?dia-dieta)) (kcal-almuerzo ?kcal-almuerzo) (alimentos-almuerzo $?alimentos-almuerzo)
                               (ids-almuerzo $?ids-almuerzo)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                               (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-almuerzo) (* ?kcal 0.2)))
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (comida ?comida)
                         (merienda ?merienda)
                         (cena ?cena)
                         (almuerzo si)
                         (grupo ?grupo&~5)
                         )


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-almuerzo $?alimentos-almuerzo ?nombre-alimento) (ids-almuerzo $?ids-almuerzo ?id-alimento)
                 (kcal-almuerzo (+ ?kcal-almuerzo ?kcal-alimento)) (grupo6 (+ ?grupo6 1) ))

         )

(defrule dieta-comida-proteinas "Recupera proteinas para la comida"
         (declare (salience 97))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (comida-dieta (dia-comida ?dia&:(eq ?dia ?dia-dieta)) (kcal-comida ?kcal-comida) (alimentos-comida $?alimentos-comida)
                             (ids-comida $?ids-comida)(grupo1 ?grupo1) (grupo2 ?grupo2&:(< ?grupo2 1)) (grupo3 ?grupo3)
                             (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento)
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (merienda ?merienda)
                         (cena ?cena)
                         (comida si)
                         (grupo 2))

         (not (exists (alimento (id ?id-alimento2&: (and (member$ ?id-alimento2 $?ids) (not (member$ ?id-alimento2 $?ids-comida)))) (nombre ?nombre-alimento2)

                                (racion ?racion2)
                                (kcal ?kcal-alimento2)
                                (proteinas ?proteinas2&: (> ?proteinas2 ?proteinas))
                                (grasas ?grasas2)
                                (grasas-mono ?grasas-mono2)
                                (hidratos ?hidratos2)
                                (merienda ?merienda2)
                                (cena ?cena2)
                                (comida si)
                                (grupo 2))

                      ))

         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-comida $?alimentos-comida ?nombre-alimento) (ids-comida $?ids-comida ?id-alimento)
                 (kcal-comida (+ ?kcal-comida ?kcal-alimento)) (grupo2 (+ ?grupo2 1) ))

         )

(defrule dieta-comida-legumbre "Recupera legumbre o patata para la comida"
         (declare (salience 96))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (comida-dieta (dia-comida ?dia&:(eq ?dia ?dia-dieta)) (kcal-comida ?kcal-comida) (alimentos-comida $?alimentos-comida)
                             (ids-comida $?ids-comida)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3&:(< ?grupo3 1))
                             (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento)
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (almuerzo ?almuerzo)
                         (merienda ?merienda)
                         (cena ?cena)
                         (comida si)
                         (grupo 3))


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-comida $?alimentos-comida ?nombre-alimento) (ids-comida $?ids-comida ?id-alimento)
                 (kcal-comida (+ ?kcal-comida ?kcal-alimento)) (grupo6 (+ ?grupo6 1) ))

         )


(defrule dieta-comida-hidratos "Recupera carbohidratos para la comida"
         (declare (salience 95))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (comida-dieta (dia-comida ?dia&:(eq ?dia ?dia-dieta)) (kcal-comida ?kcal-comida) (alimentos-comida $?alimentos-comida)
                             (ids-comida $?ids-comida)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                             (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6&: (< ?grupo6 3)) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento)
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (almuerzo ?almuerzo)

                         (merienda ?merienda)
                         (cena ?cena)
                         (comida si)
                         (grupo 6))


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-comida $?alimentos-comida ?nombre-alimento) (ids-comida $?ids-comida ?id-alimento)
                 (kcal-comida (+ ?kcal-comida ?kcal-alimento)) (grupo6 (+ ?grupo6 1) ))

         )

(defrule dieta-comida-verduras "Recupera verduras para la comida"
         (declare (salience 94))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (comida-dieta (dia-comida ?dia&:(eq ?dia ?dia-dieta)) (kcal-comida ?kcal-comida) (alimentos-comida $?alimentos-comida)
                             (ids-comida $?ids-comida)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                             (grupos36 ?grupos36) (grupo4 ?grupo4&:(< ?grupo4 2)) (grupo5 ?grupo5)(grupo6 ?grupo6&: (< ?grupo6 3)) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-comida) (* ?kcal 0.35)))
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (almuerzo ?almuerzo)

                         (merienda ?merienda)
                         (cena ?cena)
                         (comida si)
                         (grupo 4))


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-comida $?alimentos-comida ?nombre-alimento) (ids-comida $?ids-comida ?id-alimento)
                 (kcal-comida (+ ?kcal-comida ?kcal-alimento)) (grupo4 (+ ?grupo4 1) ))

         )

(defrule dieta-comida-grasa "Recupera grasa para la comida"
         (declare (salience 93))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (comida-dieta (dia-comida ?dia&:(eq ?dia ?dia-dieta)) (kcal-comida ?kcal-comida) (alimentos-comida $?alimentos-comida)
                             (ids-comida $?ids-comida)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                             (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7&:(< ?grupo7 1)))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento)
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (almuerzo ?almuerzo)

                         (merienda ?merienda)
                         (cena ?cena)
                         (comida si)
                         (grupo 7))


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-comida $?alimentos-comida ?nombre-alimento) (ids-comida $?ids-comida ?id-alimento)
                 (kcal-comida (+ ?kcal-comida ?kcal-alimento)) (grupo7 (+ ?grupo7 1) ))

         )

(defrule dieta-comida "Recupera alimentos para la comida"
         (declare (salience 92))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (comida-dieta (dia-comida ?dia&:(eq ?dia ?dia-dieta)) (kcal-comida ?kcal-comida) (alimentos-comida $?alimentos-comida)
                             (ids-comida $?ids-comida)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                             (grupos36 ?grupos36) (grupo4 ?grupo4)(grupo5 ?grupo5) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-comida) (* ?kcal 0.4)))
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (almuerzo ?almuerzo)
                         (merienda ?merienda)
                         (cena ?cena)
                         (comida si)
                         (grupo ?grupo& ~1 & ~5 & ~2 & ~4)
                         )


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-comida $?alimentos-comida ?nombre-alimento) (ids-comida $?ids-comida ?id-alimento) (kcal-comida (+ ?kcal-comida ?kcal-alimento)))


         )

(defrule dieta-merienda-fruta "Recupera fruta para la merienda"
         (declare (salience 91))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (merienda-dieta (dia-merienda ?dia&:(eq ?dia ?dia-dieta)) (kcal-merienda ?kcal-merienda) (alimentos-merienda $?alimentos-merienda)
                               (ids-merienda $?ids-merienda)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                               (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5&:(< ?grupo5 1))(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-merienda) (* ?kcal 0.2)))
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (comida ?comida)
                         (cena ?cena)
                         (merienda si)
                         (grupo 5))


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-merienda $?alimentos-merienda ?nombre-alimento) (ids-merienda $?ids-merienda ?id-alimento)
                 (kcal-merienda (+ ?kcal-merienda ?kcal-alimento)) (grupo5 (+ ?grupo5 1) ))

         )

(defrule dieta-merienda-alimentos "Recupera alimentos para la merienda"
         (declare (salience 90))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (merienda-dieta (dia-merienda ?dia&:(eq ?dia ?dia-dieta)) (kcal-merienda ?kcal-merienda) (alimentos-merienda $?alimentos-merienda)
                               (ids-merienda $?ids-merienda)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                               (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-merienda) (* ?kcal 0.2)))
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (comida ?comida)
                         (cena ?cena)
                         (merienda si)
                         (grupo ?grupo&~5)
                         )


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-merienda $?alimentos-merienda ?nombre-alimento) (ids-merienda $?ids-merienda ?id-alimento)
                 (kcal-merienda (+ ?kcal-merienda ?kcal-alimento)) (grupo6 (+ ?grupo6 1) ))

         )

(defrule dieta-cena-proteinas "Recupera proteinas para la cena"
         (declare (salience 89))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (cena-dieta (dia-cena ?dia&:(eq ?dia ?dia-dieta)) (kcal-cena ?kcal-cena) (alimentos-cena $?alimentos-cena)
                           (ids-cena $?ids-cena)(grupo1 ?grupo1) (grupo2 ?grupo2&:(< ?grupo2 1)) (grupo3 ?grupo3)
                           (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo6 ?grupo6) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento)
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (merienda ?merienda)
                         (cena si)
                         (grupo 2))


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-cena $?alimentos-cena ?nombre-alimento) (ids-cena $?ids-cena ?id-alimento)
                 (kcal-cena (+ ?kcal-cena ?kcal-alimento)) (grupo2 (+ ?grupo2 1) ))

         )

(defrule dieta-cena "Recupera alimentos para la cena"
         (declare (salience 88))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (cena-dieta (dia-cena ?dia&:(eq ?dia ?dia-dieta)) (kcal-cena ?kcal-cena) (alimentos-cena $?alimentos-cena)
                           (ids-cena $?ids-cena)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3) (grupos36 ?grupos36)
                           (grupo4 ?grupo4)(grupo5 ?grupo5) (grupo7 ?grupo7))

         ?a <- (alimento (id ?id-alimento&:(and (member$ ?id-alimento $?ids) (not (member$ ?id-alimento $?usados-reparto))))(nombre ?nombre-alimento)

                         (racion ?racion)
                         (kcal ?kcal-alimento)
                         (proteinas ?proteinas)
                         (grasas ?grasas)
                         (grasas-mono ?grasas-mono)
                         (hidratos ?hidratos)
                         (almuerzo ?almuerzo)
                         (merienda ?merienda)
                         (cena si)
                         (grupo ?grupo&~2)
                         )


         =>

         (modify ?u (alimentos $?usados-reparto ?id-alimento))
         (modify ?c (alimentos-cena $?alimentos-cena ?nombre-alimento) (ids-cena $?ids-cena ?id-alimento) (kcal-cena (+ ?kcal-cena ?kcal-alimento)))


         )



(defrule salida-por-pantalla

         (rcd ?rcd)

         ?dieta <- (dieta (dia ?dia&:(eq ?dia jueves)) (estado solucion) (kcal ?kcal)
                          (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                          (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                          (ids $?ids) (total-alimentos ?total-alimentos)(alimentos $?alimentos))
         ?d <- (desayuno-dieta (dia-desayuno ?dia&:(eq ?dia jueves)) (kcal-desayuno ?kcal-desayuno) (alimentos-desayuno $?alimentos-desayuno) (ids-desayuno $?ids-desayuno))
         ?a <- (almuerzo-dieta (dia-almuerzo ?dia&:(eq ?dia jueves)) (kcal-almuerzo ?kcal-almuerzo) (alimentos-almuerzo $?alimentos-almuerzo) (ids-almuerzo $?ids-almuerzo))
         ?c <- (comida-dieta (dia-comida ?dia&:(eq ?dia jueves)) (kcal-comida ?kcal-comida) (alimentos-comida $?alimentos-comida) (ids-comida $?ids-comida))
         ?m <- (merienda-dieta (dia-merienda ?dia&:(eq ?dia jueves)) (kcal-merienda ?kcal-merienda) (alimentos-merienda $?alimentos-merienda) (ids-merienda $?ids-merienda))
         ?n <- (cena-dieta (dia-cena ?dia&:(eq ?dia jueves)) (kcal-cena ?kcal-cena) (alimentos-cena $?alimentos-cena) (ids-cena $?ids-cena))


         =>
         (printout t "Dia " ?dia crlf)
         (printout t "Desayuno" crlf)
         (loop-for-count (?i 1 (length$ ?ids-desayuno) )
                         (do-for-all-facts ((?alimento alimento ))
                                           (= ?alimento:id (nth$ ?i $?ids-desayuno))

                                           (printout t "          Alimento: " ?alimento:nombre "," ?alimento:racion "g," ?alimento:kcal " kcal" crlf)
                                           ))
         (printout t "Almuerzo" crlf)
         (loop-for-count (?i 1 (length$ ?ids-almuerzo) )
                         (do-for-all-facts ((?alimento alimento ))
                                           (= ?alimento:id (nth$ ?i $?ids-almuerzo))

                                           (printout t "          Alimento: " ?alimento:nombre "," ?alimento:racion "g," ?alimento:kcal " kcal" crlf)
                                           ))
         (printout t "Comida" crlf)
         (loop-for-count (?i 1 (length$ ?ids-comida) )
                         (do-for-all-facts ((?alimento alimento ))
                                           (= ?alimento:id (nth$ ?i $?ids-comida))

                                           (printout t "          Alimento: " ?alimento:nombre "," ?alimento:racion "g," ?alimento:kcal " kcal" crlf)
                                           ))
         (printout t "Merienda" crlf)
         (loop-for-count (?i 1 (length$ ?ids-merienda) )
                         (do-for-all-facts ((?alimento alimento ))
                                           (= ?alimento:id (nth$ ?i $?ids-merienda))

                                           (printout t "          Alimento: " ?alimento:nombre "," ?alimento:racion "g," ?alimento:kcal " kcal" crlf)
                                           ))
         (printout t "Cena" crlf)
         (loop-for-count (?i 1 (length$ ?ids-cena) )
                         (do-for-all-facts ((?alimento alimento ))
                                           (= ?alimento:id (nth$ ?i $?ids-cena))

                                           (printout t "          Alimento: " ?alimento:nombre "," ?alimento:racion "g," ?alimento:kcal " kcal" crlf)
                                           ))
         (printout t "TOTAL" crlf)
         (printout t "         % proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
         (printout t "         % hidratos:  " (/ (* ?kcal-hidratos 100) ?kcal) crlf)
         (printout t "         % grasas:    " (/ (* ?kcal-grasas 100) ?kcal) crlf)
         (printout t "           % monoinsaturadas: " (/ (* ?kcal-grasas-mono 100) ?kcal) crlf)
         (printout t "         Calorias:    " ?kcal crlf)
         (printout t "         Deficit calorico: " (- ?rcd ?kcal) crlf)
         (printout t "         Total alimentos: " ?total-alimentos crlf)
         (printout t ?alimentos crlf)
         (printout t "-------------------------------------------------------------" crlf)
         )

