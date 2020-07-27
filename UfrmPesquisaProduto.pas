unit UfrmPesquisaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmPesquisaPadrao, Data.DB, MemDS,
  DBAccess, Uni, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesquisaProdutos = class(TfrmPesquisaBASE)
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisaProdutos: TfrmPesquisaProdutos;

implementation

{$R *.dfm}

procedure TfrmPesquisaProdutos.btnPesquisarClick(Sender: TObject);
var
   campo:string;
begin
   inherited;
   campo := cbItens.Text;
   uqPesq.Close;
   uqPesq.SQL.Clear;

   uqPesq.SQL.Add('select * from produtos where '+campo+' like :pesq');
   uqPesq.ParamByName('pesq').AsString:=edtItemPesq.Text+'%';
   uqPesq.Open();
end;

procedure TfrmPesquisaProdutos.FormCreate(Sender: TObject);
var
i:Integer;
begin
   inherited;
   uqPesq.SQL.Text:='select * from produtos;';
   uqPesq.Active:=true;
   uqPesq.Close;
   uqPesq.SQL.Clear;
   uqPesq.SQL.Add('select * from produtos where 1=-1');
   uqPesq.Open();
   for i := 0 to uqPesq.FieldCount-1 do
      begin
           cbItens.Items.Add(uqPesq.Fields.Fields[i].FieldName);
      end;
   cbItens.ItemIndex:=0;
end;

end.
