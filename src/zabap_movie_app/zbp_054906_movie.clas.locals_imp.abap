CLASS lhc_rating DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS determine_rating_date FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Rating~determine_rating_date.
    METHODS determine_user_name FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Rating~determine_user_name.
    METHODS validate_rating FOR VALIDATE ON SAVE
      IMPORTING keys FOR Rating~validate_rating.

ENDCLASS.


CLASS lhc_rating IMPLEMENTATION.
  METHOD validate_rating.
    READ ENTITY IN LOCAL MODE ZI_054906_RatingTP
         FIELDS ( Rating )
         WITH CORRESPONDING #( keys )
         RESULT FINAL(ratings).

    LOOP AT ratings INTO FINAL(rating).
      IF rating-rating < 1 OR rating-rating > 10.
        FINAL(message) = NEW zcm_abap_movie( textid   = zcm_abap_movie=>invalid_rating
                                             severity = if_abap_behv_message=>severity-error
                                             rating   = rating-Rating ).
        APPEND VALUE #( %tky            = rating-%tky
                        %msg            = message
                        %element-rating = if_abap_behv=>mk-on ) TO reported-rating.
        APPEND CORRESPONDING #( rating ) TO failed-rating.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD determine_rating_date.
    FINAL(now) = cl_abap_context_info=>get_system_date( ).

    MODIFY ENTITY IN LOCAL MODE ZI_054906_RatingTP
           UPDATE
           FIELDS ( RatingDate )
           WITH VALUE #( FOR key IN keys
                         ( %tky = key-%tky RatingDate = now ) ).
  ENDMETHOD.

  METHOD determine_user_name.
    FINAL(current_user) = sy-uname.

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
    READ ENTITY IN LOCAL MODE ZI_054906_MovieTP
         FIELDS ( Genre )
         WITH CORRESPONDING #( keys )
         RESULT FINAL(movies).

    LOOP AT movies INTO FINAL(movie).
      SELECT SINGLE
        FROM ddcds_customer_domain_value( p_domain_name = 'ZABAP_GENRE' )
        FIELDS @abap_true
        WHERE value_low = @movie-Genre
        INTO @FINAL(exists).

      IF exists = abap_false.
        FINAL(message) = NEW zcm_abap_movie( textid   = zcm_abap_movie=>no_genre_found
                                             severity = if_abap_behv_message=>severity-error
                                             genre    = movie-Genre ).
        APPEND VALUE #( %tky           = movie-%tky
                        %msg           = message
                        %create        = if_abap_behv=>mk-on
                        %element-genre = if_abap_behv=>mk-on ) TO reported-movie.
        APPEND CORRESPONDING #( movie ) TO failed-movie.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD rate_movie.
    MODIFY ENTITY IN LOCAL MODE ZI_054906_MovieTP
           CREATE BY \_Ratings
           FIELDS ( Rating )
           WITH VALUE #( FOR k IN keys
                         ( %tky    = k-%tky
                           %target = VALUE #( ( %cid   = 'X'
                                                Rating = k-%param-rating ) ) ) ).
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITY IN LOCAL MODE ZI_054906_MovieTP
         FIELDS ( PublishingYear )
         WITH CORRESPONDING #( keys )
         RESULT FINAL(movies).

    FINAL(current_year) = substring( val = cl_abap_context_info=>get_system_date( )
                                     len = 4 ).

    result = VALUE #( FOR movie IN movies
                      ( %tky               = movie-%tky
                        %action-rate_movie = COND #( WHEN movie-PublishingYear > current_year
                                                     THEN if_abap_behv=>fc-o-disabled
                                                     ELSE if_abap_behv=>fc-o-enabled ) ) ).
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.
ENDCLASS.
