unit UfrmBuscarPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS, DBAccess,
  Uni, Vcl.ExtCtrls;

type
  TfrmExcluirPedido = class(TForm)
    lblCodPedido: TLabel;
    edtNumPedido: TEdit;
    Excluir: TButton;
    uqExcluir: TUniQuery;
    pnTop: TPanel;
    Panel1: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ExcluirClick(Sender: TObject);
    procedure ExcluirPedido();
    procedure BuscarCodPedido();
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
  function verificarCampo:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExcluirPedido: TfrmExcluirPedido;

implementation

uses
  untConexao, UfrmPedido;

{$R *.dfm}

procedure TfrmExcluirPedido.ExcluirPedido;
begin
   frmConection.UniConnection1.StartTransaction;
   try
     with frmPedido.UniQuery do
     with uqExcluir do
      begin
         //Active:=true;
         SQL.Text:= 'SELECT * FROM produtos_pedido;';
         Close;
         sql.Clear;
         sql.Add('DELETE FROM produtos_pedido WHERE num_pedido_geral=:num;');
         sql.add('DELETE FROM dados_gerais_pedido WHERE num_pedido=:num;');
         ParamByName('num').Value := StrToInt(edtNumPedido.Text);
         ExecSQL;
         SQl.Add('SELECT * FROM produtos_pedido;');
         Open;
      end;
      frmConection.UniConnection1.Commit;
      application.MessageBox('Pedido excluido!', 'Informativo.', MB_OK + MB_ICONINFORMATION);
      edtNumPedido.Clear;
      edtNumPedido.SetFocus;
   Except
         frmConection.UniConnection1.Rollback;
         ShowMessage('Erro ao excluir pedido.');
         raise
   end;
end;

procedure TfrmExcluirPedido.BuscarCodPedido;
var
   Existe:integer;
begin
     with uqExcluir do
      begin
         Close;
         SQL.Clear;
         SQL.Add('select * from dados_gerais_pedido WHERE num_pedido=:pesq');
         ParamByName('pesq').Value:=StrToInt(edtNumPedido.Text);
         Open();
         Existe:= RecordCount;
         //Existe:=true;
         if Existe>0 then
            begin
               case application.MessageBox('Deseja realmente Excluir o Pedido', 'Confirmar exclusão?.', MB_yesno + MB_iconInformation) of
                  mrNo, mrCancel: Application.MessageBox('Cancelado, retomando os testes.','Continuando...');
                  mrYes:
                  begin
                     ExcluirPedido();
                  end;
            end;
            end
               else
                application.MessageBox('Codigo do Pedido não encontrado.', 'Informação.', MB_OK + MB_ICONERROR)
      end;

end;

procedure TfrmExcluirPedido.ExcluirClick(Sender: TObject);
begin
     if verificarCampo then
        BuscarCodPedido()
        else
        begin
             application.MessageBox('Codigo do Pedido não Informado.', 'Informação.', MB_OK + MB_ICONERROR);
             edtNumPedido.SetFocus;
        end


end;

procedure TfrmExcluirPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin

     frmExcluirPedido.Free;
end;

procedure TfrmExcluirPedido.FormDestroy(Sender: TObject);
begin
     frmExcluirPedido:=nil;
end;

procedure TfrmExcluirPedido.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #27 then    //tem que verificar o keyPreviw
       begin
         case application.MessageBox('Deseja realmente fechar a tela de exclusão de pedidos?', 'Confirmação', MB_yesno + MB_iconInformation) of
           mrNo, mrCancel: Application.MessageBox('retomando os testes.','Continuando...');
           mrYes: Close;
         end;
       end;
       if (Key = #13) then begin
         //Key := #0;
         Perform(Wm_NextDlgCtl,0,0);
       end;
end;

function TfrmExcluirPedido.verificarCampo: Boolean;
var
codPedido:Boolean;
begin
  codPedido := Trim(edtNumPedido.Text) <> EmptyStr;
  result := codPedido;
end;

end.
