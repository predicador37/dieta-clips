(test (or (<= (+ ?kcal-proteinas (* ?proteinas 4)) (* 0.1 ?rcd))
      (and (> (+ ?kcal-proteinas (* ?proteinas 4)) (* 0.1 ?rcd))
           (<= (+ ?kcal-proteinas (* ?proteinas 4)) (* 0.15 ?rcd)))))



(test (or (<= ?grupo2 2) (and (> ?grupo2 2) (<= ?grupo2 3))))

Dieta: (avena-salvado-de mayonesa yogur-descr-saborizado jamon-cocido judias-blancas-guisadas puerro pera chocolate-amargo aceite-de-semillas queso-philadelphia bistec-de-ternera nuez espinacas-cocidas pinya fideos-de-harina-integral manteca-de-cerdo requeson almendra zanahoria naranja)
Calorias totales: 2422.2
Calorias proteinas: 356.24
% Calorias proteinas: 14.707290892577
Calorias hidratos: 0
% Calorias hidratos: 0.0
Grupo 1: 3
Grupo 2: 2
Grupo 3-6: 6
Grupo 4: 3
Grupo 5: 3
Grupo 7: 3 


(defrule cierra-dieta-menor-costo-5
         (declare (salience -9))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos&:(< ?kcal-hidratos (* ?rcd 0.5)))
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7)
                      (grupo2 ?grupo2))
         (not (exists (dieta  (kcal-hidratos ?kcal-hidratos2&: (> ?kcal-hidratos2 ?kcal-hidratos)) (estado abierto) )))
         ;(not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos ?total-alimentos2)) (estado abierto))))

         =>
         (modify ?d (estado cerrado))
         )
(defrule cierra-dieta-menor-costo-6
         (declare (salience -9))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal)(total-alimentos ?total-alimentos)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas&:(< ?kcal-grasas (* ?rcd 0.3)))
                      (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1)
                      (grupos36 ?grupos36) (grupo4 ?grupo4) (grupo5 ?grupo5) (grupo7 ?grupo7)
                      (grupo2 ?grupo2))
         (not (exists (dieta  (kcal-grasas ?kcal-grasas2&: (> ?kcal-grasas2 ?kcal-grasas)) (estado abierto) )))
         ;(not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos ?total-alimentos2)) (estado abierto))))

         =>
         (modify ?d (estado cerrado))
         )

         CLIPS> (run)
         RCD: 2017.62
         Dieta: (mantequilla 5 nata-liquida 40 manteca-de-cerdo 10 pasta-seca-al-huevo 150 galleta-tipo-maria 30 pan-tostado 5 pan-integral 15 fideos-de-harina-integral 75 chocolate-amargo 25 kiwi 200 manzana 200 platano 125 acelga 100 calabacin 50 requeson 50 jamon-cocido 30 edam 20 lacon 25)
         Calorias totales: 2006.05
         Calorias proteinas: 299.96
         % Calorias proteinas: 14.9527678771716
         Calorias hidratos: 1108.3
         % Calorias hidratos: 55.2478751775878
         Calorias grasas: 598.185
         % Calorias grasas: 29.8190473816704
         Grupo 1: 2
         Grupo 2: 2
         Grupo 3-6: 6
         Grupo 4: 2
         Grupo 5: 3
         Grupo 7: 3
         8021 iteraciones


Dieta: (mantequilla 5 nata-liquida 40 manteca-de-cerdo 10 pasta-seca-al-huevo 150 galleta-tipo-maria 30 pan-tostado 5 pan-integral 15 fideos-de-harina-integral 75 chocolate-amargo 25 yogur-con-frutas 50 yogur-con-cereales 50 jamon-cocido 25 limon 25 calabacin 50 arandano 10 cebolla 25 huevo-entero 50)
Calorias totales: 1633.45
Calorias proteinas: 244.92
% Calorias proteinas: 14.9940310385993
Calorias hidratos: 874.84
% Calorias hidratos: 53.5578070954116
Calorias grasas: 510.3
% Calorias grasas: 31.240625669595
Grupo 1: 2
Grupo 2: 2
Grupo 3-6: 6
Grupo 4: 2
Grupo 5: 2
Grupo 7: 3
524.59772773739


Dieta: (pasta-seca-al-huevo 150 galleta-tipo-maria 30 pan-tostado 5 pan-integral 15 fideos-de-harina-integral 75 arroz-cocido 200 mantequilla 5 nata-liquida 40 manteca-de-cerdo 10 yogur-con-frutas 100 limon 25 arandano 25 sandia 100 queso-philadelphia 20 espinacas-cocidas 50 merluza 80 calabacin 50 lacon 30)
Calorias totales: 1931.1
Calorias proteinas: 288.22
% Calorias proteinas: 14.9251721816581
Calorias hidratos: 1108.98
% Calorias hidratos: 57.4273729998446
Calorias grasas: 537.075
% Calorias grasas: 27.81186888302
Grupo 1: 2
Grupo 2: 2
Grupo 3-6: 6
Grupo 4: 2
Grupo 5: 3
Grupo 7: 3
6.41508071590215

