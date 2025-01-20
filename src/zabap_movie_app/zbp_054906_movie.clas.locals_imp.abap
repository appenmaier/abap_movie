CLASS lhc_rating DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS determine_rating_date FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Rating~determine_rating_date.

    METHODS determine_user_name FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Rating~determine_user_name.

ENDCLASS.


CLASS lhc_rating IMPLEMENTATION.
  METHOD determine_rating_date.
    " Ausgewählte Bewertungen lesen
    READ ENTITY IN LOCAL MODE ZI_054906_Rating
         FIELDS ( RatingUuid )
         WITH CORRESPONDING #( keys )
         RESULT DATA(ratings).

    " Bewertungen sequentiell verarbeiten
    LOOP AT ratings REFERENCE INTO DATA(rating). " LOOP AT ratings ASSIGNING FIELD-SYMBOL(<rating>).

      " Bewertungsdatum ermittlen
      rating->RatingDate = cl_abap_context_info=>get_system_date( ). " rating-RatingDate = cl_abap_context_info=>get_system_date( ).

    ENDLOOP.

    " Geänderte Bewertungen zurückschreiben
    MODIFY ENTITY IN LOCAL MODE ZI_054906_Rating
           UPDATE
           FIELDS ( RatingDate )
           WITH VALUE #( FOR r IN ratings
                         ( %tky = r-%tky RatingDate = r-RatingDate ) ).
  ENDMETHOD.

  METHOD determine_user_name.
    " Ausgewählte Bewertungen lesen
    READ ENTITY IN LOCAL MODE ZI_054906_Rating
         FIELDS ( RatingUuid )
         WITH CORRESPONDING #( keys )
         RESULT DATA(ratings).

    " Bewertungen sequentiell verarbeiten
    LOOP AT ratings REFERENCE INTO DATA(rating). " LOOP AT ratings ASSIGNING FIELD-SYMBOL(<rating>).

      " Benutzername ermittlen
      rating->UserName = sy-uname. " rating-UserName = sy-uname

    ENDLOOP.

    " Geänderte Bewertungen zurückschreiben
    MODIFY ENTITY IN LOCAL MODE ZI_054906_Rating
           UPDATE
           FIELDS ( UserName )
           WITH VALUE #( FOR r IN ratings
                         ( %tky = r-%tky UserName = r-UserName ) ).
  ENDMETHOD.
ENDCLASS.


CLASS lhc_Movie DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Movie RESULT result.
    METHODS validate_genre FOR VALIDATE ON SAVE
      IMPORTING keys FOR movie~validate_genre.
    METHODS rate_movie FOR MODIFY
      IMPORTING keys FOR ACTION movie~rate_movie RESULT result.

ENDCLASS.


CLASS lhc_Movie IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validate_genre.
    " Ausgewählte Filme lesen
    READ ENTITY IN LOCAL MODE ZI_054906_Movie
         FIELDS ( Genre )
         WITH CORRESPONDING #( keys )
         RESULT FINAL(movies).

    " Filme sequentiell verarbeiten
    LOOP AT movies INTO FINAL(movie).

      " Genre prüfen und ggbfs. Fehlermeldung erstellen
      SELECT SINGLE
        FROM ddcds_customer_domain_value( p_domain_name = 'ZABAP_GENRE' )
        FIELDS @abap_true
        WHERE value_low = @movie-Genre
        INTO @FINAL(exists).

      IF exists = abap_false.
        FINAL(message) = NEW zcm_054906_movie( textid   = zcm_054906_movie=>co_invalid_field_value
                                               severity = if_abap_behv_message=>severity-error
                                               value    = CONV #( movie-Genre )
                                               field    = 'GENRE' ).
        APPEND VALUE #( %tky           = movie-%tky
                        %msg           = message
                        %create        = if_abap_behv=>mk-on
                        %element-genre = if_abap_behv=>mk-on ) TO reported-movie.
        APPEND CORRESPONDING #( movie ) TO failed-movie.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD rate_movie.
    " Schlüssel sequentiell verarbeiten
    LOOP AT keys INTO FINAL(key).

      " Bewertung prüfen und ggbfs. Fehlermeldung erstellen
      IF key-%param-rating < 1 OR key-%param-rating > 10.
        FINAL(message) = NEW zcm_054906_movie( textid   = zcm_054906_movie=>co_invalid_field_value
                                               severity = if_abap_behv_message=>severity-error
                                               value    = CONV #( key-%param-rating )
                                               field    = 'RATING' ).
        APPEND VALUE #( %tky = key-%tky
                        %msg = message ) TO reported-movie.
        APPEND CORRESPONDING #( key ) TO failed-movie.
      ENDIF.

      " Bewertung zurückschreiben
      MODIFY ENTITY IN LOCAL MODE ZI_054906_Movie
             CREATE BY \_Ratings
             FIELDS ( Rating )
             WITH VALUE #( ( %tky    = key-%tky
                             %target = VALUE #( ( %cid   = 'X'
                                                  Rating = key-%param-rating ) ) ) ).

      " Bewertungen lesen
      READ ENTITY IN LOCAL MODE ZI_054906_Movie
           BY \_Ratings
           ALL FIELDS
           WITH CORRESPONDING #( keys )
           RESULT FINAL(ratings).

      " Result zurückgeben
      result = VALUE #( FOR r IN ratings
                        ( %tky   = key-%tky
                          %param = r ) ).

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
