CLASS zcl_fabap_jul2025_exer11_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER11_EAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lt_funcionarios TYPE TABLE OF REF TO zcl_fabap_jul2025_exer08_eat.

    DATA(lo_integral) = NEW zcl_fabap_jul2025_exer09_eat(
      iv_nome = 'João Silva'
      iv_id = 'F001'
      iv_salario_base = '5000.00'
      iv_bonus = '1000.00' ).

    DATA(lo_horista) = NEW zcl_fabap_jul2025_exer10_eat(
      iv_nome = 'Maria Santos'
      iv_id = 'F002'
      iv_salario_base = '50.00'
      iv_horas = 160 ).

    APPEND lo_integral TO lt_funcionarios.
    APPEND lo_horista TO lt_funcionarios.

    LOOP AT lt_funcionarios INTO DATA(lo_funcionario).
      out->write( lo_funcionario->exibir_dados( ) ).
      out->write( |Salário calculado: { lo_funcionario->calcular_salario( ) }| ).
      out->write( '-----------------------------' ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
