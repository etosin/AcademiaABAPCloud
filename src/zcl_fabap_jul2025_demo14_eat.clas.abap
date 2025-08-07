CLASS zcl_fabap_jul2025_demo14_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_DEMO14_EAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " ----------------------------------------------------------------------
    " Tópico: Inline Declarations (ABAP 7.40+)
    " Descrição: Declaração de variáveis diretamente onde são usadas.
    " ----------------------------------------------------------------------

    " Old Version (ABAP 7.40-)
    " DATA lv_carrid TYPE /dmo/carrier_id.
    " lv_carrid = 'AA'.
    " out->write( |Old Version - Carrier ID: { lv_carrid }| ).

    " New Version (ABAP 7.40+)
    DATA(lv_carrid_new) = 'AA'.
    out->write( |New Version - Carrier ID: { lv_carrid_new }| ).

* Old Version (ABAP 7.40-) - LOOP AT INTO
* TYPES: BEGIN OF ty_flight_old,
*          carrid TYPE /dmo/carrier_id,
*          connid TYPE /dmo/connection_id,
*        END OF ty_flight_old.

* DATA: lt_flights_old TYPE STANDARD TABLE OF ty_flight_old WITH EMPTY KEY,
*       ls_flight_old  TYPE ty_flight_old.

*        ls_flight_old-carrid = 'LH'.
*        ls_flight_old-connid = '0400'.
*        append ls_flight_old TO lt_flights_old.

* LOOP AT lt_flights_old INTO ls_flight_old.
*   out->write( |Old Version - Flight: { ls_flight_old-carrid }-{ ls_flight_old-connid }| ).
* ENDLOOP.

    " New Version (ABAP 7.40+) - LOOP AT INTO DATA(wa)
    TYPES: BEGIN OF ty_flight_new,
             carrid TYPE /dmo/carrier_id,
             connid TYPE /dmo/connection_id,
           END OF ty_flight_new.

    DATA lt_flights_new TYPE STANDARD TABLE OF ty_flight_new WITH EMPTY KEY.

    lt_flights_new = VALUE #( ( carrid = 'LH' connid = '0400' ) ).

    LOOP AT lt_flights_new INTO DATA(ls_flight_new).
      out->write( |New Version - Flight: { ls_flight_new-carrid }-{ ls_flight_new-connid }| ).
    ENDLOOP.

* Old Version (ABAP 7.40-) - SELECT INTO TABLE
* DATA: lt_carriers_old TYPE STANDARD TABLE OF /dmo/carrier.

* SELECT * FROM /dmo/carrier INTO TABLE lt_carriers_old UP TO 2 ROWS.

* out->write( |Old Version - Carriers found: { lines( lt_carriers_old ) }| ).

    " New Version (ABAP 7.40+) - SELECT INTO TABLE @DATA(itab)
    SELECT * FROM /dmo/carrier INTO TABLE @DATA(lt_carriers_new) UP TO 2 ROWS.
    out->write( |New Version - Carriers found: { lines( lt_carriers_new ) }| ).

    " ----------------------------------------------------------------------
    " Tópico: Table Expressions (ABAP 7.40+)
    " Descrição: Acesso direto a linhas de tabelas internas.
    " ----------------------------------------------------------------------
    " Old Version (ABAP 7.40-)
    " DATA: ls_carrier_old TYPE /dmo/carrier.

* READ TABLE lt_carriers_new INTO ls_carrier_old INDEX 1.

* IF sy-subrc = 0.
*   out->write( |Old Version - First Carrier: { ls_carrier_old-name }| ).
* ENDIF.

    " New Version (ABAP 7.40+)
    lt_carriers_new = VALUE #( ( carrier_id = 'LH' name = 'Lufthansa' )
                               ( carrier_id = 'AA' name = 'American Airlines' ) ).

    TRY.
        DATA(ls_carrier_expr) = lt_carriers_new[ 1 ].
        out->write( |New Version - First Carrier: { ls_carrier_expr-name }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |New Version - No first carrier found.| ).
    ENDTRY.

