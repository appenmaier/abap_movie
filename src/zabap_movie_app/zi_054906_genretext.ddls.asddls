@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Textelement for Genre'

define view entity ZI_054906_GenreText
  as select from ZI_054906_Genre

{
  key Value,
      Text
}
