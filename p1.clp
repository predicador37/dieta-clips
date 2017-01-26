(deffacts hechos-iniciales

  (esun elefante-asiatico elefante)
  (tieneparte elefante cabeza)
  (tieneparte elefante trompa)
  (tieneparte cabeza boca)
  (esun elefante animal)
  (tieneparte animal corazon)
  (esun elefante_asiatico animal-carga)
  (tieneparte animal-carga carga)
  (esun carga aditamento)
  )

(defrule elefante-esun-animal

  (esun ?e elefante)
  (esun elefante ?a)
  =>

  (assert (esun ?e ?a))
  )

(defrule elefante-tiene-corazon

  (esun ?e ?f)
  (esun ?f ?a)
  (tieneparte ?a ?c)
  =>

  (assert (tieneparte ?e ?c))
  )
(defrule elefante-tiene-boca
         (esun ?e ?f)
         (tieneparte ?f ?c)
         (tieneparte ?c ?b)

         =>

         (assert (tieneparte ?e ?b))
         )
(defrule elefante-tiene-trompa
         (esun ?e ?f)
         (tieneparte ?f ?c)

         =>

         (assert (tieneparte ?e ?c))
         )


(defrule animal-carga-tiene-aditamento

         (esun ?e ?ac)
         (tieneparte ?ac ?c)
         (esun ?c ?ad)
         =>
         (assert (tieneparte ?e ?ad))
         )