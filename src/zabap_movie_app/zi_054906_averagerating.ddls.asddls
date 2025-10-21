@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Average Rating'

define view entity ZI_054906_AverageRating
  as select from ZR_054906_Rating

{
  key MovieUuid,

      @EndUserText.label: 'Average Rating'
      @EndUserText.quickInfo: 'Average Rating'
      avg(Rating as abap.dec(16,1)) as AverageRating,

      case when avg(Rating as abap.dec(16,1)) > 6.7 then 3
           when avg(Rating as abap.dec(16,1)) > 3.4 then 2
           when avg(Rating as abap.dec(16,1)) > 0 then 1
           else 0
      end                           as AverageRatingCriticality
}

group by MovieUuid
