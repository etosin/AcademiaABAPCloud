CLASS zcl_fabap_jul2025_demo11_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_DEMO11_EAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_fatura) = NEW zcl_fabap_jul2025_demo10_eat( iv_valor = 1000 ).

    out->write( |Fatura: { lo_fatura->zif_pagavel~calcular_pagamento( ) }| ).

  ENDMETHOD.
ENDCLASS.
