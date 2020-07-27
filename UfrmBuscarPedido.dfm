object frmExcluirPedido: TfrmExcluirPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Excluir Pedido'
  ClientHeight = 162
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodPedido: TLabel
    Left = 38
    Top = 55
    Width = 121
    Height = 16
    Caption = 'Numero do Pedido:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtNumPedido: TEdit
    Left = 38
    Top = 71
    Width = 121
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    NumbersOnly = True
    ParentFont = False
    TabOrder = 0
  end
  object Excluir: TButton
    Left = 240
    Top = 55
    Width = 89
    Height = 40
    Caption = 'Excluir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = ExcluirClick
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 380
    Height = 41
    Align = alTop
    Caption = 'pnTop'
    ShowCaption = False
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 122
    Width = 380
    Height = 40
    Align = alBottom
    Caption = 'pnTop'
    ShowCaption = False
    TabOrder = 3
  end
  object uqExcluir: TUniQuery
    Connection = frmConection.UniConnection1
    Constraints = <>
    Left = 184
    Top = 56
  end
end
