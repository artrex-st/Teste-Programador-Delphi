object frmConection: TfrmConection
  Left = 0
  Top = 0
  Caption = 'frmConection'
  ClientHeight = 626
  ClientWidth = 1004
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniConnection1: TUniConnection
    AutoCommit = False
    ProviderName = 'MySQL'
    Port = 3306
    Database = 'teste_prg_user1'
    Username = 'teste1'
    Server = '192.168.10.21'
    Connected = True
    Left = 48
    Top = 208
    EncryptedPassword = '8BFF9AFF8CFF8BFF9AFFCEFF'
  end
  object UniQuery1: TUniQuery
    Connection = UniConnection1
    SQL.Strings = (
      'select * from clientes')
    CachedUpdates = True
    Constraints = <>
    Left = 48
    Top = 272
  end
  object MainMenu1: TMainMenu
    Left = 280
    Top = 112
    object Pedido1: TMenuItem
      Caption = 'Venda'
      object Pedido2: TMenuItem
        Caption = 'Pedido'
        OnClick = Pedido2Click
      end
    end
  end
end
