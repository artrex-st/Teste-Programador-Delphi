unit UfrmPesquisaPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmBuscarPedido = class(TForm)
    edtCodPedido: TEdit;
    btnBuscaPedido: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure BuscarPedido();
  private
    { Private declarations }
  public
    { Public declarations }
    blConfirma:Boolean;
  end;

var
  frmBuscarPedido: TfrmBuscarPedido;

implementation

uses
  UfrmPedido;

{$R *.dfm}

procedure TfrmBuscarPedido.BuscarPedido;
begin
     with frmPedido.UniQuery do
      begin
         sql.Clear;

      end;

end;

procedure TfrmBuscarPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
end;

procedure TfrmBuscarPedido.FormDestroy(Sender: TObject);
begin
     frmBuscarPedido:=nil;
end;

procedure TfrmBuscarPedido.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #27 then    //tem que verificar o keyPreviw
       begin
         case application.MessageBox('Deseja realmente fechar a tela de Buscas de pedido?', 'Confirmação', MB_yesno + MB_iconInformation) of
           mrNo, mrCancel: Application.MessageBox('retomando os testes.','Continuando...');
           mrYes: Close;
         end;
       end;
       if (Key = #13) then begin
         //Key := #0;
         Perform(Wm_NextDlgCtl,0,0);
       end;
end;

procedure TfrmBuscarPedido.FormShow(Sender: TObject);
begin
     blConfirma:=false;
end;

end.
