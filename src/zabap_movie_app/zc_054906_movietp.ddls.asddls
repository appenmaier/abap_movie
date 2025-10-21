@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Movie'

@Metadata.allowExtensions: true

@Search.searchable: true

define root view entity ZC_054906_MovieTP
  provider contract transactional_query
  as projection on ZI_054906_MovieTP

{
  key MovieUuid,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Title,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_054906_GenreVH', element: 'Value' } } ]
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
      _AverageRating.AverageRatingCriticality,
      _GenreText.Text                          as GenreText,

      /* Associations */
      _Ratings : redirected to composition child ZC_054906_RatingTP
}