RCD: 2351.0
Dieta: (pasta-seca-al-huevo 150 galleta-tipo-maria 30 pan-tostado 5 pan-integral 15 fideos-de-harina-integral 75 miel 50 lechuga 100 zanahoria 50 cebolla 25 kiwi 200 manzana 200 mantequilla 5 nata-liquida 40 manteca-de-cerdo 10 platano 125 yogur-con-frutas 50 huevo-entero 125 tomate 100 lacon 50 queso-fresco 25)
Calorias totales: 2303.35
Calorias proteinas: 341.38
% Calorias proteinas: 14.8210215555604
Calorias hidratos: 1292.9
% Calorias hidratos: 56.131287038444
Calorias grasas: 673.515
% Calorias grasas: 29.240671196301
Grupo 1: 2
Grupo 2: 2
Grupo 3-6: 6
Grupo 4: 4
Grupo 5: 3
Grupo 7: 3

Dieta: (arroz-cocido 250 pan-integral 15 patatas-asadas 200 avena-salvado-de 50 avena-salvado-de 50 miel 50 acelga 300 espinacas-cocidas 200 puerro 200 naranja 175 fresa 100 margarina 50 pinya 175 yogur-con-cereales 50 jamon-cocido 30 yogur-descr-saborizado 50 pollo-pechuga 50)
Calorias totales: 2282.5
Calorias proteinas: 276.78
% Calorias proteinas: 12.1261774370208
Calorias hidratos: 1283.3
% Calorias hidratos: 56.223439211391
Calorias grasas: 815.67
% Calorias grasas: 35.7358159912377
Grupo 1: 2
Grupo 2: 2
Grupo 3-6: 6
Grupo 4: 3
Grupo 5: 3
Grupo 7: 1



(defrule cierra-dieta-menor-costo-proteinas-1
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 14)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 2)
                      (grupo2 1) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.56)))
         (test (<= ?kcal-proteinas (* ?rcd 0.16)))

         =>
         (modify ?d (estado cerrado))
         )

(defrule cierra-dieta-menor-costo-proteinas-2
         (declare (salience -10))
         (rcd ?rcd)
         ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos 15)
                      (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                      (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 2)
                      (grupo2 2) (grupos36 6) (grupo4 3) (grupo5 2) (grupo7 ?grupo7))

         ; (not (exists (dieta  (total-alimentos ?total-alimentos2&: (> ?total-alimentos2 ?total-alimentos )) (estado abierto))))
         (test (<= ?kcal-hidratos (* ?rcd 0.56)))
         (test (<= ?kcal-proteinas (* ?rcd 0.16)))

         =>
         (modify ?d (estado cerrado))
         )




         (defrule cierra-dieta-menor-costo-1
                  (declare (salience -8))
                  ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos ?total-alimentos)
                               (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                               (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1&: (>= ?grupo1 2))
                               (grupo2 ?grupo2&: (>= ?grupo2 2)) (grupos36 ?grupos36&: (>= ?grupos36 4)) (grupo4 ?grupo4&: (>= ?grupo4 2)) (grupo5 ?grupo5&: (>= ?grupo5 2)) (grupo7 ?grupo7))


                  ;(not (exists (dieta (kcal ?kcal2&: (> ?kcal2 ?kcal)) (total-alimentos ?total-alimentos))))
                  =>
                  (modify ?d (estado cerrado))
                  )
         (defrule cierra-dieta-menor-costo-2
                  (declare (salience -9))
                  ?d <- (dieta (estado abierto) (kcal ?kcal) (total-alimentos ?total-alimentos)
                               (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                               (kcal-grasas ?kcal-grasas) (gramos-grasa ?gramos-grasa) (alimentos $?alimentos) (grupo1 ?grupo1&: (>= ?grupo1 1))
                               (grupo2 ?grupo2&: (>= ?grupo2 2)) (grupos36 ?grupos36&: (>= ?grupos36 2)) (grupo4 ?grupo4&: (>= ?grupo4 1)) (grupo5 ?grupo5&: (>= ?grupo5 1)) (grupo7 ?grupo7))


                  ;(not (exists (dieta (kcal ?kcal2&: (> ?kcal2 ?kcal)) (total-alimentos ?total-alimentos))))
                  =>
                  (modify ?d (estado cerrado))
                  )
;---------------------------------------------------------------------------------------------------------------------------
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
         ?d<- (dieta (total-alimentos ?total-alimentos&: (< ?total-alimentos 16)) (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                     (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos) (grupo1 ?grupo1&: (< ?grupo1 2))
                     )
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grupo2
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (total-alimentos ?total-alimentos&: (< ?total-alimentos 16)) (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                     (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos)
                     (grupo2 ?grupo2&: (< ?grupo2 2)) )
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grupos36
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (total-alimentos ?total-alimentos&: (< ?total-alimentos 16)) (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                     (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos)(grupos36 ?grupos36&: (< ?grupos36 4)) )
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grupo4
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (total-alimentos ?total-alimentos&: (< ?total-alimentos 16)) (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                     (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos)  (grupo4 ?grupo4&: (< ?grupo4 2)) )
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grupo5
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (total-alimentos ?total-alimentos&: (< ?total-alimentos 16))(kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05))))
                     (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos)  (grupo5 ?grupo5&: (< ?grupo5 2)) )
         =>
         (retract ?d)
         )
