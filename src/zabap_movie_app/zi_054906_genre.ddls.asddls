@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Genre'

define view entity ZI_054906_Genre
  as select from    DDCDS_CUSTOMER_DOMAIN_VALUE(
                      p_domain_name : 'ZABAP_GENRE') as Values

    left outer join DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                      p_domain_name : 'ZABAP_GENRE') as Texts
      on  Texts.domain_name    = Values.domain_name
      and Texts.value_position = Values.value_position
      and Texts.language       = $session.system_language

{
      @EndUserText.label: 'Genre Value'
      @EndUserText.quickInfo: 'Genre Value'
  key Values.value_low as Value,

      @EndUserText.label: 'Genre Value'
      @EndUserText.quickInfo: 'Genre Value'
      Texts.text       as Text
}
