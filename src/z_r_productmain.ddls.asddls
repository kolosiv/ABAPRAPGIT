@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZAPRODUCTMAIN'
define root view entity Z_R_PRODUCTMAIN
  as select from zaproductmain as PRODUCTMAIN
{
  key record_id             as RecordID,
      product_id            as ProductID,
      decription            as Decription,
      prodtype              as prodtype,
      active                as active,
      valid_from            as validfrom,
      valid_to              as validto,
      rate                  as rate,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt

}
