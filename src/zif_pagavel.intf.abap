INTERFACE zif_pagavel
  PUBLIC .
  METHODS: calcular_pagamento RETURNING VALUE(rv_valor) TYPE /dmo/total_price.


ENDINTERFACE.
