@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for Z_R_PRODUCTMAIN'
define root view entity Z_C_PRODUCTMAIN
  provider contract transactional_query
  as projection on Z_R_PRODUCTMAIN
{
  key RecordID,
      ProductID,
      Decription,
      prodtype,
      active,
      validfrom,
      validto,
      rate,
      LocalLastChangedAt

}
