unit UfrmPesquisaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmPesquisaPadrao, Data.DB, MemDS,
  DBAccess, Uni, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesquisaPedido = class(TfrmPesquisaBASE)
  procedure BuscarPedido();
  procedure BuscarCodPedido();
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  function verificarCampo:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisaPedido: TfrmPesquisaPedido;

implementation

{$R *.dfm}

uses UfrmPedido;

{ TfrmPesquisaPedido }

procedure TfrmPesquisaPedido.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  if verificarCampo then
     BuscarCodPedido()
     else
     begin
          application.MessageBox('Codigo do Pedido não Informado.', 'Informação.', MB_OK + MB_ICONERROR);
          edtItemPesq.SetFocus;
     end
end;

procedure TfrmPesquisaPedido.BuscarCodPedido;
var
   Existe:integer;
begin
  with frmPedido.UniQuery do
      begin
         Close;
         SQL.Clear;
         SQL.Add('select * from dados_gerais_pedido WHERE num_pedido=:pesq');
         ParamByName('pesq').Value:=StrToInt(edtItemPesq.Text);
         Open();
         Existe:= RecordCount;
         if Existe>0 then
            begin
                 BuscarPedido();
            end
            else
                application.MessageBox('Número do Pedido não encontrado.', 'Informação.', MB_OK + MB_ICONERROR)
      end;
end;

procedure TfrmPesquisaPedido.BuscarPedido;
var
   campo:string;
begin
   try
      campo := '"'+cbItens.Text+'"';
      with uqPesq do
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
            sql.Add('where num_pedido like :pesq');
            ParamByName('pesq').AsString:=edtItemPesq.Text+'%';
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
   end;
procedure TfrmPesquisaPedido.FormCreate(Sender: TObject);  //////////////////////////// COMBO BOX
var
i:Integer;
begin
  inherited;
   with uqPesq do
      begin
         //Active:=true;
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
         sql.Add('where 1=-1');
         Active:=true;
         //Close;
         //SQL.Clear;
         //SQL.Add('select * from clientes where 1=-1');
         Open();
      end;
//  for i := 0 to uqPesq.FieldCount-1 do
//    begin
//      cbItens.Items.Add(uqPesq.Fields.Fields[i].FieldName);
//    end;
     cbItens.Items.Add('Numero do Pedido');
     cbItens.ItemIndex:=0;
end;

function TfrmPesquisaPedido.verificarCampo: Boolean;
var
   codPedido:Boolean;
begin
  codPedido := Trim(edtItemPesq.Text) <> EmptyStr;
  result := codPedido;
end;

end.
