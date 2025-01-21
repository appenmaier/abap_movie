@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Rating'

@Metadata.allowExtensions: true

define view entity ZC_054906_Rating
  as projection on ZI_054906_Rating

{
  key RatingUuid,

      MovieUuid,
      UserName,
      Rating,
      RatingDate,

      /* Associations */
      _Movie : redirected to parent ZC_054906_Movie
}
