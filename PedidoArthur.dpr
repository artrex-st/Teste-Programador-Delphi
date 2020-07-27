program PedidoArthur;

uses
  Vcl.Forms,
  untConexao in 'untConexao.pas' {frmConection},
  UfrmPesquisaPadrao in 'UfrmPesquisaPadrao.pas' {frmPesquisaBASE},
  UfrmPesquisaCliente in 'UfrmPesquisaCliente.pas' {frmPesquisaCliente},
  UfrmPedido in 'UfrmPedido.pas' {frmPedido},
  UfrmPesquisaProduto in 'UfrmPesquisaProduto.pas' {frmPesquisaProdutos},
  UfrmExcluirPedido in 'UfrmExcluirPedido.pas' {frmExcluirPedido},
  UfrmPesquisaPedido in 'UfrmPesquisaPedido.pas' {frmPesquisaPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmConection, frmConection);
  Application.CreateForm(TfrmPedido, frmPedido);
  Application.CreateForm(TfrmPesquisaPedido, frmPesquisaPedido);
  Application.Run;
end.
