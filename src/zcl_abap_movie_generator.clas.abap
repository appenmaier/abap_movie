CLASS zcl_abap_movie_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_abap_movie_generator IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA movie  TYPE zabap_movie_a.
    DATA movies TYPE TABLE OF zabap_movie_a.

    " Delete Movies
    DELETE FROM zabap_movie_a.
    IF sy-subrc <> 0.
      out->write( |Error: DELETE FROM zabap_movie_a| ).
    ENDIF.
    out->write( |Deleted: { sy-dbcnt } movies| ).

    " Maintain Admin Data
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
    movie-title           = 'House of the Dead'.
    movie-genre           = 'HORROR'.
    movie-publishing_year = '2003'.
    movie-runtime_in_min  = 90.
    movie-image_url       = 'https://m.media-amazon.com/images/I/414ja2N+iuL._SY300_.jpg'.
    APPEND movie TO movies.

    " Insert Movies
    INSERT zabap_movie_a FROM TABLE @movies.
    IF sy-subrc <> 0.
      out->write( |Error: INSERT zabap_movie_a FROM TABLE @movies| ).
    ENDIF.
    out->write( |Inserted: { sy-dbcnt } movies| ).
  ENDMETHOD.

ENDCLASS.
