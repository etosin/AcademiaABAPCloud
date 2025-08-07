CLASS zcl_fabap_jul2025_exer14_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER14_EAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* ----------------------------------------------------------------------
* Tópico: Inline Declarations (ABAP 7.40+)
* Descrição: Declaração de variáveis diretamente onde são usadas.
* ----------------------------------------------------------------------
    DATA(lv_carrid_new) = 'AA'.
    out->write( |New Version - Carrier ID: { lv_carrid_new }| ).

    TYPES: BEGIN OF ty_flight_new,
             carrid      TYPE /dmo/carrier_id,
             connid      TYPE /dmo/connection_id,
             flight_date TYPE /dmo/flight_date,
           END OF ty_flight_new.

    DATA: lt_flights_new TYPE STANDARD TABLE OF ty_flight_new WITH EMPTY KEY.

    lt_flights_new = VALUE #( ( carrid = 'LH' connid = '0400' flight_date = '20250725' ) ).

    LOOP AT lt_flights_new INTO DATA(ls_flight_new).
      out->write( |New Version - Flight: { ls_flight_new-carrid }-{ ls_flight_new-connid }| ).
    ENDLOOP.

    SELECT * FROM /dmo/flight INTO TABLE @DATA(lt_flights_select_new) UP TO 2 ROWS.

    out->write( |New Version - Flights found (SELECT): { lines( lt_flights_select_new ) }| ).

* ----------------------------------------------------------------------
* Tópico: Table Expressions (ABAP 7.40+)
* Descrição: Acesso direto a linhas de tabelas internas.
* ----------------------------------------------------------------------
    TRY.
        DATA(ls_flight_expr_new) = lt_flights_new[ 1 ].
        out->write( |New Version - First Flight: { ls_flight_expr_new-carrid }-{ ls_flight_expr_new-connid }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |New Version - No first flight found.| ).
    ENDTRY.

    TRY.
        DATA(ls_flight_key_new) = lt_flights_new[ carrid = 'LH' connid = '0400' ].
        out->write( |New Version - Flight LH-0400: { ls_flight_key_new-carrid }-{ ls_flight_key_new-connid }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |New Version - Flight LH-0400 not found.| ).
    ENDTRY.

* ----------------------------------------------------------------------
* Tópico: Conversion Operator CONV (ABAP 7.40+)
* Descrição: Conversão de tipos de dados de forma concisa.
* ----------------------------------------------------------------------
    DATA(lv_char_new) = '12345'.

    DATA(lv_int_new) = CONV i( lv_char_new ).

    out->write( |New Version - Converted to INT: { lv_int_new }| ).

* ----------------------------------------------------------------------
* Tópico: Value Operator VALUE (ABAP 7.40+)
* Descrição: Inicialização de estruturas e tabelas internas.
* ----------------------------------------------------------------------
    TYPES ty_flight_new_tt TYPE STANDARD TABLE OF ty_flight_new WITH EMPTY KEY.

    DATA(ls_connection_value) = VALUE /dmo/connection(
      airport_from_id = 'FRA'
      airport_to_id   = 'JFK'
    ).

    out->write( |New Version - Connection: { ls_connection_value-airport_from_id }-{ ls_connection_value-airport_to_id }| ).

    DATA(lt_flights_value_new) = VALUE ty_flight_new_tt(
      ( carrid = 'UA' connid = '0001' flight_date = '20250725' )
      ( carrid = 'DL' connid = '0002' flight_date = '20250726' )
    ).

    out->write( |New Version - Flights count (VALUE): { lines( lt_flights_value_new ) }| ).

* ----------------------------------------------------------------------
* Tópico: FOR operator (ABAP 7.50+)
* Descrição: Criação de tabelas internas de forma funcional.
* ----------------------------------------------------------------------
    DATA(lt_flights_for_new) =
     VALUE ty_flight_new_tt( FOR ls_flight_new2 IN lt_flights_value_new WHERE ( carrid = 'UA' )

                             ( carrid = ls_flight_new2-carrid connid = ls_flight_new2-connid ) ).

    out->write( |New Version - Flights for UA (FOR): { lines( lt_flights_for_new ) }| ).

* ----------------------------------------------------------------------
* Tópico: Reduction operator REDUCE (ABAP 7.50+)
* Descrição: Redução de tabelas internas a um único valor.
* ----------------------------------------------------------------------
    TYPES ty_number TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    DATA(lt_numbers_reduce) = VALUE ty_number( ( 1 ) ( 2 ) ( 3 ) ).

    DATA(lv_sum_new) = REDUCE i( INIT s = 0 FOR n IN lt_numbers_reduce NEXT s = s + n ).

    out->write( |New Version - Sum: { lv_sum_new }| ).

