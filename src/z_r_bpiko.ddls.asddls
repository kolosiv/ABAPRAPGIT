@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED BPIKO'
define root view entity Z_R_BPIKO
  as select from zabpiko as BPIKO
{
  key recordid as RecordID,
  partner as Partner,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  firstname as Firstname,
  lastname as Lastname,
  middlename as Middlename,
  birthdate as Birthdate,
  marrstat as Marrstat,
  sex as Sex,
  prevfamylyflag as Prevfamylyflag,
  prevfamyly as Prevfamyly,
  education as Education,
  natio as Natio,
  emplcategory as Emplcategory,
  residenct as Residenct
  
}
