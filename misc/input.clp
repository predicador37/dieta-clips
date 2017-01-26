(deftemplate persona
             (slot nombre (type SYMBOL))
             (multislot apellidos (type SYMBOL))
             (slot edad (type INTEGER) (range 0 99))
             (slot sexo (type SYMBOL) (allowed-symbols masculino femenino))
             (slot peso (type NUMBER) (range 3 150))
             (slot actividad (type SYMBOL) (allowed-symbols reposo ligera moderada intensa))
             (slot objetivo (type SYMBOL) (allowed-symbols mantener reducir))
             )

(deffunction pregunta-validada (?pregunta $?permitidos)
             (printout t ?pregunta)
             (bind ?respuesta (read))
             (if (lexemep ?respuesta)
               then (bind ?respuesta (lowcase ?respuesta)))
             (while (not (member ?respuesta ?permitidos)) do
                    (printout t ?pregunta)
                    (bind ?respuesta (read))
                    (if (lexemep ?respuesta)
                      then (bind ?respuestar (lowcase ?respuesta))))
             ?respuesta)

(defrule entrada-datos

         (initial-fact)

         =>

         (printout t "Nombre?" crlf)
         (assert (e1 (read)))

         (printout t "Apellidos?" crlf)
         (assert (e2 (read)))

         (printout t "Edad?" crlf)
         (assert (e3 (read)))

         (printout t "Peso?" crlf)
         (assert (e4 (read)))

         (assert (e5 (pregunta-validada "Sexo (masculino/femenino)? " masculino femenino)))

         (assert (e6 (pregunta-validada "Actividad (reposo/ligera/moderada/intensa)? " reposo ligera moderada intensa)))

         (assert (e7 (pregunta-validada "Objetivo (mantener/reducir)? " mantener reducir)))


)
(defrule crear-persona
         (e1 ?e1)
         (e2 ?e2)
         (e3 ?e3)
         (e4 ?e4)
         (e5 ?e5)
         (e6 ?e6)
         (e7 ?e7)
         =>
         (assert  (persona (nombre ?e1) (apellidos ?e2) (edad ?e3) (sexo ?e4) (peso ?e5) (actividad ?e6) (objetivo ?e7)))
         )