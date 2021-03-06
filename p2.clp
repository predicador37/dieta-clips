(deftemplate tarifas

             (slot origen (type SYMBOL))
             (slot destino (type SYMBOL))
             (slot carta (type INTEGER))
             (slot paquete (type INTEGER))
             )
(deftemplate suplementos

             (slot tipo (type SYMBOL) (allowed-symbols urgente peso))
             (slot valor (type INTEGER))
             )

(deftemplate envios
             (slot origen (type SYMBOL))
             (slot destino (type SYMBOL))
             (slot tipo (type SYMBOL) (allowed-symbols carta paquete))
             (slot peso (type NUMBER))
             (slot urgente (type SYMBOL) (allowed-symbols si no))
             )

(deftemplate coste
             (slot valor (type NUMBER))
             )

(deffacts hechos-iniciales
          (tarifas (origen Madrid) (destino Barcelona) (carta 7) (paquete 12))
          (tarifas (origen Madrid) (destino Toledo) (carta 3) (paquete 8))
          (tarifas (origen Madrid) (destino Badajoz) (carta 5) (paquete 10))
          (tarifas (origen Barcelona) (destino Cadiz) (carta 10) (paquete 16))
          (tarifas (origen Barcelona) (destino Gerona) (carta 3) (paquete 8))
          (tarifas (origen Barcelona) (destino Santiago) (carta 8) (paquete 15))
          (suplementos (tipo urgente) (valor 6))
          (suplementos (tipo peso) (valor 1))
          (envios (origen Madrid) (destino Toledo) (tipo paquete) (peso 5) (urgente si))
          )


(defrule calcular-tarifa-basica-carta
         ?e <- (envios (origen ?origen) (destino ?destino) (tipo ?tipo&:(eq ?tipo carta))(urgente ?urgente)(peso
                                                                                                             ?peso) )
         ?t <- (tarifas (origen ?origen) (destino ?destino) (carta ?carta))
         =>
         (assert (coste (valor ?carta)))
         (assert (urgente ?urgente))
         (assert (peso ?peso))
         )

(defrule calcular-tarifa-basica-paquete
         ?e <- (envios (origen ?origen) (destino ?destino) (tipo ?tipo&:(eq ?tipo paquete))(urgente ?urgente)(peso
                                                                                                               ?peso) )
         ?t <- (tarifas (origen ?origen) (destino ?destino) (paquete ?paquete))

         =>

         (assert (coste (valor ?paquete)))
         (assert (urgente ?urgente))
         (assert (peso ?peso))
         )

(defrule calcular-tarifa-suplemento-urgente
         ?c <- (coste (valor ?coste))
         ?u <- (urgente si)
         (suplementos (tipo urgente)(valor ?v))
         =>
         (modify ?c (valor (+ ?coste ?v)))
         (retract ?u)
         )

(defrule calcular-tarifa-suplemento-peso
         ?c <- (coste (valor ?coste))
         ?p <- (peso ?peso)
         (test (> ?peso 2))
         (suplementos (tipo peso)(valor ?v))
         =>
         (modify ?c (valor (+ ?coste (* (/ (- (* ?peso 1000) 2000) 100) ?v))))
         (retract ?p)
         )