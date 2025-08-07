CLASS zcl_fabap_jul2025_exer06_eat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    " Construtor: inicializa um novo produto com código, nome e preço
    " O estoque inicial é sempre zero
    METHODS constructor IMPORTING iv_codigo TYPE string
                                  iv_nome   TYPE string
                                  iv_preco  TYPE decfloat16.

    " Adiciona uma quantidade ao estoque do produto
    METHODS adicionar_estoque IMPORTING iv_quantidade TYPE i.

    " Remove uma quantidade do estoque, se disponível
    " Retorna TRUE se a operação foi bem-sucedida, FALSE caso contrário
    METHODS remover_estoque IMPORTING iv_quantidade     TYPE i
                            RETURNING VALUE(rv_sucesso) TYPE abap_bool.

    " Calcula o valor total do estoque (preço * quantidade)
    METHODS calcular_valor_total RETURNING VALUE(rv_valor_total) TYPE decfloat16.

    METHODS get_nome             RETURNING VALUE(rv_nome)        TYPE string.
    METHODS get_codigo           RETURNING VALUE(rv_codigo)      TYPE string.
    METHODS get_preco            RETURNING VALUE(rv_preco)       TYPE decfloat16.
    METHODS get_estoque          RETURNING VALUE(rv_estoque)     TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    " Atributos privados da classe
    DATA:
      mv_codigo  TYPE string,     " Código único do produto
      mv_nome    TYPE string,     " Nome descritivo do produto
      mv_preco   TYPE decfloat16, " Preço unitário do produto
      mv_estoque TYPE i.          " Quantidade em estoque

ENDCLASS.



CLASS ZCL_FABAP_JUL2025_EXER06_EAT IMPLEMENTATION.


  METHOD adicionar_estoque.
    " Adiciona a quantidade informada ao estoque
    mv_estoque += iv_quantidade.
  ENDMETHOD.


  METHOD calcular_valor_total.
    " Calcula o valor total multiplicando o preço pela quantidade em estoque
    rv_valor_total = mv_preco * mv_estoque.
  ENDMETHOD.


  METHOD constructor.
    " Inicializa os atributos com os valores recebidos
    mv_codigo = iv_codigo.
    mv_nome = iv_nome.
    mv_preco = iv_preco.
    mv_estoque = 0. " Estoque inicial é zero
  ENDMETHOD.


  METHOD get_codigo.
    rv_codigo = mv_codigo.
  ENDMETHOD.


  METHOD get_estoque.
    rv_estoque = mv_estoque.
  ENDMETHOD.


  METHOD get_nome.
    rv_nome = mv_nome.
  ENDMETHOD.


  METHOD get_preco.
    rv_preco = mv_preco.
  ENDMETHOD.


  METHOD remover_estoque.
    " Verifica se há estoque suficiente antes de remover
    IF iv_quantidade <= mv_estoque.
      " Estoque suficiente, pode remover
      mv_estoque = mv_estoque - iv_quantidade.
      rv_sucesso = abap_true.
    ELSE.
      " Estoque insuficiente, operação falha
      rv_sucesso = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
