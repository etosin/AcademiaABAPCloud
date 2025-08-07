CLASS zcl_fabap_jul2025_exer07_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER07_EAT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " Criação de um objeto produto
    DATA(lo_produto) = NEW zcl_fabap_jul2025_exer06_eat( iv_codigo = 'P001'
                                                         iv_nome   = 'Notebook'
                                                         iv_preco  = '3500.00' ).

    " Adicionar estoque
    lo_produto->adicionar_estoque( 10 ).

    " Exibir informações do produto
    out->write( |Produto:        { lo_produto->get_nome( ) }| ).
    out->write( |Código:         { lo_produto->get_codigo( ) }| ).
    out->write( |Preço unitário: { lo_produto->get_preco( ) }| ).
    out->write( |Estoque atual:  { lo_produto->get_estoque( ) }| ).

    DATA(lv_sucesso) = lo_produto->remover_estoque( 3 ).

    " Remover estoque com sucesso
    IF lv_sucesso = abap_true.
      out->write( |Estoque removido com sucesso!| ).
      out->write( |Novo estoque: { lo_produto->get_estoque( ) }| ).
    ELSE.
      out->write( |Estoque insuficiente!| ).
    ENDIF.

    " Tentar remover mais do que existe no estoque
    lv_sucesso = lo_produto->remover_estoque( 10 ).

    IF lv_sucesso = abap_true.
      out->write( |Estoque removido com sucesso!| ).
      out->write( |Novo estoque: { lo_produto->get_estoque( ) }| ).
    ELSE.
      out->write( |Estoque insuficiente!| ).
    ENDIF.

    " Calcular e exibir o valor total do estoque
    DATA(lv_valor_total) = lo_produto->calcular_valor_total( ).
    out->write( |Valor total em estoque: { lv_valor_total }| ).
  ENDMETHOD.
ENDCLASS.
