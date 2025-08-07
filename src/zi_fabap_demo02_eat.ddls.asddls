@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DEMO 02 - Agregation Example'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_DEMO02_EAT
  as select from /dmo/carrier    as Carrier
    inner join   /dmo/connection as Connection on Carrier.carrier_id = Connection.carrier_id
{

  key Carrier.carrier_id              as CarrierId,
      Carrier.name                    as CarrierName,
      sum(Connection.distance * 1000) as TotalDistanceMts,
      'M'                             as DistanceUnit,
      case when sum(Connection.distance) > 30000 then 'Long Distance'
           when sum(Connection.distance) > 20000 and sum(Connection.distance) < 30000 then 'Medium Distance'
           else 'Short Distance' end  as DistanceCategory


}
group by
  Carrier.carrier_id,
  Carrier.name,
  Connection.distance_unit
