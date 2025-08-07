CLASS lcl_connection DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        airlineid        TYPE /dmo/carrier_id
        connectionnumber TYPE /dmo/connection_id
        fromAirport      TYPE /dmo/airport_from_id
        toAirport        TYPE /dmo/airport_to_id.


    CLASS-METHODS get_instance IMPORTING airlineId            TYPE /dmo/carrier_id
                                         connectionNumber     TYPE /dmo/connection_id
                               RETURNING VALUE(ro_connection) TYPE REF TO lcl_Connection.

    METHODS show_values RETURNING VALUE(rv_toAirport) TYPE /dmo/airport_to_id.


  PRIVATE SECTION.
    DATA AirlineId TYPE /dmo/carrier_id.
    DATA ConnectionNumber TYPE /dmo/connection_id.
    DATA fromAirport TYPE /dmo/airport_from_id.
    DATA toAirport TYPE /dmo/airport_to_id.
ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.
  METHOD constructor.
    me->airlineid        = airlineid.
    me->connectionnumber = connectionnumber.
    me->fromAirport      = fromAirport.
    me->toAirport        = toAirport.
  ENDMETHOD.

  METHOD get_instance.
    DATA lv_fromAirport TYPE /dmo/airport_from_id.
    DATA lv_toAirport   TYPE /dmo/airport_to_id.

    SELECT SINGLE FROM /dmo/connection
      FIELDS airport_from_id, airport_to_id
      WHERE carrier_id    = @airlineid
        AND connection_id = @connectionnumber
      INTO ( @lv_fromAirport, @lv_toAirport ).

    ro_connection = NEW #( airlineid        = airlineid
                           connectionnumber = connectionnumber
                           fromairport      = lv_fromairport
                           toairport        = lv_toairport ).
  ENDMETHOD.

  METHOD show_values.

    rv_toairport = toairport.

  ENDMETHOD.

ENDCLASS.
