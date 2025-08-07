CLASS zcl_fabap_jul2025_exer17_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER17_EAT IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA lt_flights  TYPE TABLE OF /dmo/flight.
    DATA lt_bookings TYPE TABLE OF /dmo/booking.

    SELECT * FROM /dmo/flight INTO TABLE @lt_flights.

    SELECT * FROM /dmo/booking
      FOR ALL ENTRIES IN @lt_flights
      WHERE carrier_id    = @lt_flights-carrier_id
        AND connection_id = @lt_flights-connection_id
      INTO TABLE @lt_bookings.

    LOOP AT lt_flights INTO DATA(ls_flight).
      LOOP AT lt_bookings INTO DATA(ls_booking)
           WHERE     carrier_id    = ls_flight-carrier_id
                 AND connection_id = ls_flight-connection_id.
        out->write( |Voo { ls_booking-carrier_id } { ls_booking-connection_id }: { ls_booking-flight_date }| ).
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
