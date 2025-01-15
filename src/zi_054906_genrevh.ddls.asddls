@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Genre'
define view entity ZI_054906_GenreVH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZABAP_GENRE' )
{
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @UI.hidden: true
  key language,
      @EndUserText: { label: 'Genre Value', quickInfo: 'Genre Value' }
      value_low as GenreValue,
      @EndUserText: { label: 'Genre Text', quickInfo: 'Genre Text' }
      text      as GenreText
}
where
  language = $session.system_language