* Old Version (ABAP 7.40-) - READ TABLE WITH KEY
* DATA: ls_carrier_key_old TYPE /dmo/carrier.
* READ TABLE lt_carriers_new INTO ls_carrier_key_old WITH KEY carrier_id = 'LH'.
* IF sy-subrc = 0.
*   out->write( |Old Version - Carrier LH: { ls_carrier_key_old-name }| ).
* ENDIF.

    " New Version (ABAP 7.40+) - Table Expression with Key
    TRY.
        DATA(ls_carrier_key_new) = lt_carriers_new[ carrier_id = 'LH' ].
        out->write( |New Version - Carrier LH: { ls_carrier_key_new-name }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |New Version - Carrier LH not found.| ).
    ENDTRY.

    " ----------------------------------------------------------------------
    " Tópico: Conversion Operator CONV (ABAP 7.40+)
    " Descrição: Conversão de tipos de dados de forma concisa.
    " ----------------------------------------------------------------------
    " Old Version (ABAP 7.40-)
    " DATA: lv_char_old TYPE c LENGTH 10 VALUE '12345',
    "       lv_int_old  TYPE i.

* lv_int_old = lv_char_old.
* out->write( |Old Version - Converted to INT: { lv_int_old }| ).

    " New Version (ABAP 7.40+)
    DATA(lv_char_new) = '12345'.
    DATA(lv_int_new) = CONV i( lv_char_new ).
    out->write( |New Version - Converted to INT: { lv_int_new }| ).

    " ----------------------------------------------------------------------
    " Tópico: Value Operator VALUE (ABAP 7.40+)
    " Descrição: Inicialização de estruturas e tabelas internas.
    " ----------------------------------------------------------------------
    " Old Version (ABAP 7.40-)
    " DATA: ls_connection_old TYPE /dmo/connection.

* ls_connection_old-airport_from_id = 'FRA'.
* ls_connection_old-airport_to_id = 'JFK'.

* out->write( |Old Version - Connection: { ls_connection_old-airport_from_id }-{ ls_connection_old-airport_to_id }| ).

    " New Version (ABAP 7.40+)
    DATA(ls_connection_value) = VALUE /dmo/connection( airport_from_id = 'FRA'
                                                       airport_to_id   = 'JFK' ).

    out->write(
        |New Version - Connection: { ls_connection_value-airport_from_id }-{ ls_connection_value-airport_to_id }| ).

* Old Version (ABAP 7.40-) - Internal Table
* DATA: lt_flights_value_old TYPE STANDARD TABLE OF ty_flight_new.

* APPEND INITIAL LINE TO lt_flights_value_old ASSIGNING FIELD-SYMBOL(<fs_flight>).
* <fs_flight>-carrid = 'UA'.
* <fs_flight>-connid = '0001'.

* out->write( |Old Version - Flights count: { lines( lt_flights_value_old ) }| ).

    " New Version (ABAP 7.40+) - Internal Table
    TYPES: BEGIN OF ty_flight_new_s,
             carrid TYPE /dmo/carrier_id,
             connid TYPE /dmo/connection_id,
           END OF ty_flight_new_s.

    TYPES ty_flight_new_tt TYPE STANDARD TABLE OF ty_flight_new_s WITH EMPTY KEY.

    DATA(lt_flights_value_new) = VALUE ty_flight_new_tt( ( carrid = 'UA' connid = '0001' )
                                                         ( carrid = 'DL' connid = '0002' ) ).

    out->write( |New Version - Flights count: { lines( lt_flights_value_new ) }| ).

    " ----------------------------------------------------------------------
    " Tópico: FOR operator (ABAP 7.50+)
    " Descrição: Criação de tabelas internas de forma funcional.
    " ----------------------------------------------------------------------
    " Old Version (ABAP 7.50-)
    " DATA: lt_flights_for_old TYPE STANDARD TABLE OF ty_flight_new.

* LOOP AT lt_flights_value_new INTO ls_flight_new WHERE carrid = 'UA'.
*   APPEND ls_flight_new TO lt_flights_for_old.
* ENDLOOP.

