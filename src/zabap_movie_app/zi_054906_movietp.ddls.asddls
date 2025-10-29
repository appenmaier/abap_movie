@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Movie'

define root view entity ZI_054906_MovieTP
  as select from ZR_054906_Movie

  association [0..1] to ZI_054906_AverageRating as _AverageRating on $projection.MovieUuid = _AverageRating.MovieUuid
  association [1..1] to ZI_054906_GenreText     as _GenreText     on $projection.Genre = _GenreText.Value
  composition [0..*] of ZI_054906_RatingTP      as _Ratings

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

      /* Associations */
      _Ratings,
      _AverageRating,
      _GenreText
}
