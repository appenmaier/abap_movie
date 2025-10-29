@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Value Help for Genre'

define view entity ZI_054906_GenreVH
  as select from ZI_054906_Genre

{
  key Value,
      Text
}

