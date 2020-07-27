inherited frmPesquisaCliente: TfrmPesquisaCliente
  Caption = 'Pesquisar Clientes'
  OnDestroy = FormDestroy
  ExplicitWidth = 651
  ExplicitHeight = 338
  PixelsPerInch = 96
  TextHeight = 13
  inherited uqPesq: TUniQuery
    SQL.Strings = (
      'select * from clientes')
    Active = True
    IndexFieldNames = 'codcli'
  end
end
