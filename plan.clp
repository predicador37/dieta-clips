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




;---------------------------------------------------------------------------
(defrule operador-grupo-3 "Elige alimentos de los grupos 3 y 6 "
         (rcd ?rcd)
         ?d <- (dieta (estado cerrado) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas)(kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7))

         (alimento (id ?id-alimento1) (nombre ?nombre-alimento1&: (not (member$ ?nombre-alimento1 $?alimentos))) (racion ?racion1) (kcal ?kcal-alimento1)
                   (proteinas ?proteinas1)(grasas ?grasas1)(hidratos ?hidratos1) (grupo ?grupo-1&: (or(= ?grupo-1 3) (= ?grupo-1 6))))

         (alimento (id ?id-alimento2) (nombre ?nombre-alimento2&: (not (member$ ?nombre-alimento2 $?alimentos))
                                             ) (racion ?racion2) (kcal ?kcal-alimento2)
                   (proteinas ?proteinas2)(grasas ?grasas2)(hidratos ?hidratos2) (grupo ?grupo-2&: (or (= ?grupo-2 3) (= ?grupo-2 6))))

         (alimento (id ?id-alimento3) (nombre ?nombre-alimento3&:  (not (member$ ?nombre-alimento3 $?alimentos))

                                                                       )
                   (racion ?racion3) (kcal ?kcal-alimento3)
                   (proteinas ?proteinas3)(grasas ?grasas3)(hidratos ?hidratos3) (grupo ?grupo-3&: (or(= ?grupo-3 3) (= ?grupo-3 6))))

         (alimento (id ?id-alimento4) (nombre ?nombre-alimento4&:  (not (member$ ?nombre-alimento4 $?alimentos))
                                                                      )                   (racion ?racion4) (kcal ?kcal-alimento4)
                   (proteinas ?proteinas4)(grasas ?grasas4)(hidratos ?hidratos4) (grupo ?grupo-4&: (or (= ?grupo-4 3) (= ?grupo-4 6))))

         ;(test ( <= (+ (/ (* ?hidratos1 4 ?racion1) 100) (/ (* ?hidratos2 4 ?racion2) 100) (/ (* ?hidratos3 4 ?racion3) 100)
          ;        (/ (* ?hidratos4 4 ?racion4) 100)) (* ?rcd 0.52)))
         ;(test ( >= (+ (/ (* ?hidratos1 4 ?racion1) 100) (/ (* ?hidratos2 4 ?racion2) 100) (/ (* ?hidratos3 4 ?racion3) 100)
           ;            (/ (* ?hidratos4 4 ?racion4) 100)) (* ?rcd 0.48)))


         =>

         (assert (dieta (alimentos $?alimentos ?nombre-alimento1 ?racion1 ?nombre-alimento2 ?racion2
                                   ?nombre-alimento3 ?racion3 ?nombre-alimento4 ?racion4)
                        (kcal (+ ?kcal (/ (* ?kcal-alimento1 ?racion1) 100) (/ (* ?kcal-alimento2 ?racion2) 100)
                                 (/ (* ?kcal-alimento3 ?racion3) 100) (/ (* ?kcal-alimento4 ?racion4) 100)))
                        (kcal-proteinas (+ ?kcal-proteinas (/ (* ?proteinas1 4 ?racion1) 100)(/ (* ?proteinas2 4 ?racion2) 100)
                                           (/ (* ?proteinas3 4 ?racion3) 100) (/ (* ?proteinas4 4 ?racion4) 100)))
                        (kcal-hidratos (+ ?kcal-hidratos (/ (* ?hidratos1 4 ?racion1) 100)(/ (* ?hidratos2 4 ?racion2) 100)
                                          (/ (* ?hidratos3 4 ?racion3) 100) (/ (* ?hidratos4 4 ?racion4) 100)))
                        (kcal-grasas (+ ?kcal-grasas (/ (* ?grasas1 9 ?racion1) 100)(/ (* ?grasas2 9 ?racion2) 100)
                                        (/ (* ?grasas3 9 ?racion3) 100) (/ (* ?grasas4 9 ?racion4) 100)))
                        (gramos-grasa  ?gramos-grasa)
                        (grupo1 ?grupo1)(grupo2 ?grupo2)(grupos36 (+ ?grupos36 4))
                        (grupo4 ?grupo4) (grupo5 ?grupo5)(grupo7 ?grupo7)
                        (total-alimentos (+ ?total-alimentos 4))))


         )

;;; Regla de selección de la dieta de mayor aporte calórico.
(defrule cierra-dieta-menor-costo-1
         (declare (salience -8))
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1&:(>= ?grupo1 2))
                      (grupo2 ?grupo2&:(>= ?grupo2 2)) (grupos36 ?grupos36&:(>= ?grupos36 4)) (grupo4 ?grupo4&: (>= ?grupo4 2)) (grupo5 ?grupo5&: (>= ?grupo5 2)) (grupo7 ?grupo7))


         ;(not (exists (dieta (kcal ?kcal2&: (> ?kcal2 ?kcal)) (total-alimentos ?total-alimentos))))
         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-2
         (declare (salience -9))
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1&:(>= ?grupo1 1))
                      (grupo2 ?grupo2&:(>= ?grupo2 1)) (grupos36 ?grupos36&:(>= ?grupos36 2)) (grupo4 ?grupo4&: (>= ?grupo4 1)) (grupo5 ?grupo5&: (>= ?grupo5 1)) (grupo7 ?grupo7))


         ;(not (exists (dieta (kcal ?kcal2&: (> ?kcal2 ?kcal)) (total-alimentos ?total-alimentos))))
         =>
         (modify ?d (estado cerrado))
         )

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
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 1) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (test (= ?total-alimentos 1))
         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.5 )))
         (test (>= ?kcal-hidratos (/ (* ?rcd 0.5) 6)))
         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-2
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 2) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (test (= ?total-alimentos 2))
         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.5 )))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-3
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 3) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (test (= ?total-alimentos 3))
         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.5 )))
         (test (>= ?kcal-hidratos (/ (* ?rcd 0.5) 2)))
         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-4
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 4) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (test (= ?total-alimentos 4))
         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.5 )))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-5
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 5) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (test (= ?total-alimentos 5))
         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.5 )))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-hidratos-6
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 6) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (test (= ?total-alimentos 6))
         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.52 )))
         (test (>= ?kcal-hidratos  (* ?rcd 0.48) ))
         =>
         (modify ?d (estado cerrado))
         )


