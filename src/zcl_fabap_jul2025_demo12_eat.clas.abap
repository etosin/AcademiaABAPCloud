CLASS zcl_fabap_jul2025_demo12_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_DEMO12_EAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " Demonstrating UP casting in ABAP

    out->write( |Upcasting| ).

    DATA(lo_cao) = NEW zcl_fabap_jul2025_demo07_eat( ). " lcl_cao (Filho)

    DATA(lo_cao_casted) = CAST zcl_fabap_jul2025_demo06_eat( lo_cao ). " Upcast

    out->write( |{ lo_cao_casted->reproduzir_som( ) }| ).

    out->write( |--------------------| ).
    out->write( |Downcasting| ).

    " Demonstrating DOWN casting in ABAP
    DATA lo_cao_base     TYPE REF TO zcl_fabap_jul2025_demo06_eat. "lcl_animal_base (Pai)
    DATA lo_cao_derivado TYPE REF TO zcl_fabap_jul2025_demo07_eat. "lcl_cao_derivado (Filho)


    lo_cao_base = NEW zcl_fabap_jul2025_demo07_eat( ). "cao (Filho)
    "IF lo_cao_base IS INSTANCE OF zcl_fabap_jul2025

    TRY.
        lo_cao_derivado = CAST #( lo_cao_base ). " Downcast seguro
        out->write( lo_cao_derivado->reproduzir_som( ) ).
      CATCH cx_sy_move_cast_error.
        out->write( 'Downcast falhou' ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
