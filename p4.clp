(deffacts hechos-iniciales
          (hombre miguel)
          (hombre juan)
          (hombre jose)
          (hombre jesus)
          (padre-de jose miguel)
          (padre-de jose juan)
          (hombre pedro)
          (mujer ana)
          (mujer clara)
          (madre-de clara pedro)
          (madre-de clara ana)
          (hombre pablo)
          (hombre luis)
          (hombre francisco)
          (mujer julia)
          (padre-de francisco pablo)
          (padre-de francisco luis)
          (madre-de julia pablo)
          (madre-de julia luis)
          (hombre julian)
          (hombre leonardo)
          (padre-de julian julia)
          (padre-de julian leonardo)
          (hombre alberto)
          (padre-de alberto jose)
          (padre-de alberto jesus)
          (hombre david)
          (padre-de jesus david)
          (hombre sergio)
          (padre-de leonardo sergio)

          )


(defrule hermano
         (or
           (and
                  (padre-de ?hombre ?persona1)
                  (padre-de ?hombre ?persona2&:(not(eq ?persona1 ?persona2)))
                  (hombre ?persona1)

                )
           (and
                  (madre-de ?mujer ?persona1)
                  (madre-de ?mujer ?persona2&:(not(eq ?persona1 ?persona2)))
                  (hombre ?persona1)
                 )
           )
         =>
         (assert (hermano ?persona1 ?persona2))

         )

(defrule abuelo
         (or (and
               (padre-de ?hombre ?persona)
               (padre-de ?abuelo ?hombre)
               (hombre ?abuelo)
               )
             (and
               (madre-de ?mujer ?persona)
               (padre-de ?abuelo ?mujer)
               (hombre ?abuelo)
               )
             )
         =>

         (assert (abuelo ?abuelo ?persona))

         )

(defrule tio
         (or
           (and
             (padre-de ?padre ?persona)
             (padre-de ?abuelo ?padre)
             (padre-de ?abuelo ?tio&:(not(eq ?tio ?padre)))
             (hombre ?tio)

             )
           (and
             (madre-de ?madre ?persona)
             (padre-de ?abuelo ?madre)
             (padre-de ?abuelo ?tio)
             (hombre ?tio)
             )
           )
         =>

         (assert (tio ?tio ?persona))

         )

(defrule primo
         (or
           (and
             (padre-de ?padre ?persona)
             (padre-de ?abuelo ?padre)
             (padre-de ?abuelo ?tio&:(not(eq ?tio ?padre)))
             (hombre ?tio)
             (padre-de ?tio ?primo)
             (hombre ?primo)

             )
           (and
             (madre-de ?madre ?persona)
             (padre-de ?abuelo ?madre)
             (padre-de ?abuelo ?tio)
             (hombre ?tio)
             (padre-de ?tio ?primo)
             (hombre ?primo)
             )
           )
         =>

         (assert (primo ?primo ?persona))

         )

(defrule print-results-hermano
         (declare (salience -1))
         (hermano ?persona1 ?persona2)

         =>
         (printout t ?persona1 " es hermano de " ?persona2 crlf)

         )

(defrule print-results-abuelo
         (declare (salience -2))

         (abuelo ?abuelo ?persona)
         =>

         (printout t ?abuelo " es abuelo de " ?persona crlf)
         )

(defrule print-results-tio
         (declare (salience -3))

         (tio ?tio ?persona)
         =>

         (printout t ?tio " es tio de " ?persona crlf)
         )

(defrule print-results-primo
         (declare (salience -4))

         (primo ?primo ?persona)
         =>

         (printout t ?primo " es primo de " ?persona crlf)
         )