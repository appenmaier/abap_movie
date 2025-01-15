CLASS zcm_054906_movie DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    CONSTANTS:
      BEGIN OF co_invalid_field_value,
        msgid TYPE symsgid      VALUE 'Z054906_MOVIE',
        msgno TYPE symsgno      VALUE '000',
        attr1 TYPE scx_attrname VALUE 'VALUE',
        attr2 TYPE scx_attrname VALUE 'FIELD',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF co_invalid_field_value.

    DATA value TYPE string.
    DATA field TYPE string.

    METHODS constructor
      IMPORTING textid    LIKE if_t100_message=>t100key
                severity  TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
                !previous LIKE previous                         OPTIONAL
                !value    TYPE string                           OPTIONAL
                !field    TYPE string                           OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcm_054906_movie IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    IF textid IS INITIAL.
      if_t100_message~t100key = co_invalid_field_value.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->value = value.
    me->field = field.
    if_abap_behv_message~m_severity = severity.
  ENDMETHOD.
ENDCLASS.
