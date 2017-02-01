(deftemplate formula
             (slot id (type SYMBOL))
             (slot tipo (type SYMBOL))
             (multislot hijos)
             )

(deffacts formula-2
          (formula (id 1) (tipo equivalencia (hijos 2 3)))
          (formula (id 2) (tipo disyuncion) (hijos 4 5))
          (formula (id 3) (tipo negacion)(hijos 6))
          (formula (id 4) (tipo negacion)(hijos 7))
          (formula (id 5) (tipo negacion)(hijos 8))
          (formula (id 6) (tipo conjuncion) (hijos 9 10))
          (formula (id 7) (tipo q) (hijos))
          (formula (id 8) (tipo r) (hijos))
          (formula (id 9) (tipo q) (hijos))
          (formula (id 10) (tipo r) (hijos))

          )

(defrule regla-1
         ?f <- (formula (tipo equivalencia) (hijos ?x ?y))

         =>

         (bind ?id1 (gensym))
         (bind ?id2 (gensym))
         (bind ?id3 (gensym))

         (assert (formula (id ?id1) (tipo implicacion) (hijos ?x ?y)))
         (assert (formula (id ?id2) (tipo implicacion) (hijos ?y ?x)))
         (assert (formula (id ?id3) (tipo conjuncion) (hijos ?id1 ?id2)))

         (retract ?f )

         )

(defrule regla-2
         ?f <- (formula (tipo implicacion) (hijos ?x ?y))

         =>

         (bind ?id1 (gensym))
         (bind ?id2 (gensym))

         (assert (formula (id ?id1) (tipo negacion) (hijos ?x)))
         (assert (formula (id ?id2) (tipo disyuncion) (hijos ?id1 ?y)))

         (retract ?f )

         )

(defrule regla-3
         ?f <- (formula (tipo negacion) (hijos ?formula-interior))
         ?fi <-(formula (id ?formula-interior)(tipo conjuncion)(hijos ?x ?y))

         =>

         (bind ?id1 (gensym))
         (bind ?id2 (gensym))

         (assert (formula (id ?id1) (tipo negacion) (hijos ?x)))
         (assert (formula (id ?id2) (tipo negacion) (hijos ?y)))
         (assert (formula (id ?id3) (tipo disyuncion) (hijos ?id1 ?id2)))

         (retract ?f)
         (retract ?fi)

         )

(defrule regla-4
         ?f <- (formula (tipo negacion) (hijos ?formula-interior))
         ?fi <-(formula (id ?formula-interior)(tipo disyuncion)(hijos ?x ?y))

         =>

         (bind ?id1 (gensym))
         (bind ?id2 (gensym))

         (assert (formula (id ?id1) (tipo negacion) (hijos ?x)))
         (assert (formula (id ?id2) (tipo negacion) (hijos ?y)))
         (assert (formula (id ?id3) (tipo conjuncion) (hijos ?id1 ?id2)))

         (retract ?f)
         (retract ?fi)

         )

(defrule regla-5
         ?f <- (formula (tipo negacion) (hijos ?formula-interior))
         ?fi <-(formula (id ?formula-interior)(tipo negacion)(hijos ?x))

         =>

         (retract ?f)
         (retract ?fi)

         )