* out->write( |Old Version - Flights for UA: { lines( lt_flights_for_old ) }| ).

    " New Version (ABAP 7.50+)
    DATA(lt_flights_for_new) =
      VALUE ty_flight_new_tt( FOR ls_flight_new2 IN lt_flights_value_new WHERE ( carrid = 'UA' )

                              ( carrid = ls_flight_new2-carrid connid = ls_flight_new2-connid ) ).

    out->write( |New Version - Flights for UA: { lines( lt_flights_for_new ) }| ).

    " ----------------------------------------------------------------------
    " Tópico: Reduction operator REDUCE (ABAP 7.50+)
    " Descrição: Redução de tabelas internas a um único valor.
    " ----------------------------------------------------------------------
    " Old Version (ABAP 7.50-)
    " DATA: lv_sum_old TYPE i VALUE 0.
    " DATA: lt_numbers TYPE STANDARD TABLE OF i WITH EMPTY KEY.

* append 1 TO lt_numbers.
* append 2 TO lt_numbers.
* append 3 TO lt_numbers.

* LOOP AT lt_numbers INTO DATA(lv_number).
*   lv_sum_old = lv_sum_old + lv_number.
*   COLLECT lv_number INTO lt_numbers.
* ENDLOOP.

* out->write( |Old Version - Sum: { lv_sum_old }| ).

    " New Version (ABAP 7.50+)
    TYPES ty_number TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    DATA(lt_numbers_reduce) = VALUE ty_number( ( 1 ) ( 2 ) ( 3 ) ).
    DATA(lv_sum_new) = REDUCE i( INIT s = 0 FOR n IN lt_numbers_reduce NEXT s = s + n ).
    out->write( |New Version - Sum: { lv_sum_new }| ).

    " ----------------------------------------------------------------------
    " Tópico: Conditional operators COND and SWITCH (ABAP 7.40+)
    " Descrição: Expressões condicionais concisas.
    " ----------------------------------------------------------------------
    " Old Version (ABAP 7.40-)
    " DATA: lv_status_old TYPE string.
    " DATA: lv_code TYPE i VALUE 1.

* IF lv_code = 1.
*   lv_status_old = 'Success'.
* ELSEIF lv_code = 2.
*   lv_status_old = 'Warning'.
* ELSE.

*   lv_status_old = 'Error'.
* ENDIF.

* out->write( |Old Version - Status: { lv_status_old }| ).

*CASE lv_code.
*WHEN 1. lv_status_old = 'Success'.
*WHEN 2. lv_status_old = 'Warning'.
*WHEN OTHERS lv_status_old = 'Error'.
*ENDCASE.

* out->write( |Old Version - Status (CASE): { lv_status_old }| ).

    " New Version (ABAP 7.40+) - COND
    DATA(lv_code_cond) = 1.
    DATA(lv_status_cond) = COND string(
      WHEN lv_code_cond = 1 THEN 'Success'
      WHEN lv_code_cond = 2 THEN 'Warning'
      ELSE                       'Error' ).

    out->write( |New Version - Status (COND): { lv_status_cond }| ).

    " New Version (ABAP 7.40+) - SWITCH
    DATA(lv_code_switch) = 2.
    DATA(lv_status_switch) = SWITCH string( lv_code_switch
                                            WHEN 1 THEN 'Success'
                                            WHEN 2 THEN 'Warning'
                                            ELSE        'Error' ).

    out->write( |New Version - Status (SWITCH): { lv_status_switch }| ).

    " ----------------------------------------------------------------------
    " Tópico: CORRESPONDING operator (ABAP 7.40+)
    " Descrição: Atribuição de campos com o mesmo nome entre estruturas/tabelas.
    " ----------------------------------------------------------------------
    " Old Version (ABAP 7.40-)
    " TYPES: BEGIN OF ty_s1_old,
    "          field1 TYPE string,
    "          field2 TYPE string,
    "        END OF ty_s1_old.

* TYPES: BEGIN OF ty_s2_old,
*          field1 TYPE string,
*          field3 TYPE string,
*        END OF ty_s2_old.

* DATA: ls_s1_old TYPE ty_s1_old,
*       ls_s2_old TYPE ty_s2_old.

* ls_s1_old-field1 = 'Value1'.
* ls_s1_old-field2 = 'Value2'.
* ls_s2_old-field1 = ls_s1_old-field1.

