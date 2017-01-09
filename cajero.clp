;;; Regla de petición del importe del reintegro (se puede hacer con dos reglas en lugar de una)
(defrule Pedir-importe
         ?estado <- (inicio)
         =>
         (retract ?estado)
         (printout t crlf "Teclee el importe del reintegro (multiplo de 10) (0 para salir): " crlf)
         (bind ?in (read))
         (if (= ?in 0) then (halt))
         (if (= (mod ?in 10) 0) then
                                (assert (reintegro ?in))
                                (assert (nodo))
                                else
                                (assert (inicio))
                                )
         )
;;; Reglas de los operadores
(defrule operador-100
         ?nodo <- (nodo (bill-100 ?bill-100) (bill-50 ?bill-50) (bill-20 ?bill-20) (bill-10 ?bill-10) (num-bill ?num-bill) (importe-bill
                                                                                                                             ?importe-bill) (estado cerrado))
         (cajero (bill-100 ?caj-bill-100&:(> ?caj-bill-100 ?bill-100)))
         =>
         (assert (nodo (bill-100 (+ ?bill-100 1)) (bill-50 ?bill-50) (bill-20 ?bill-20) (bill-10 ?bill-10)(num-bill (+ ?num-bill 1)) (importe-bill
                                                                                                                                       (+ ?importe-bill 100))))
         )
(defrule operador-50
         ?nodo <- (nodo (bill-100 ?bill-100) (bill-50 ?bill-50) (bill-20 ?bill-20) (bill-10 ?bill-10) (num-bill ?num-bill) (importe-bill
                                                                                                                             ?importe-bill) (estado cerrado))
         (cajero (bill-50 ?caj-bill-50&:(> ?caj-bill-50 ?bill-50)))
         =>
         (assert (nodo (bill-100 ?bill-100) (bill-50 (+ ?bill-50 1)) (bill-20 ?bill-20) (bill-10 ?bill-10) (num-bill (+ ?num-bill 1)) (importe-bill (+ ?importe-bill 50))))
         )
(defrule operador-20
         ?nodo <- (nodo (bill-100 ?bill-100) (bill-50 ?bill-50) (bill-20 ?bill-20) (bill-10 ?bill-10) (num-bill ?num-bill) (importe-bill
                                                                                                                                        ?importe-bill) (estado cerrado))
         (cajero (bill-20 ?caj-bill-20&:(> ?caj-bill-20 ?bill-20)))
         =>
         (assert (nodo (bill-100 ?bill-100) (bill-50 ?bill-50) (bill-20 (+ ?bill-20 1)) (bill-10 ?bill-10) (num-bill (+ ?num-bill 1)) (importe-bill (+ ?importe-bill 20))))
         )
(defrule operador-10
         ?nodo <- (nodo (bill-100 ?bill-100) (bill-50 ?bill-50) (bill-20 ?bill-20) (bill-10 ?bill-10) (num-bill ?num-bill) (importe-bill
                                                                                                                             ?importe-bill) (estado cerrado))
         (cajero (bill-10 ?caj-bill-10&:(> ?caj-bill-10 ?bill-10)))
         =>
         (assert (nodo (bill-100 ?bill-100) (bill-50 ?bill-50) (bill-20 ?bill-20) (bill-10 (+ ?bill-10 1)) (num-bill (+ ?num-bill 1)) (importe-bill (+ ?importe-bill 10))))
         )
;;; Regla de selección del nodo de menor coste.
(defrule cierra-nodo-menor-costo
         (declare (salience -10))
         ?nodo-1 <- (nodo (importe-bill ?importe-bill) (num-bill ?num-bill1) (estado abierto))
         (not (exists (nodo (num-bill ?num-bill2&:(< ?num-bill2 ?num-bill1)) (estado abierto))))
         =>
         (modify ?nodo-1 (estado cerrado))
         )
;;; Regla que se dispara solamente si ya no es posible encontrar la solución
(defrule sin-solucion
         (declare (salience -100))
         (not (solucion-encontrada))
         =>
         (printout t crlf "Actualmente no hay suficientes billetes para ese reintegro " crlf)
         )
;;; Regla que se dispara solamente si ya no es posible encontrar la solución
(defrule elimina-nodos-excesivo-importe
         (declare (salience 100))
         (reintegro ?reintegro)
         ?nodo <- (nodo (importe-bill ?importe-bill&: (> ?importe-bill ?reintegro)))
         =>
         (retract ?nodo)
         )
;;; Regla que identifica un nodo solución
(defrule identifica-solucion
         (declare (salience 100))
         (reintegro ?reintegro)
         (nodo (importe-bill ?importe-bill&: (= ?importe-bill ?reintegro)) (bill-100 ?bill-100) (bill-50 ?bill-50) (bill-20 ?bill-20) (bill-10 ?bill-10))
         =>
         (printout t crlf "Se reintegra con los siguientes billetes: " crlf)
         (printout t crlf ?bill-100 " Billetes de 100" crlf)
         (printout t crlf ?bill-50 " Billetes de 50" crlf)
         (printout t crlf ?bill-20 " Billetes de 20" crlf)
         (printout t crlf ?bill-10 " Billetes de 10" crlf)
         (assert (solucion-encontrada))(halt)
         )