CLASS zcl_fabap_jul2025_exer15_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER15_EAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_flights     TYPE TABLE OF /dmo/flight,
          lt_connections TYPE TABLE OF /dmo/connection.

    SELECT * FROM /dmo/flight INTO TABLE @lt_flights.

    LOOP AT lt_flights INTO DATA(ls_flight).
      SELECT SINGLE * FROM /dmo/connection
        WHERE carrier_id = @ls_flight-carrier_id
          AND connection_id = @ls_flight-connection_id
          INTO @DATA(ls_connection).

      IF ls_connection-distance > 1000.
        ls_flight-price = ls_flight-price * '1.10'.
        MODIFY lt_flights FROM ls_flight.
        out->write( |Preço atualizado para voo { ls_flight-carrier_id }-{ ls_flight-connection_id }| ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
