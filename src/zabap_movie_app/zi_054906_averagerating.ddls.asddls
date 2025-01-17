@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Average Rating'
define view entity ZI_054906_AverageRating
  as select from ZR_054906_Rating
{
  key MovieUuid,
      @EndUserText: { label: 'Average Rating', quickInfo: 'Average Rating' }
      avg(Rating as abap.dec(16,1)) as AverageRating
}
group by
  MovieUuid
