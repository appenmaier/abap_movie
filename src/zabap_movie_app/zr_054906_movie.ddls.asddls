@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Movie'
define view entity ZR_054906_Movie
  as select from zabap_movie_a
{
  key movie_uuid      as MovieUuid,
      title           as Title,
      genre           as Genre,
      publishing_year as PublishingYear,
      runtime_in_min  as RuntimeInMin,
      @Semantics.imageUrl: true
      image_url       as ImageUrl,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy
}