(defrule cierra-dieta-menor-costo
         (declare (salience -10))
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         (test (!= ?total-alimentos 1))
         (test (!= ?total-alimentos 2))
         (test (!= ?total-alimentos 3))
         (test (!= ?total-alimentos 4))
         (test (!= ?total-alimentos 5))
         (test (!= ?total-alimentos 6))
         ;(test (!= ?total-alimentos 7))
        (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         ;(not (exists (dieta (kcal ?kcal2&: (> ?kcal2 ?kcal)) (total-alimentos ?total-alimentos))))
              =>
              (modify ?d (estado cerrado))
         )

;----------------------------------------------------------------------------
;;; Regla que se dispara solamente si ya no es posible encontrar la solución
(defrule elimina-nodos-excesivo-calorico
        (declare (salience 100))
        (rcd ?rcd)
        ?d<- (dieta (kcal ?kcal&: (> ?kcal (* ?rcd 1.05))))
        =>
        (retract ?d)
        )

(defrule descarta-minimo-grupo1
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                (kcal-proteinas ?kcal-proteinas)  (alimentos $?alimentos)(grupo1 ?grupo1&: (< ?grupo1 2))
                (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grupo2
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                (kcal-proteinas ?kcal-proteinas)  (alimentos $?alimentos)(grupo1 ?grupo1)
                (grupo2 ?grupo2&: (< ?grupo2 2)) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grupos36
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                (kcal-proteinas ?kcal-proteinas)  (alimentos $?alimentos)(grupo1 ?grupo1)
                (grupo2 ?grupo2) (grupos36 ?grupos36&: (< ?grupos36 4)) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grupo4
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                (kcal-proteinas ?kcal-proteinas)  (alimentos $?alimentos)(grupo1 ?grupo1)
                (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4&: (< ?grupo4 2)) (grupo5 ?grupo5) (grupo7 ?grupo7))
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grupo5
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                (kcal-proteinas ?kcal-proteinas)  (alimentos $?alimentos)(grupo1 ?grupo1)
                (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5&: (< ?grupo5 2)) (grupo7 ?grupo7))
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grasas
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))(gramos-grasa ?gramos-grasa&:(< ?gramos-grasa 40))
                (kcal-proteinas ?kcal-proteinas)  (alimentos $?alimentos)(grupo1 ?grupo1)
                (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         =>
         (retract ?d)
         )

;;; Regla que identifica un nodo solución
(defrule identifica-solucion
         (declare (salience 99))
         (rcd ?rcd)
         ?d <- (dieta (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                (kcal-grasas ?kcal-grasas)(alimentos $?alimentos)(grupo1 ?grupo1)
                (grupo2 ?grupo2) (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7))
         =>
         (printout t "RCD: " ?rcd  crlf)
         (printout t "Dieta: " ?alimentos crlf)
         (printout t "Calorias totales: " ?kcal crlf)
         (printout t "Calorias proteinas: " ?kcal-proteinas crlf)
         (printout t "% Calorias proteinas: " (/ (* ?kcal-proteinas 100) ?kcal) crlf)
         (printout t "Calorias hidratos: " ?kcal-hidratos crlf)
         (printout t "% Calorias hidratos: " (/ (* ?kcal-hidratos 100) ?kcal) crlf)
         (printout t "Calorias grasas: " ?kcal-grasas crlf)
         (printout t "% Calorias grasas: " (/ (* ?kcal-grasas 100) ?kcal) crlf)
         (printout t "Grupo 1: " ?grupo1 crlf)
         (printout t "Grupo 2: " ?grupo2 crlf)
         (printout t "Grupo 3-6: " ?grupos36 crlf)
         (printout t "Grupo 4: " ?grupo4 crlf)
         (printout t "Grupo 5: " ?grupo5 crlf)
         (printout t "Grupo 7: " ?grupo7 crlf)
         (modify ?d (estado solucion))
         ;borrar todas las dietas generadas
         ;conseguir que las siguientes dietas no repitan estos alimentos
         ;añadir lógica de alimentos repetibles
         (assert (solucion-encontrada))(halt)
         )
(defrule limpieza
         (declare (salience 100))
         (solucion-encontrada)
         ?d <- (dieta (estado ?estado&:(or (eq ?estado abierto) (eq ?estado cerrado))))
         =>
         (retract d?)

                 )
;;; Regla que se dispara solamente si ya no es posible encontrar la solución
(defrule sin-solucion
         (declare (salience -100))
         (not (solucion-encontrada))
         =>
         (printout t crlf "Actualmente no hay alimentos que cumplan la dieta " crlf)
         )

