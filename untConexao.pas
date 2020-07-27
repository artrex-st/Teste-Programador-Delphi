unit untConexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Uni, MySQLUniProvider,
  Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

type
  TfrmConection = class(TForm)
    UniConnection1: TUniConnection;
    UniQuery1: TUniQuery;
    MainMenu1: TMainMenu;
    Pedido1: TMenuItem;
    Pedido2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Pedido2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConection: TfrmConection;

implementation

uses
  UfrmPedido;

{$R *.dfm}

procedure TfrmConection.FormCreate(Sender: TObject);
begin
  UniConnection1.Connected := True;
  //UniQuery1.SQL.Text := 'SELECT * FROM clientes';
  //UniQuery1.Open;
end;

procedure TfrmConection.Pedido2Click(Sender: TObject);
begin
  if not Assigned(frmPedido) then
    begin
      frmPedido := TfrmPedido.Create(Self);
    end;
    frmPedido.Show;
end;

end.
