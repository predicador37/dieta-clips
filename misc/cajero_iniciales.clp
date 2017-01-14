;;; Plantillas
(deftemplate nodo
             (slot bill-100 (type INTEGER) (default 0))
             (slot bill-50 (type INTEGER) (default 0))
             (slot bill-20 (type INTEGER) (default 0))
             (slot bill-10 (type INTEGER) (default 0))
             (slot num-bill (type INTEGER) (default 0))
             (slot importe-bill (type INTEGER) (default 0))
             (slot estado (type SYMBOL) (allowed-values cerrado abierto) (default abierto))
             )
(deftemplate cajero
             (slot bill-100 (type INTEGER) (default 1))
             (slot bill-50 (type INTEGER) (default 2))
             (slot bill-20 (type INTEGER) (default 5))
             (slot bill-10 (type INTEGER) (default 10))
             )
(deffacts iniciales
          (cajero)
          (inicio)
          )