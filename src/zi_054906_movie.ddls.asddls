@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie'
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZI_054906_Movie
  as select from ZR_054906_Movie
  association [0..1] to ZI_054906_AverageRating as _AverageRating on $projection.MovieUuid = _AverageRating.MovieUuid
  association [1..1] to ZI_054906_GenreText     as _GenreText     on $projection.Genre = _GenreText.GenreValue
  composition [0..*] of ZI_054906_Rating        as _Ratings

{
  key MovieUuid,
      Title,
      Genre,
      PublishingYear,
      RuntimeInMin,
      ImageUrl,
      CreatedAt,
      CreatedBy,
      LastChangedAt,
      LastChangedBy,

      case when _AverageRating.AverageRating > 6.7 then 3
           when _AverageRating.AverageRating > 3.4 then 2
           when _AverageRating.AverageRating > 0 then 1
           else 0
      end as AverageRatingCriticality,

      /* Associations */
      _Ratings,
      _AverageRating,
      _GenreText
}
