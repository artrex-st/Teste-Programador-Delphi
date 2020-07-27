object frmPesquisaBASE: TfrmPesquisaBASE
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tela Principal'
  ClientHeight = 309
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid: TDBGrid
    AlignWithMargins = True
    Left = 0
    Top = 96
    Width = 635
    Height = 137
    DataSource = dsPesq
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGridDblClick
    OnKeyPress = DBGridKeyPress
  end
  object pnMenuPesq: TPanel
    Left = 0
    Top = 0
    Width = 645
    Height = 90
    Align = alTop
    Caption = 'pnMenuPesq'
    ShowCaption = False
    TabOrder = 1
    object lblOpcoes: TLabel
      Left = 32
      Top = 29
      Width = 40
      Height = 13
      Caption = 'Op'#231#245'es:'
    end
    object lblPesquisa: TLabel
      Left = 200
      Top = 29
      Width = 46
      Height = 13
      Caption = 'Pesquisa:'
    end
    object cbItens: TComboBox
      Left = 32
      Top = 45
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object edtItemPesq: TEdit
      Left = 200
      Top = 45
      Width = 305
      Height = 21
      TabOrder = 1
    end
    object btnPesquisar: TButton
      Left = 536
      Top = 41
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 2
      OnClick = btnPesquisarClick
    end
  end
  object btnConfirma: TButton
    Left = 32
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Confirma'
    TabOrder = 2
    OnClick = btnConfirmaClick
  end
  object btnCancelar: TButton
    Left = 136
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object dsPesq: TDataSource
    AutoEdit = False
    DataSet = uqPesq
    Left = 576
    Top = 248
  end
  object uqPesq: TUniQuery
    Connection = frmConection.UniConnection1
    Constraints = <>
    Left = 488
    Top = 248
  end
end
