@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for Z_R_BPIKO'
define root view entity Z_C_BPIKO
  provider contract transactional_query
  as projection on Z_R_BPIKO
{
  key RecordID,
  Partner,
  LocalLastChangedAt,
  Firstname,
  Lastname,
  Middlename,
  Birthdate,
  Marrstat,
  Sex,
  Prevfamylyflag,
  Prevfamyly,
  Education,
  Natio,
  Emplcategory,
  Residenct
  
}
