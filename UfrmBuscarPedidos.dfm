object frmBuscarPedido: TfrmBuscarPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmBuscarPedido'
  ClientHeight = 322
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object edtNumPedido: TEdit
    Left = 64
    Top = 64
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 0
  end
  object btnBuscarPedido: TButton
    Left = 248
    Top = 62
    Width = 113
    Height = 25
    Caption = 'btnBuscarPedido'
    TabOrder = 1
    OnClick = btnBuscarPedidoClick
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 112
    Width = 513
    Height = 120
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object UniQuery: TUniQuery
    Connection = frmConection.UniConnection1
    Constraints = <>
    Left = 144
    Top = 264
  end
  object DataSource1: TDataSource
    DataSet = UniQuery
    Left = 280
    Top = 272
  end
end
