@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Rating'

define view entity ZI_054906_RatingTP
  as select from ZR_054906_Rating

  association to parent ZI_054906_MovieTP as _Movie on $projection.MovieUuid = _Movie.MovieUuid

{
  key RatingUuid,

      MovieUuid,
      UserName,
      Rating,
      RatingDate,

      /* Associations */
      _Movie
}