* out->write( |Old Version - S2 Field1: { ls_s2_old-field1 }| ).

    " New Version (ABAP 7.40+)
    TYPES: BEGIN OF ty_s1_new,
             field1 TYPE string,
             field2 TYPE string,
           END OF ty_s1_new.

    TYPES: BEGIN OF ty_s2_new,
             field1 TYPE string,
             field3 TYPE string,
           END OF ty_s2_new.

    DATA ls_s1_new TYPE ty_s1_new.

    ls_s1_new-field1 = 'Value1'.
    ls_s1_new-field2 = 'Value2'.

    DATA(ls_s2_new) = CORRESPONDING ty_s2_new( ls_s1_new ).

    out->write( |New Version - S2 Field1: { ls_s2_new-field1 }| ).

* ----------------------------------------------------------------------
* Tópico: Loop at Group By (ABAP 7.50+)
* Descrição: Agrupamento de dados em loops de tabelas internas.
* ----------------------------------------------------------------------
* Old Version (ABAP 7.50-)
* TYPES: BEGIN OF ty_flight_group_old,
*          carrid TYPE /dmo/carrier_id,
*          connid TYPE /dmo/connection_id,
*          price  TYPE /dmo/flight_price,
*        END OF ty_flight_group_old.

* DATA: lt_flights_group_old TYPE STANDARD TABLE OF ty_flight_group_old WITH EMPTY KEY.

* APPEND INITIAL LINE TO lt_flights_group_old ASSIGNING FIELD-SYMBOL(<fs_flight_group>).
* <fs_flight_group>-carrid = 'LH'.
* <fs_flight_group>-connid = '0400'.
* <fs_flight_group>-price = '100'.

* DATA: lv_current_carrid TYPE /dmo/carrier_id.
* DATA: lv_total_price TYPE /dmo/flight_price.

* LOOP AT lt_flights_group_old INTO DATA(ls_flight_group_old).
*   IF ls_flight_group_old-carrid <> lv_current_carrid.
*     IF lv_current_carrid IS NOT INITIAL.
*       out->write( |Old Version - Carrier { lv_current_carrid } Total Price: { lv_total_price }| ).
*     ENDIF.
*     lv_current_carrid = ls_flight_group_old-carrid.
*     lv_total_price = 0.
*   ENDIF.
*   lv_total_price = lv_total_price + ls_flight_group_old-price.
* ENDLOOP.

* IF lv_current_carrid IS NOT INITIAL.
*   out->write( |Old Version - Carrier { lv_current_carrid } Total Price: { lv_total_price }| ).
* ENDIF.

    " New Version (ABAP 7.50+)
    TYPES: BEGIN OF ty_flight_group_new,
             carrid TYPE /dmo/carrier_id,
             connid TYPE /dmo/connection_id,
             price  TYPE /dmo/flight_price,
           END OF ty_flight_group_new.

    TYPES ty_flights_group_new_t TYPE STANDARD TABLE OF ty_flight_group_new WITH EMPTY KEY.

    DATA(lt_flights_group_new) = VALUE ty_flights_group_new_t( ( carrid = 'LH' connid = '0400' price = '100' )
                                                               ( carrid = 'LH' connid = '0401' price = '150' )
                                                               ( carrid = 'UA' connid = '0001' price = '200' ) ).

    LOOP AT lt_flights_group_new INTO DATA(ls_flight_group_new)
         GROUP BY ls_flight_group_new-carrid.
      DATA(lv_total_price_group)
       = REDUCE /dmo/flight_price( INIT s = 0 FOR member IN GROUP ls_flight_group_new NEXT s = s + member-price ).
      out->write( |New Version - Carrier { ls_flight_group_new-carrid } Total Price: { lv_total_price_group }| ).
    ENDLOOP.

* ----------------------------------------------------------------------
* Tópico: Strings (ABAP 7.40+)
* Descrição: Novas funcionalidades para manipulação de strings, como o operador de encadeamento, templates de string e expressões embutidas.
* ----------------------------------------------------------------------
* Old Version (ABAP 7.40-)
* DATA: lv_var1_old TYPE string VALUE 'Hello',
*       lv_var2_old TYPE string VALUE 'World',
*       lv_result_old TYPE string.
* CONCATENATE lv_var1_old lv_var2_old INTO lv_result_old SEPARATED BY space.
* out->write( |Old Version - Concatenation: { lv_result_old }| ).

