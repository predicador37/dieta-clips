

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
                               (ids-comida $?ids-comida)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                               (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5&:(< ?grupo5 1))(grupo6 ?grupo6) (grupo7 ?grupo7))

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

(defrule dieta-comida "Recupera alimentos para la comida"
         (declare (salience 93))
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
                         (kcal ?kcal-alimento&: (<= (+ (/ (* ?kcal-alimento ?racion) 100) ?kcal-comida) (* ?kcal 0.35)))
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
         (declare (salience 92))
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
         (declare (salience 91))
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
         (declare (salience 90))
         ?d <- (dieta (dia ?dia-dieta) (estado solucion) (kcal ?kcal)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                      (ids $?ids) )

         ?u <- (usados-reparto (dia ?dia-reparto&: (eq ?dia-reparto ?dia-dieta)) (alimentos $?usados-reparto))

         ?c <- (cena-dieta (dia-cena ?dia&:(eq ?dia ?dia-dieta)) (kcal-cena ?kcal-cena) (alimentos-cena $?alimentos-cena)
                             (ids-cena $?ids-cena)(grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3)
                             (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5&:(< ?grupo5 1))(grupo6 ?grupo6) (grupo7 ?grupo7))

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
         (declare (salience 89))
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

          ?dieta <- (dieta (dia ?dia&:(eq ?dia miercoles)) (estado solucion) (kcal ?kcal)
                                 (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                                 (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                                 (ids $?ids) )
         ?d <- (desayuno-dieta (dia-desayuno ?dia&:(eq ?dia miercoles)) (kcal-desayuno ?kcal-desayuno) (alimentos-desayuno $?alimentos-desayuno) (ids-desayuno $?ids-desayuno))
         ?a <- (almuerzo-dieta (dia-almuerzo ?dia&:(eq ?dia miercoles)) (kcal-almuerzo ?kcal-almuerzo) (alimentos-almuerzo $?alimentos-almuerzo) (ids-almuerzo $?ids-almuerzo))
         ?c <- (comida-dieta (dia-comida ?dia&:(eq ?dia miercoles)) (kcal-comida ?kcal-comida) (alimentos-comida $?alimentos-comida) (ids-comida $?ids-comida))
         ?m <- (merienda-dieta (dia-merienda ?dia&:(eq ?dia miercoles)) (kcal-merienda ?kcal-merienda) (alimentos-merienda $?alimentos-merienda) (ids-merienda $?ids-merienda))
         ?n <- (cena-dieta (dia-cena ?dia&:(eq ?dia miercoles)) (kcal-cena ?kcal-cena) (alimentos-cena $?alimentos-cena) (ids-cena $?ids-cena))


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
         (printout t "                      % monoinsaturadas: " (/ (* ?kcal-grasas-mono 100) ?kcal) crlf)
         (printout t "         Calorias:    " ?kcal crlf)
         (printout t "         Deficit calorico: " (- ?rcd ?kcal))
         (printout t "-------------------------------------------------------------" crlf)
         )
