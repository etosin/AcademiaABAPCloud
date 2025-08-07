CLASS zcl_fabap_jul2025_demo10_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_pagavel .

    METHODS: constructor IMPORTING iv_valor TYPE /dmo/total_price.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mv_valor TYPE /dmo/total_price.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_DEMO10_EAT IMPLEMENTATION.


  METHOD constructor.

    mv_valor = iv_valor.

  ENDMETHOD.


  METHOD zif_pagavel~calcular_pagamento.

    rv_valor = mv_valor + ( mv_valor * 10 / 100 ). "10% de taxa de serviço

  ENDMETHOD.
ENDCLASS.
