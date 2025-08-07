@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exercício 2 - Agregação de tabelas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_EXER02_EAT
  as select from /dmo/connection as Connection
    inner join   /dmo/carrier    as Carrier     on Carrier.carrier_id = Connection.carrier_id

{

  key Connection.carrier_id                      as CarrierId,
      Carrier.name                               as CarrierName,
      count( distinct Connection.connection_id ) as ConnectionCount,
      max( Connection.distance )                 as MaxDistance



}
group by
  Connection.carrier_id,
  Carrier.name
