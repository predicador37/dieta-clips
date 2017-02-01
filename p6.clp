(defrule acuatico

         (init-fact)

         =>

         (printout t "Es acuatico (si/no)" crlf)
         (read ?acuatico)
         (assert (acuatico ?acuatico))

         )

(defrule mamifero
         (acuatico ?acuatico&:(eq ?acuatico si))
         =>
         (printout t "Es mamifero (si/no)" crlf)
         (read ?mamifero)
         (if (eq ?mamifero si)
           then
           (printout t "El animal es una ballena" crlf)
           else
           (printout t "El animal es un tiburon" crlf)

           )

         )
(defrule terrestre
         (acuatico ?acuatico&:(eq ?acuatico no))

         =>

         (printout t "Es terrestre (si/no)" crlf)
         (read ?terrestre)
         (if (eq ?terrestre no)
           then
           (printout t "El animal es una paloma" crlf)

           else
           (assert (terrestre ?terrestre))
           )
         )

(defrule grande
         (terrestre ?terrestre&:(eq ?terrestre si))

         =>

         (printout t "Es grande (si/no)" crlf)
         (read ?grande)
         (assert (grande ?grande))
         )

(defrule trompa
         (grande ?grande&:(eq ?grande si))
         =>
         (printout t "Tiene trompa (si/no)" crlf)
         (read ?trompa)
         (if (eq ?trompa si)
           then
           (printout t "El animal es un elefante" crlf)
           else
           (printout t "El animal es un rinoceronte" crlf)

           )

         )

(defrule roedor
         (grande ?grande&:(eq ?grande no))
         =>
         (printout t "Es roedor (si/no)" crlf)
         (read ?roedor)
         (if (eq ?roedor si)
           then
           (printout t "El animal es un raton" crlf)
           else
           (printout t "El animal es un gato" crlf)

           )

         )


