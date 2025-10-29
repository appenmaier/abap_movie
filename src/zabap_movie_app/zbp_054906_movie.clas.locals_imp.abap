CLASS lhc_rating DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS determine_rating_date FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Rating~determine_rating_date.
    METHODS determine_user_name FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Rating~determine_user_name.

ENDCLASS.


CLASS lhc_rating IMPLEMENTATION.
  METHOD determine_rating_date.
    " Determine Rating Date
    DATA(current_date) = cl_abap_context_info=>get_system_date( ).

    " Update Rating
    MODIFY ENTITY IN LOCAL MODE ZI_054906_RatingTP
           UPDATE
           FIELDS ( RatingDate )
           WITH VALUE #( FOR key IN keys
                         ( %tky = key-%tky RatingDate = current_date ) ).
  ENDMETHOD.

  METHOD determine_user_name.
    " Determine User Name and Update Rating
    DATA(current_user) = sy-uname.

    " Update Rating
    MODIFY ENTITY IN LOCAL MODE ZI_054906_RatingTP
           UPDATE
           FIELDS ( UserName )
           WITH VALUE #( FOR key IN keys
                         ( %tky = key-%tky UserName = current_user ) ).
  ENDMETHOD.
ENDCLASS.


CLASS lhc_Movie DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Movie RESULT result.
    METHODS validate_genre FOR VALIDATE ON SAVE
      IMPORTING keys FOR movie~validate_genre.
    METHODS rate_movie FOR MODIFY
      IMPORTING keys FOR ACTION movie~rate_movie.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR movie RESULT result.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR movie RESULT result.

ENDCLASS.


CLASS lhc_Movie IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validate_genre.
    " Read Movies
    READ ENTITY IN LOCAL MODE ZI_054906_MovieTP
         FIELDS ( Genre )
         WITH CORRESPONDING #( keys )
         RESULT DATA(movies).

    " Process Movies
    LOOP AT movies INTO DATA(movie).
      " Validate Genre
      SELECT SINGLE
        FROM ddcds_customer_domain_value( p_domain_name = 'ZABAP_GENRE' )
        FIELDS @abap_true
        WHERE value_low = @movie-Genre
        INTO @DATA(exists).

      IF exists = abap_false.
        " Create Error Message
        DATA(message) = NEW zcm_abap_movie( textid   = zcm_abap_movie=>no_genre_found
                                            severity = if_abap_behv_message=>severity-error
                                            genre    = movie-Genre ).
        APPEND VALUE #( %tky           = movie-%tky
                        %msg           = message
                        %create        = if_abap_behv=>mk-on
                        %element-genre = if_abap_behv=>mk-on ) TO reported-movie.
        APPEND VALUE #( %tky = movie-%tky ) TO failed-movie.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD rate_movie.
    DATA(valid_keys) = keys.

    " Process Movie-Keys
    LOOP AT keys INTO DATA(key).
      " Validate Rating
      IF key-%param-rating < 1 OR key-%param-rating > 10.
        " Create Error Message
        DATA(message) = NEW zcm_abap_movie( textid   = zcm_abap_movie=>invalid_rating
                                            severity = if_abap_behv_message=>severity-error
                                            rating   = key-%param-rating ).
        APPEND VALUE #( %tky               = key-%tky
                        %action-rate_movie = if_abap_behv=>mk-on
                        %msg               = message ) TO reported-movie.
        APPEND VALUE #( %tky = key-%tky ) TO failed-movie.
        DELETE valid_keys WHERE %tky = key-%tky.
      ENDIF.
    ENDLOOP.

    " Check Movie-Keys
    IF valid_keys IS INITIAL.
      RETURN.
    ENDIF.

    " Create Ratings
    MODIFY ENTITY IN LOCAL MODE ZI_054906_MovieTP
           CREATE BY \_Ratings
           AUTO FILL CID
           FIELDS ( Rating )
           WITH VALUE #( FOR k IN valid_keys
                         ( %tky    = k-%tky
                           %target = VALUE #( ( Rating = k-%param-rating ) ) ) ).

    " Read Movies
    READ ENTITY IN LOCAL MODE ZI_054906_MovieTP
         FIELDS ( Title )
         WITH CORRESPONDING #( valid_keys )
         RESULT DATA(movies).

    " Process Movies
    LOOP AT movies INTO DATA(movie).
      " Determine Rating
      DATA(rating) = valid_keys[ %tky = movie-%tky ]-%param-rating.

      " Create Success Message
      message = NEW zcm_abap_movie( textid   = zcm_abap_movie=>movie_rated_successfully
                                    severity = if_abap_behv_message=>severity-success
                                    rating   = rating
                                    title    = movie-Title ).

      APPEND VALUE #( %tky               = movie-%tky
                      %action-rate_movie = if_abap_behv=>mk-on
                      %msg               = message ) TO reported-movie.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.
    " Read Movies
    READ ENTITY IN LOCAL MODE ZI_054906_MovieTP
         FIELDS ( PublishingYear )
         WITH CORRESPONDING #( keys )
         RESULT DATA(movies).

    " Determine Current Year
    DATA(current_year) = substring( val = cl_abap_context_info=>get_system_date( )
                                    len = 4 ).

    " Set Feature Control for Action Rate Movie
    result = VALUE #( FOR movie IN movies
                      ( %tky               = movie-%tky
                        %action-rate_movie = COND #( WHEN movie-PublishingYear > current_year
                                                     THEN if_abap_behv=>fc-o-disabled
                                                     ELSE if_abap_behv=>fc-o-enabled ) ) ).
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.
ENDCLASS.
