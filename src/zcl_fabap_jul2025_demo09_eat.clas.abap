CLASS zcl_fabap_jul2025_demo09_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_DEMO09_EAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Polimorfismo
    DATA: lt_animais TYPE TABLE OF REF TO zcl_fabap_jul2025_demo06_eat. "animal

    APPEND NEW zcl_fabap_jul2025_demo07_eat( ) TO lt_animais. "Cão
    APPEND NEW zcl_fabap_jul2025_demo08_eat( ) TO lt_animais. "Gato

    LOOP AT lt_animais INTO DATA(lo_animal).

      out->write( lo_animal->reproduzir_som( ) ).

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
