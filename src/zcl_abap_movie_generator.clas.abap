CLASS zcl_abap_movie_generator DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_abap_movie_generator IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA movie   TYPE zabap_movie_a.
    DATA movies  TYPE TABLE OF zabap_movie_a.
    DATA rating  TYPE zabap_rating_a.
    DATA ratings TYPE TABLE OF zabap_rating_a.

    FINAL(random) = cl_abap_random_int=>create( seed = CONV i( cl_abap_context_info=>get_system_date( ) )
                                                min  = 1
                                                max  = 10 ).
    FINAL(bad_rating_random) = cl_abap_random_int=>create( seed = CONV i( cl_abap_context_info=>get_system_date( ) )
                                                           min  = 1
                                                           max  = 5 ).
    FINAL(good_rating_random) = cl_abap_random_int=>create( seed = CONV i( cl_abap_context_info=>get_system_date( ) )
                                                            min  = 7
                                                            max  = 10 ).

    " Delete Movies
    DELETE FROM zabap_movie_a.
    IF sy-subrc <> 0.
      out->write( |Error: DELETE FROM zabap_movie_a| ).
    ENDIF.
    out->write( |Deleted: { sy-dbcnt } movies| ).

    " Delete Ratings
    DELETE FROM zabap_rating_a.
    IF sy-subrc <> 0.
      out->write( |Error: DELETE FROM zabap_rating_a| ).
    ENDIF.
    out->write( |Deleted: { sy-dbcnt } ratings| ).

    " Maintain Admin Data for Movies
    movie-client = sy-mandt.
    GET TIME STAMP FIELD movie-created_at.
    movie-created_by = 'GENERATOR'.
    GET TIME STAMP FIELD movie-last_changed_at.
    movie-last_changed_by = 'GENERATOR'.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Die Verurteilten'.
    movie-genre           = 'DRAMA'.
    movie-publishing_year = '1994'.
    movie-runtime_in_min  = 142.
    movie-image_url       = 'https://m.media-amazon.com/images/I/517SDGYY26L._SX300_SY300_QL70_ML2_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Der Pate'.
    movie-genre           = 'DRAMA'.
    movie-publishing_year = '1972'.
    movie-runtime_in_min  = 175.
    movie-image_url       = 'https://m.media-amazon.com/images/I/61CmuSlouPL._SY445_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'The Dark Knight'.
    movie-genre           = 'FANTASY'.
    movie-publishing_year = '2008'.
    movie-runtime_in_min  = 152.
    movie-image_url       = 'https://m.media-amazon.com/images/I/71NiWjOPZ1L._SX342_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Der Pate 2'.
    movie-genre           = 'DRAMA'.
    movie-publishing_year = '1974'.
    movie-runtime_in_min  = 202.
    movie-image_url       = 'https://m.media-amazon.com/images/I/812R0xUnGAL._SY445_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Schindlers Liste'.
    movie-genre           = 'DRAMA'.
    movie-publishing_year = '1993'.
    movie-runtime_in_min  = 195.
    movie-image_url       = 'https://m.media-amazon.com/images/I/71gYAeGfLFL._SX342_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Fight Club'.
    movie-genre           = 'THRILLER'.
    movie-publishing_year = '1999'.
    movie-runtime_in_min  = 139.
    movie-image_url       = 'https://m.media-amazon.com/images/I/91z1PACXftL._SX342_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Pulp Fiction'.
    movie-genre           = 'DRAMA'.
    movie-publishing_year = '1994'.
    movie-runtime_in_min  = 154.
    movie-image_url       = 'https://m.media-amazon.com/images/I/510QW0CTXKL._AC_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Dune: Part Two'.
    movie-genre           = 'SCIFI'.
    movie-publishing_year = '2024'.
    movie-runtime_in_min  = 166.
    movie-image_url       = 'https://m.media-amazon.com/images/I/51odSyNeFgL._SX300_SY300_QL70_ML2_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Disaster Movie'.
    movie-genre           = 'COMEDY'.
    movie-publishing_year = '2008'.
    movie-runtime_in_min  = 87.
    movie-image_url       = 'https://m.media-amazon.com/images/I/51a9czHXSPL._SX300_SY300_QL70_ML2_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'DKAO - Türken im Weltall'.
    movie-genre           = 'SCIFI'.
    movie-publishing_year = '2006'.
    movie-runtime_in_min  = 140.
    movie-image_url       = 'https://m.media-amazon.com/images/I/51LzIDpziAL._SX300_SY300_QL70_ML2_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Steel - Der stählerne Held'.
    movie-genre           = 'ACTION'.
    movie-publishing_year = '1997'.
    movie-runtime_in_min  = 97.
    movie-image_url       = 'https://m.media-amazon.com/images/I/413z5md0KTL._SX300_SY300_QL70_ML2_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'Hercules in New York'.
    movie-genre           = 'ACTION'.
    movie-publishing_year = '1970'.
    movie-runtime_in_min  = 92.
    movie-image_url       = 'https://m.media-amazon.com/images/I/61cGw5t5clL._SX300_SY300_QL70_ML2_.jpg'.
    APPEND movie TO movies.

    " Create Movie
    movie-movie_uuid      = cl_system_uuid=>create_uuid_x16_static( ).
    movie-title           = 'House of the Dead'.
    movie-genre           = 'HORROR'.
    movie-publishing_year = '2003'.
    movie-runtime_in_min  = 90.
    movie-image_url       = 'https://m.media-amazon.com/images/I/414ja2N+iuL._SY300_.jpg'.
    APPEND movie TO movies.

    " Maintain Admin Data for Ratings
    rating-client = sy-mandt.

    " Create Good Ratings
    LOOP AT movies INTO movie FROM 1 TO 10.
      DO random->get_next( ) TIMES.
        rating-rating_uuid = cl_system_uuid=>create_uuid_x16_static( ).
        rating-movie_uuid  = movie-movie_uuid.
        rating-rating      = good_rating_random->get_next( ).
        rating-user_name   = |GENERATOR{ random->get_next( ) }|.
        rating-rating_date = cl_abap_context_info=>get_system_date( ) - random->get_next( ).
        APPEND rating TO ratings.
      ENDDO.
    ENDLOOP.

    " Create Bad Ratings
    LOOP AT movies INTO movie FROM 11 TO 15.
      DO random->get_next( ) TIMES.
        rating-rating_uuid = cl_system_uuid=>create_uuid_x16_static( ).
        rating-movie_uuid  = movie-movie_uuid.
        rating-rating      = bad_rating_random->get_next( ).
        rating-user_name   = |GENERATOR{ random->get_next( ) }|.
        rating-rating_date = cl_abap_context_info=>get_system_date( ) - random->get_next( ).
        APPEND rating TO ratings.
      ENDDO.
    ENDLOOP.

    " Insert Movies
    INSERT zabap_movie_a FROM TABLE @movies.
    IF sy-subrc <> 0.
      out->write( |Error: INSERT zabap_movie_a FROM TABLE @movies| ).
    ENDIF.
    out->write( |Inserted: { sy-dbcnt } movies| ).

    " Insert MovieRatings
    INSERT zabap_rating_a FROM TABLE @ratings.
    IF sy-subrc <> 0.
      out->write( |Error: INSERT zabap_rating_a FROM TABLE @ratings| ).
    ENDIF.
    out->write( |Inserted: { sy-dbcnt } ratings| ).
  ENDMETHOD.
ENDCLASS.
