CLASS zcm_abap DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    METHODS constructor
      IMPORTING textid    LIKE if_t100_message=>t100key
                severity  TYPE if_abap_behv_message=>t_severity
                !previous LIKE previous OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcm_abap IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
  ENDMETHOD.
ENDCLASS.
