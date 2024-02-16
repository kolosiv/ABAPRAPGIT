CLASS lhc_productmain DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR productmain
        RESULT result,
      checksemantickey FOR VALIDATE ON SAVE
        IMPORTING keys FOR productmain~checksemantickey,
      getcreatedet FOR DETERMINE ON SAVE
        IMPORTING keys FOR productmain~getcreatedet.
ENDCLASS.

CLASS lhc_productmain IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD checksemantickey.

    READ ENTITIES OF z_r_productmain IN LOCAL MODE
        ENTITY productmain
        FIELDS ( productid )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_newprod_id).

    "check product_id
    SELECT record_id, product_id FROM zaproductmain
        FOR ALL ENTRIES IN @lt_newprod_id
        WHERE product_id = @lt_newprod_id-productid
        AND record_id <> @lt_newprod_id-recordid
        INTO TABLE @DATA(lt_check_result).

    SELECT recordid, productid FROM zdproductmain
        FOR ALL ENTRIES IN @lt_newprod_id
        WHERE productid = @lt_newprod_id-productid
        AND recordid <> @lt_newprod_id-recordid
        INTO TABLE @DATA(lt_check_result_d).

    LOOP AT lt_newprod_id INTO DATA(ls_newprod_id).

      READ TABLE lt_check_result   INTO DATA(ls_check_result)   WITH KEY product_id = ls_newprod_id-productid.
      IF sy-subrc NE 0.
        READ TABLE lt_check_result_d INTO DATA(ls_check_result_d) WITH KEY productid = ls_newprod_id-productid.
        IF sy-subrc NE 0.
          CONTINUE.
        ENDIF.
      ENDIF.

      DATA(message) = me->new_message( id = 'ZMSGPROD'
                                       number = '001'
                                       severity = ms-error
                                       v1 = ls_newprod_id-productid ).

      DATA ls_reported_record LIKE LINE OF reported-productmain.
      ls_reported_record-%tky = ls_newprod_id-%tky.
      ls_reported_record-%msg = message.
      ls_reported_record-%element-productid = if_abap_behv=>mk-on.
      APPEND  ls_reported_record TO reported-productmain.

      DATA ls_failed_record LIKE LINE OF failed-productmain.
      ls_failed_record-%tky = ls_newprod_id-%tky.
      APPEND ls_failed_record TO failed-productmain.

    ENDLOOP.


  ENDMETHOD.

  METHOD getcreatedet.

    READ ENTITIES OF z_r_productmain IN LOCAL MODE
      ENTITY productmain
      FIELDS ( validfrom validto active )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_products).

*    LOOP AT lt_products ASSIGNING FIELD-SYMBOL(<ls_products>).
*      <ls_products>-validfrom = sy-datlo + 1.
*      <ls_products>-validto = sy-datlo + 365.
*      <ls_products>-active = abap_true.
*    ENDLOOP.
*
*    DATA lt_products_upd TYPE TABLE FOR UPDATE z_r_productmain.
*    lt_products_upd = CORRESPONDING #( lt_products ).

    LOOP AT lt_products INTO DATA(ls_products).
*      ls_products-validfrom = sy-datlo + 1.
*      ls_products-validto = sy-datlo + 365.
      ls_products-active = 'X'.

      MODIFY ENTITIES OF z_r_productmain IN LOCAL MODE
             ENTITY productmain
             UPDATE
             FIELDS ( active ) "validfrom validto
             WITH VALUE #( ( %tky = ls_products-%tky
*                             validfrom = ls_products-validfrom
*                             validto = ls_products-validto
                             active = ls_products-active ) ).
    ENDLOOP.

*    MODIFY ENTITIES OF z_r_productmain IN LOCAL MODE
*       ENTITY productmain
*       UPDATE FIELDS ( validfrom validto active )
*       WITH lt_products_upd
*       REPORTED DATA(reported_records).

*    reported-productmain = CORRESPONDING #( reported_records-productmain ).

  ENDMETHOD.

ENDCLASS.
