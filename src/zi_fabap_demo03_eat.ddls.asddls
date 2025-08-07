@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DEMO 03 - CDS Built-in Functions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_DEMO03_EAT
  as select from /dmo/connection as Connection
    inner join   /dmo/carrier    as Carrier     on Carrier.carrier_id = Connection.carrier_id
    inner join   /dmo/airport    as AirportFrom on AirportFrom.airport_id = Connection.airport_from_id
    inner join   /dmo/airport    as AirportTo   on AirportTo.airport_id = Connection.airport_to_id

{

  key Connection.connection_id                                          as ConnectionId,
      concat_with_space( Carrier.carrier_id, Carrier.name , 1 )         as Carrier,
      concat_with_space( AirportFrom.airport_id, AirportFrom.name , 1 ) as AirportFrom,
      concat_with_space( AirportTo.airport_id, AirportTo.name , 1 )     as AirportTo,
      substring( upper(AirportFrom.city), 1, 3 )                        as CityFrom,
      Connection.departure_time                                         as DepartureTime,
      Connection.arrival_time                                           as ArrivalTime,
      cast( Connection.distance as abap.char( 20 )  )                   as Distance,
      Connection.distance_unit                                          as DistanceUnit


}
