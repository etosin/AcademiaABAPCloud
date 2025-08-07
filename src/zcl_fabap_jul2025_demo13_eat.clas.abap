CLASS zcl_fabap_jul2025_demo13_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_DEMO13_EAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lo_connection TYPE REF TO lcl_connection.

    lo_connection = lcl_connection=>get_instance( airlineid        = 'LH'
                                                  connectionnumber = '0400' ).

    out->write( 'Aeroporto de destino:' && lo_connection->show_values( ) ).

    lo_connection = lcl_connection=>get_instance( airlineid        = 'LH'
                                                  connectionnumber = '0401' ).

    out->write( 'Aeroporto de destino:' && lo_connection->show_values( ) ).

  ENDMETHOD.
ENDCLASS.