* ----------------------------------------------------------------------
* Tópico: Conditional operators COND and SWITCH (ABAP 7.40+)
* Descrição: Expressões condicionais concisas.
* ----------------------------------------------------------------------
    DATA(lv_code_cond) = 1.
    DATA(lv_status_cond) = COND string(
      WHEN lv_code_cond = 1 THEN 'Success'
      WHEN lv_code_cond = 2 THEN 'Warning'
      ELSE 'Error'
    ).
    out->write( |New Version - Status (COND): { lv_status_cond }| ).

    DATA(lv_code_switch) = 2.
    DATA(lv_status_switch) = SWITCH string( lv_code_switch
      WHEN 1 THEN 'Success'
      WHEN 2 THEN 'Warning'
      ELSE 'Error'
    ).
    out->write( |New Version - Status (SWITCH): { lv_status_switch }| ).

* ----------------------------------------------------------------------
* Tópico: CORRESPONDING operator (ABAP 7.40+)
* Descrição: Atribuição de campos com o mesmo nome entre estruturas/tabelas.
* ----------------------------------------------------------------------
    TYPES: BEGIN OF ty_s1_new,
             field1 TYPE string,
             field2 TYPE string,
           END OF ty_s1_new.

    TYPES: BEGIN OF ty_s2_new,
             field1 TYPE string,
             field3 TYPE string,
           END OF ty_s2_new.

    DATA: ls_s1_corr_new TYPE ty_s1_new.

    ls_s1_corr_new-field1 = 'Value1'.
    ls_s1_corr_new-field2 = 'Value2'.

    DATA(ls_s2_corr_new) = CORRESPONDING ty_s2_new( ls_s1_corr_new ).

    out->write( |New Version - S2 Field1 (CORRESPONDING): { ls_s2_corr_new-field1 }| ).

* ----------------------------------------------------------------------
* Tópico: Strings (ABAP 7.40+)
* Descrição: Novas funcionalidades para manipulação de strings, como o operador de encadeamento, templates de string e expressões embutidas.
* ----------------------------------------------------------------------
    DATA(lv_var1_str_new) = 'Hello'.
    DATA(lv_var2_str_new) = 'World'.
    DATA(lv_result_str_new) = lv_var1_str_new && ' ' && lv_var2_str_new.
    out->write( |New Version - Chaining Operator (Strings): { lv_result_str_new }| ).

    DATA(lv_name_str) = 'ABAP'.
    DATA(lv_version_str) = '7.40'.
    DATA(lv_template_string) = |Welcome to { lv_name_str } { lv_version_str }!|.
    out->write( |New Version - String Template (Strings): { lv_template_string }| ).

    DATA(lv_delivery_number) = '0080003371'.
    DATA(lv_formatted_delivery) = |{ lv_delivery_number ALPHA = OUT }|.
    out->write( |New Version - Embedded Expression (ALPHA) (Strings): { lv_formatted_delivery }| ).

* ----------------------------------------------------------------------
* Tópico: Loop at Group By (ABAP 7.50+)
* Descrição: Agrupamento de dados em loops de tabelas internas.
* ----------------------------------------------------------------------
    TYPES: BEGIN OF ty_flight_group_new,
             carrid TYPE /dmo/carrier_id,
             connid TYPE /dmo/connection_id,
             price  TYPE /dmo/flight_price,
           END OF ty_flight_group_new.

    DATA: lt_flights_group_new TYPE STANDARD TABLE OF ty_flight_group_new WITH EMPTY KEY.

    lt_flights_group_new = VALUE #( ( carrid = 'LH' connid = '0400' price = '100' )
                                    ( carrid = 'LH' connid = '0401' price = '150' )
                                    ( carrid = 'UA' connid = '0001' price = '200' ) ).

    LOOP AT lt_flights_group_new INTO DATA(ls_flight_group_new) GROUP BY ls_flight_group_new-carrid.
      DATA(lv_total_price_group) = REDUCE /dmo/flight_price( INIT s = 0 FOR member IN GROUP ls_flight_group_new NEXT s = s + member-price ).
      out->write( |New Version - Carrier { ls_flight_group_new-carrid } Total Price (Group By): { lv_total_price_group }| ).
    ENDLOOP.

* ----------------------------------------------------------------------
* Tópico: Filter (ABAP 7.40+)
* Descrição: Filtragem de tabelas internas de forma concisa.
* ----------------------------------------------------------------------
    DATA lt_flights_new2 TYPE SORTED TABLE OF ty_flight_new WITH UNIQUE KEY carrid connid.

    DATA(lt_flights_filter_new) = FILTER #( lt_flights_new2 WHERE carrid = CONV #( 'AA' ) ).

    out->write( |New Version - Filtered flights (LH): { lines( lt_flights_filter_new ) }| ).

  ENDMETHOD.
ENDCLASS.
