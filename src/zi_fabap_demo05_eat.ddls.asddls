@EndUserText.label: 'DEMO 05 - CDS Table Function'
@ClientHandling.algorithm: #NONE
@ClientHandling.type: #CLIENT_INDEPENDENT
define table function ZI_FABAP_DEMO05_EAT
returns
{
  key client        : abap.clnt;
  key carrier_id    : /dmo/carrier_id;
  key connection_id : /dmo/connection_id;
  key flight_date   : /dmo/flight_date;  
  price             : /dmo/flight_price;
  currency_code     : /dmo/currency_code;
  plane_type_id     : /dmo/plane_type_id;
  seats_max         : /dmo/plane_seats_max;
  seats_occupied    : /dmo/plane_seats_occupied;

}
implemented by method
  ZCL_FABAP_JUL2025_DEMO05_EAT=>GET_DATA;