object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pedido'
  ClientHeight = 557
  ClientWidth = 656
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodCli: TLabel
    Left = 168
    Top = 84
    Width = 73
    Height = 13
    Caption = 'Codigo Cliente:'
  end
  object lblNomeCli: TLabel
    Left = 264
    Top = 84
    Width = 63
    Height = 13
    Caption = 'Nome Cliente'
  end
  object lblCodProd: TLabel
    Left = 168
    Top = 148
    Width = 78
    Height = 13
    Caption = 'Codigo Produto:'
  end
  object lblDescriProd: TLabel
    Left = 264
    Top = 148
    Width = 106
    Height = 13
    Caption = 'Descri'#231#227'o do Produto:'
  end
  object lblValorUni: TLabel
    Left = 27
    Top = 204
    Width = 68
    Height = 13
    Caption = 'Valor Unitario:'
  end
  object lblQuantidade: TLabel
    Left = 168
    Top = 204
    Width = 60
    Height = 13
    Caption = 'Quantidade:'
  end
  object lblReal: TLabel
    Left = 277
    Top = 480
    Width = 26
    Height = 23
    Caption = 'R$'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotal: TLabel
    Left = 27
    Top = 478
    Width = 62
    Height = 25
    Caption = 'Total:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtCodCliente: TEdit
    Left = 168
    Top = 100
    Width = 73
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnChange = edtCodClienteChange
    OnExit = edtCodClienteExit
    OnKeyPress = edtCodClienteKeyPress
  end
  object edtNomeCliente: TEdit
    Left = 264
    Top = 100
    Width = 354
    Height = 21
    Enabled = False
    TabOrder = 11
  end
  object btnPesqCliente: TButton
    Left = 27
    Top = 98
    Width = 121
    Height = 25
    Caption = '[F8] Buscar CLiente'
    TabOrder = 5
    OnClick = btnPesqClienteClick
  end
  object edtCodProd: TEdit
    Left = 168
    Top = 164
    Width = 73
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    OnExit = edtCodProdExit
    OnKeyPress = edtCodProdKeyPress
  end
  object edtDescriProd: TEdit
    Left = 264
    Top = 164
    Width = 354
    Height = 21
    Enabled = False
    TabOrder = 12
  end
  object btnPesqProd: TButton
    Left = 27
    Top = 162
    Width = 121
    Height = 25
    Caption = '[F9] Buscar Produto'
    TabOrder = 6
    OnClick = btnPesqProdClick
  end
  object edtValorProd: TEdit
    Left = 27
    Top = 220
    Width = 121
    Height = 21
    TabOrder = 2
    OnKeyPress = edtValorProdKeyPress
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 268
    Width = 630
    Height = 177
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    OnKeyPress = DBGrid1KeyPress
  end
  object edtQuantidade: TEdit
    Left = 168
    Top = 220
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    OnKeyPress = edtQuantidadeKeyPress
  end
  object btnAdicionar: TButton
    Left = 320
    Top = 218
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 4
    OnClick = btnAdicionarClick
  end
  object btnConfirmar: TButton
    Left = 320
    Top = 479
    Width = 134
    Height = 31
    Caption = '[F10] Confirmar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = btnConfirmarClick
  end
  object edtValorTotal: TEdit
    Left = 92
    Top = 477
    Width = 179
    Height = 31
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 13
    Text = '0,00'
    OnKeyPress = edtValorTotalKeyPress
  end
  object btnExcluir: TButton
    Left = 168
    Top = 29
    Width = 121
    Height = 25
    Caption = '[F12] Excluir Pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = btnExcluirClick
  end
  object btnBuscaPedido: TButton
    Left = 27
    Top = 29
    Width = 121
    Height = 25
    Caption = '[F11] Buscar Pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btnBuscaPedidoClick
  end
  object btnLimpar: TButton
    Left = 460
    Top = 479
    Width = 167
    Height = 32
    Caption = '[F1] Cancelar/Limpar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    OnClick = btnLimparClick
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = cdsTemporario
    Left = 520
    Top = 376
  end
  object UniQuery: TUniQuery
    Connection = frmConection.UniConnection1
    SQL.Strings = (
      'select * from dados_gerais_pedido')
    CachedUpdates = True
    Constraints = <>
    Left = 464
    Top = 376
  end
  object cdsTemporario: TUniClientDataSet
    PersistDataPacket.Data = {
      D50000009619E0BD010000001800000008000000000003000000D5000D636F64
      5F6974655F76656E64610400010000000000106E756D5F70656469646F5F6765
      72616C04000100000000000B636F645F70726F6475746F04000100000000000A
      7175616E74696461646504000100000000000A73657175656E6369616C040001
      00000000001076616C6F725F756E695F70656469646F08000400000000001276
      616C6F725F746F74616C5F70656469646F080004000000000009646573637269
      63616F01004900000001000557494454480200020064000000}
    Active = True
    Aggregates = <
      item
        Active = True
        AggregateName = 'Total'
        Expression = 'sum(valor_total_pedido)'
        Visible = False
      end>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'cod_ite_venda'
        DataType = ftInteger
      end
      item
        Name = 'num_pedido_geral'
        DataType = ftInteger
      end
      item
        Name = 'cod_produto'
        DataType = ftInteger
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end
      item
        Name = 'sequencial'
        DataType = ftInteger
      end
      item
        Name = 'valor_uni_pedido'
        DataType = ftFloat
      end
      item
        Name = 'valor_total_pedido'
        DataType = ftFloat
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 592
    Top = 368
    object cdsTemporariocod_produto: TIntegerField
      DisplayLabel = 'Codigo Produto'
      FieldName = 'cod_produto'
    end
    object cdsTemporariodescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 45
      FieldName = 'descricao'
      Size = 100
    end
    object cdsTemporariocor_ite_venda: TIntegerField
      DisplayLabel = 'Codigo item venda'
      FieldName = 'cod_ite_venda'
      Visible = False
    end
    object cdsTemporarionum_pedido_geral: TIntegerField
      FieldName = 'num_pedido_geral'
      Visible = False
    end
    object cdsTemporarioquantidade: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsTemporariosequencial: TIntegerField
      DisplayLabel = 'Sequencial'
      FieldName = 'sequencial'
      Visible = False
    end
    object cdsTemporariovalor_uni_pedido: TFloatField
      DisplayLabel = 'Valor Unitario'
      FieldName = 'valor_uni_pedido'
    end
    object cdsTemporariovalor_total_pedido: TFloatField
      DisplayLabel = 'Valor Total'
      FieldName = 'valor_total_pedido'
    end
  end
end