* New Version (ABAP 7.40+) - Chaining Operator
    DATA(lv_var1_new) = 'Hello'.
    DATA(lv_var2_new) = 'World'.
    DATA(lv_result_new) = lv_var1_new && ' ' && lv_var2_new.
    out->write( |New Version - Chaining Operator: { lv_result_new }| ).

* New Version (ABAP 7.40+) - String Templates
    DATA(lv_name) = 'ABAP'.
    DATA(lv_version) = '7.40'.
    DATA(lv_template_string) = |Welcome to { lv_name } { lv_version }!|.
    out->write( |New Version - String Template: { lv_template_string }| ).

* New Version (ABAP 7.40+) - Embedded Expressions (ALPHA conversion)
    DATA(lv_delivery_number) = '0080003371'.
    DATA(lv_formatted_delivery) = |{ lv_delivery_number ALPHA = OUT }|.
    out->write( |New Version - Embedded Expression (ALPHA): { lv_formatted_delivery }| ).

* ----------------------------------------------------------------------
* Tópico: Classes/Methods (ABAP 7.40+)
* Descrição: Novas formas de chamar métodos e criar objetos.
* ----------------------------------------------------------------------
* Old Version (ABAP 7.40-)
* CLASS lcl_calculator_old DEFINITION.
*   PUBLIC SECTION.
*     METHODS add IMPORTING iv_num1 TYPE i iv_num2 TYPE i RETURNING VALUE(rv_result) TYPE i.
* ENDCLASS.

* CLASS lcl_calculator_old IMPLEMENTATION.
*   METHOD add.
*     rv_result = iv_num1 + iv_num2.
*   ENDMETHOD.
* ENDCLASS.

* DATA: lo_calc_old TYPE REF TO lcl_calculator_old.

* CREATE OBJECT lo_calc_old.

* DATA: lv_result_old TYPE i.

* CALL METHOD lo_calc_old->add EXPORTING iv_num1 = 10 iv_num2 = 20 RECEIVING rv_result = lv_result_old.

* out->write( |Old Version - Sum: { lv_result_old }| ).

* New Version (ABAP 7.40+)
*   CLASS lcl_calculator_new DEFINITION.
*     PUBLIC SECTION.
*       METHODS add IMPORTING iv_num1 TYPE i iv_num2 TYPE i RETURNING VALUE(rv_result) TYPE i.
*   ENDCLASS.

*   CLASS lcl_calculator_new IMPLEMENTATION.
*     METHOD add.
*       rv_result = iv_num1 + iv_num2.
*     ENDMETHOD.
*   ENDCLASS.

*   DATA(lv_result_new) = NEW lcl_calculator_new( )->add( iv_num1 = 10 iv_num2 = 20 ).

*   out->write( |New Version - Sum: { lv_result_new }| ).

* ----------------------------------------------------------------------
* Tópico: Filter (ABAP 7.40+)
* Descrição: Filtragem de tabelas internas de forma concisa.
* ----------------------------------------------------------------------
* Old Version (ABAP 7.40-)
* DATA: lt_flights_filter_old TYPE STANDARD TABLE OF ty_flight_new.

* LOOP AT lt_flights_value_new INTO ls_flight_new WHERE carrid = 'LH'.
*   APPEND ls_flight_new TO lt_flights_filter_old.
* ENDLOOP.

* out->write( |Old Version - Filtered flights (LH): { lines( lt_flights_filter_old ) }| ).

* New Version (ABAP 7.40+)
    DATA lt_flights_new2 TYPE SORTED TABLE OF ty_flight_new WITH UNIQUE KEY carrid connid.

    DATA(lt_flights_filter_new) = FILTER #( lt_flights_new2 WHERE carrid = CONV #( 'AA' ) ).

    out->write( |New Version - Filtered flights (LH): { lines( lt_flights_filter_new ) }| ).

  ENDMETHOD.
ENDCLASS.
