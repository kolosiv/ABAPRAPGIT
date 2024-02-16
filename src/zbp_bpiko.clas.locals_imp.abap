CLASS lhc_bpiko DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR bpiko
        RESULT result,
      getcreatedet FOR DETERMINE ON SAVE
        IMPORTING keys FOR bpiko~getcreatedet.
ENDCLASS.

CLASS lhc_bpiko IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD getcreatedet.

    DATA: lt_bpiko_upd TYPE TABLE FOR UPDATE z_r_bpiko,
          ls_bpiko_upd LIKE LINE OF lt_bpiko_upd.

    READ ENTITIES OF z_r_bpiko IN LOCAL MODE
      ENTITY bpiko
      FIELDS ( residenct )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_bpiko).

    LOOP AT lt_bpiko INTO DATA(ls_bpiko)
      WHERE residenct IS INITIAL.
      ls_bpiko-residenct = abap_true.
      ls_bpiko_upd = CORRESPONDING #( ls_bpiko ).
      APPEND ls_bpiko_upd TO lt_bpiko_upd.
    ENDLOOP.

    IF lt_bpiko_upd IS NOT INITIAL.
      MODIFY ENTITIES OF z_r_bpiko IN LOCAL MODE
         ENTITY bpiko
         UPDATE FIELDS ( residenct )
         WITH VALUE #( FOR bpiko IN lt_bpiko_upd  (
                           %tky      = bpiko-%tky
                           residenct  = bpiko-residenct ) ).
*         REPORTED DATA(reported_records).

*      reported-bpiko = CORRESPONDING #( reported_records-bpiko ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
