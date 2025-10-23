CLASS zcm_abap_movie DEFINITION
  PUBLIC
  INHERITING FROM zcm_abap FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS:
      BEGIN OF no_genre_found,
        msgid TYPE symsgid      VALUE 'ZABAP_MOVIE',
        msgno TYPE symsgno      VALUE '000',
        attr1 TYPE scx_attrname VALUE 'GENRE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF no_genre_found.

    CONSTANTS:
      BEGIN OF invalid_rating,
        msgid TYPE symsgid      VALUE 'ZABAP_MOVIE',
        msgno TYPE symsgno      VALUE '001',
        attr1 TYPE scx_attrname VALUE 'RATING',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_rating.

    CONSTANTS:
      BEGIN OF movie_rated_successfully,
        msgid TYPE symsgid      VALUE 'ZABAP_MOVIE',
        msgno TYPE symsgno      VALUE '002',
        attr1 TYPE scx_attrname VALUE 'TITLE',
        attr2 TYPE scx_attrname VALUE 'RATING',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF movie_rated_successfully.

    METHODS constructor
      IMPORTING textid    LIKE if_t100_message=>t100key
                severity  TYPE if_abap_behv_message=>t_severity
                !previous LIKE previous     OPTIONAL
                genre     TYPE zabap_genre  OPTIONAL
                rating    TYPE zabap_rating OPTIONAL
                !title    TYPE zabap_title  OPTIONAL.

    DATA genre  TYPE zabap_genre.
    DATA rating TYPE zabap_rating.
    DATA title  TYPE zabap_title.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcm_abap_movie IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( textid   = textid
                        severity = severity
                        previous = previous ).

    me->genre  = genre.
    me->rating = rating.
    me->title  = title.
  ENDMETHOD.
ENDCLASS.
