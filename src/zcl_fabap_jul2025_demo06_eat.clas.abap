CLASS zcl_fabap_jul2025_demo06_eat DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS reproduzir_som RETURNING VALUE(rv_voice) TYPE string.


  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS se_alimenta_de
      IMPORTING VALUE(iv_comida) TYPE string
      RETURNING VALUE(rv_comida) TYPE string.

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_DEMO06_EAT IMPLEMENTATION.


  METHOD reproduzir_som.

    rv_voice = |{ 'Som não atribuido' }|.
  ENDMETHOD.


  METHOD se_alimenta_de.
    rv_comida = | 'A comida dele é' { iv_comida }|.
  ENDMETHOD.
ENDCLASS.