(defrule descarta-minimo-grasas
         (declare (salience 100))
         (rcd ?rcd)
         ?d<- (dieta (total-alimentos ?total-alimentos&: (< ?total-alimentos 16)) (kcal ?kcal&: (and (>= ?kcal (- ?rcd (* ?rcd 0.05))) (<= ?kcal (* ?rcd 1.05)))) (gramos-grasa ?gramos-grasa&: (< ?gramos-grasa 40))
                     (kcal-proteinas ?kcal-proteinas) (alimentos $?alimentos)(grupo7 ?grupo7&: (< ?grupo7 1)) )
         =>
         (retract ?d)
         )

(dieta (dia lunes) (estado solucion) (kcal 1956.95) (kcal-proteinas 303.26) (kcal-hidratos 1046.06)(kcal-grasas 642.42)(kcal-grasas-mono 307.665) (gramos-grasa 55) (total-alimentos 16) (alimentos 130 107 267 274 291 314 167 177 186 218 230 4 17 54 100 354 ))
(dieta (dia martes) (estado solucion) (kcal 1967.5) (kcal-proteinas 297.44) (kcal-hidratos 1049.46)(kcal-grasas 668.925)(kcal-grasas-mono 355.275) (gramos-grasa 40) (total-alimentos 17) (alimentos 130 116 303 286 291 307 171 181 207 221 239 12 30 58 84 352 391 ))
(dieta (dia miercoles) (estado solucion) (kcal 1971.05) (kcal-proteinas 258.62) (kcal-hidratos 1055.52)(kcal-grasas 683.325)(kcal-grasas-mono 309.015) (gramos-grasa 40) (total-alimentos 17) (alimentos 130 124 323 274 291 314 191 201 206 227 232 1 6 71 98 339 391 ))
(dieta (dia jueves) (estado solucion) (kcal 1971.05) (kcal-proteinas 258.62) (kcal-hidratos 1055.52)(kcal-grasas 683.325)(kcal-grasas-mono 309.015 (gramos-grasa 40) (total-alimentos 17) (alimentos 130 116 303 286 291 307 171 181 207 221 239 12 30 58 84 352 391 ))
(dieta (dia viernes) (estado solucion) (kcal 1959.9) (kcal-proteinas 298.38) (kcal-hidratos 1049.22)(kcal-grasas 634.23)(kcal-grasas-mono 354.915) (gramos-grasa 40) (total-alimentos 17) (alimentos 130 138 329 274 291 308 191 206 211 227 247 3 6 87 99 339 391 ))


       (defrule asigna-restos "Asigna alimentos sobrantes"
                (declare (salience 94))
                ?d <- (dieta (dia ?dia) (estado solucion) (kcal ?kcal)
                             (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                             (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                             (ids $?ids) (grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3) (grupos36 ?grupos36) (grupo4 ?grupo4)
                             (grupo5 ?grupo5) (grupo7 ?grupo7))

                ?u <- (usados-reparto (alimentos $?usados-reparto))

                ?c <- (cena-dieta (dia-cena ?dia) (kcal-cena ?kcal-cena) (alimentos-cena $?alimentos-cena) (ids-cena $?ids-cena))

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
                                (grupo ?grupo)
                                )


                =>

                (modify ?u (alimentos $?usados-reparto ?id-alimento))
                (modify ?c (alimentos-cena $?alimentos-cena ?nombre-alimento) (ids-cena $?ids-cena ?id-alimento) (kcal-cena (+ ?kcal-cena ?kcal-alimento)))


                )

       (defrule lista-alimentos "Muestra lista de alimentos"
                (declare (salience -10))

                ?d <- (dieta (dia lunes) (estado solucion) (kcal ?kcal)
                             (kcal-proteinas ?kcal-proteinas) (kcal-hidratos ?kcal-hidratos)
                             (kcal-grasas ?kcal-grasas) (kcal-grasas-mono ?kcal-grasas-mono) (gramos-grasa ?gramos-grasa)
                             (ids $?ids) (grupo1 ?grupo1) (grupo2 ?grupo2) (grupo3 ?grupo3) (grupos36 ?grupos36) (grupo4 ?grupo4)
                             (grupo5 ?grupo5) (grupo7 ?grupo7))


                =>
                (loop-for-count (?i 1 (length$ ?ids) )
                                (do-for-all-facts ((?alimento alimento ))
                                                  (= ?alimento:id (nth$ ?i ?ids))

                                                  (printout t ?i " Alimento: " ?alimento:nombre "," ?alimento:racion "g," ?alimento:kcal " kcal" crlf)
                                                  ))
                (printout t "Total " (length$ ?ids) " alimentos" clrf)
                (printout t "FIN")
                )