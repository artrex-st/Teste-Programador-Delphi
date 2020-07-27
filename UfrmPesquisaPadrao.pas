unit UfrmPesquisaPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, MemDS, DBAccess, Uni;

type
  TfrmPesquisaBASE = class(TForm)
    dsPesq: TDataSource;
    DBGrid: TDBGrid;
    pnMenuPesq: TPanel;
    cbItens: TComboBox;
    edtItemPesq: TEdit;
    btnPesquisar: TButton;
    btnConfirma: TButton;
    btnCancelar: TButton;
    uqPesq: TUniQuery;
    lblOpcoes: TLabel;
    lblPesquisa: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blConfirma:Boolean;
  end;

var
  frmPesquisaBASE: TfrmPesquisaBASE;

implementation

uses
  untConexao;

{$R *.dfm}

procedure TfrmPesquisaBASE.btnCancelarClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmPesquisaBASE.btnConfirmaClick(Sender: TObject);
begin
    blConfirma:=true;
    Close;
end;

procedure TfrmPesquisaBASE.btnPesquisarClick(Sender: TObject);
begin
     DBGrid.SetFocus;
end;

procedure TfrmPesquisaBASE.DBGridDblClick(Sender: TObject);
begin
  blConfirma:=true;
  Close;
end;

procedure TfrmPesquisaBASE.DBGridKeyPress(Sender: TObject; var Key: Char);
begin
   If key = #13 then
      Begin
       blConfirma:=true;
       Close;
      end;
end;

procedure TfrmPesquisaBASE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree; // FORM CLOSE
end;

procedure TfrmPesquisaBASE.FormCreate(Sender: TObject);
begin
     blConfirma:=false;
end;

procedure TfrmPesquisaBASE.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #27 then    //tem que verificar o keyPreviw
    begin
      case application.MessageBox('Deseja realmente fechar a Pesquisa?', 'Confirmação', MB_yesno + MB_iconInformation) of
        mrNo, mrCancel: Application.MessageBox('retomando os testes.','Continuando...');
        mrYes: Close;
      end;
    end;
    if (Key = #13) then begin
      //Key := #0;
      Perform(Wm_NextDlgCtl,0,0);
    end;
end;

procedure TfrmPesquisaBASE.FormShow(Sender: TObject);
begin
     cbItens.SetFocus;
end;

end.
