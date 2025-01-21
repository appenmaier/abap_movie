@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Movie'

@Metadata.allowExtensions: true

@Search.searchable: true

define root view entity ZC_054906_Movie
  provider contract transactional_query
  as projection on ZI_054906_Movie

{
  key MovieUuid,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Title,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_054906_GenreVH', element: 'GenreValue' } } ]
      @ObjectModel.text.element: [ 'GenreText' ]
      Genre,

      PublishingYear,
      RuntimeInMin,
      ImageUrl,
      CreatedAt,
      CreatedBy,
      LastChangedAt,
      LastChangedBy,

      /* Transient Data */
      _AverageRating.AverageRating,
      AverageRatingCriticality,
      _GenreText.GenreText,

      /* Associations */
      _Ratings : redirected to composition child ZC_054906_Rating
}
