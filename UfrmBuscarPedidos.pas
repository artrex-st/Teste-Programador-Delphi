unit UfrmBuscarPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS, DBAccess,
  Uni, Vcl.Grids, Vcl.DBGrids;

type
  TfrmBuscarPedido = class(TForm)
    edtNumPedido: TEdit;
    btnBuscarPedido: TButton;
    UniQuery: TUniQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure btnBuscarPedidoClick(Sender: TObject);
    procedure BuscarPedido();
    procedure BuscarCodPedido();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
  function verificarCampo:Boolean;
    { Private declarations }
  public
  blConfirma:Boolean;
    { Public declarations }
  end;

var
  frmBuscarPedido: TfrmBuscarPedido;

implementation

uses
  UfrmPedido, untConexao;

{$R *.dfm}

procedure TfrmBuscarPedido.btnBuscarPedidoClick(Sender: TObject);
begin
     if verificarCampo then
        BuscarCodPedido()
        else
        begin
             application.MessageBox('Codigo do Pedido não Informado.', 'Informação.', MB_OK + MB_ICONERROR);
             edtNumPedido.SetFocus;
        end

end;

procedure TfrmBuscarPedido.BuscarCodPedido;
var
   Existe:integer;
begin
  with frmPedido.UniQuery do
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
               case application.MessageBox('Deseja realmente Carregar o Pedido', 'Confirmação.', MB_yesno + MB_iconInformation) of
                  mrNo, mrCancel: Application.MessageBox('Cancelado, retomando os testes.','Continuando...');
                  mrYes:
                  begin
                     BuscarPedido();
                  end;
            end;
            end
               else
                application.MessageBox('Codigo do Pedido não encontrado.', 'Informação.', MB_OK + MB_ICONERROR)
      end;
end;

procedure TfrmBuscarPedido.BuscarPedido;
begin
   //frmConection.UniConnection1.StartTransaction;
   try
     with UniQuery do
      begin
         //Active:=true;
         SQL.Text:= 'SELECT * FROM produtos_pedido;';
         Close;
         sql.Clear;
         //sql.Add('select * FROM produtos_pedido WHERE num_pedido_geral=:num;');
         sql.Add('SELECT');
         sql.Add('A.num_pedido AS "Numero do Pedido",');
         sql.Add('A.cod_cli AS "Codigo do Cliente",');
         sql.Add('B.nome AS "Nome do Cliente",');
         sql.Add('A.data_emicao AS "Data da Emição",');
         sql.Add('A.valor_total AS "Valor total"');
         sql.Add('FROM');
         sql.Add('dados_gerais_pedido AS A');
         sql.Add('INNER JOIN clientes AS B');
         sql.Add('ON A.cod_cli = B.codcli');
         sql.Add('WHERE A.num_pedido=:num;');
         ParamByName('num').Value := StrToInt(edtNumPedido.Text);
         //ExecSQL;
         Open;
      end;
      application.MessageBox('Pedido Carregado!', 'Informativo.', MB_OK + MB_ICONINFORMATION);
      //blConfirma:=true;
      //frmConection.UniConnection1.Commit;
   Except
      blConfirma:=false;
      //frmConection.UniConnection1.Rollback;
      ShowMessage('Erro ao Carregar pedido.');
      raise
   end;
   //Close;
end;

procedure TfrmBuscarPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
end;

procedure TfrmBuscarPedido.FormDestroy(Sender: TObject);
begin
     frmPedido:=nil;
end;

function TfrmBuscarPedido.verificarCampo: Boolean;
var
   codPedido:Boolean;
begin
  codPedido := Trim(edtNumPedido.Text) <> EmptyStr;
  result := codPedido;
end;

end.
