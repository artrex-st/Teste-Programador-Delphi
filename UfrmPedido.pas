unit UfrmPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS, DBAccess,
  Uni, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.Mask, UniClientDataSet,DBXCommon;

type
  TfrmPedido = class(TForm)
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    btnPesqCliente: TButton;
    edtCodProd: TEdit;
    edtDescriProd: TEdit;
    btnPesqProd: TButton;
    edtValorProd: TEdit;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    UniQuery: TUniQuery;
    edtQuantidade: TEdit;
    lblCodCli: TLabel;
    lblNomeCli: TLabel;
    lblCodProd: TLabel;
    lblDescriProd: TLabel;
    lblValorUni: TLabel;
    lblQuantidade: TLabel;
    btnAdicionar: TButton;
    btnConfirmar: TButton;
    edtValorTotal: TEdit;
    cdsTemporario: TUniClientDataSet;
    cdsTemporariocor_ite_venda: TIntegerField;
    cdsTemporarionum_pedido_geral: TIntegerField;
    cdsTemporariocod_produto: TIntegerField;
    cdsTemporarioquantidade: TIntegerField;
    cdsTemporariosequencial: TIntegerField;
    cdsTemporariovalor_uni_pedido: TFloatField;
    cdsTemporariovalor_total_pedido: TFloatField;
    cdsTemporariodescricao: TStringField;
    btnExcluir: TButton;
    lblReal: TLabel;
    lblTotal: TLabel;
    btnBuscaPedido: TButton;
    btnLimpar: TButton;
    procedure btnPesqClienteClick(Sender: TObject);
    procedure ChamaCliente();
    procedure ChamaProduto();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesqProdClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure AdicionaItemTemp();
    procedure EditaItemTemp();
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Confirmar();
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtValorTotalKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorProdKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure LimpaConfirmado();
    procedure AtualizaTotal();
    procedure ChamaItemEditar();
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure BuscaCodCli();
    procedure BuscaCodIte();
    procedure edtCodProdKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodClienteChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnBuscaPedidoClick(Sender: TObject);
    procedure CarregarCds(numeroPedidoCarregado:integer);
    procedure InsertPedidoNovo();
    procedure LimparTemporario();
    procedure btnLimparClick(Sender: TObject);
    procedure LimparEdits();
    procedure UpdatePedidoCarregado();
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodProdExit(Sender: TObject);

  private
    { Private declarations }
    function VerificarCampos:Boolean;
    function TiraPontos(texto:string):string;


  public
    blEditar:Boolean;
    blCarregado:Boolean;
    numeroPedido:integer;
    item:integer;
    ExcluirItem:Array of Integer;
    //array[1..9999] of Integer;
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;


implementation

uses
  UfrmPesquisaCliente, UfrmPesquisaProduto, untConexao, UfrmExcluirPedido,
  UfrmBuscarPedidos, UfrmPesquisaPedido;

{$R *.dfm}

procedure TfrmPedido.AdicionaItemTemp;    ////////////////////////////  ////////    // ADICIONA ITENS DENTRO DA TEMPORARIA
var
   total : Real;
begin
  cdsTemporario.Append;
  cdsTemporario.FieldByName('cod_ite_venda').AsInteger:=0; // adiciona '0' para indicar insert ou update;
  cdsTemporario.FieldByName('cod_produto').AsInteger := StrToInt(edtCodProd.Text);
  cdsTemporario.FieldByName('quantidade').AsInteger := StrToInt(edtQuantidade.Text);
  cdsTemporario.FieldByName('descricao').AsString := edtDescriProd.Text;
 //cdsTemporario.FieldByName('sequencial').AsInteger := StrToInt(edtSe.Text);
  cdsTemporario.FieldByName('valor_uni_pedido').AsFloat := StrToFloat(edtValorProd.Text);
  Total := StrToInt(edtQuantidade.Text) * StrToFloat(edtValorProd.Text);
  cdsTemporario.FieldByName('valor_total_pedido').AsFloat := Total;
  cdsTemporario.Post;
  //cdsTemporario.Refresh;
end;

procedure TfrmPedido.AtualizaTotal;
begin
     edtValorTotal.Text := FormatFloat('#,##0.00', cdsTemporario.Aggregates[0].Value);
end;

procedure TfrmPedido.btnAdicionarClick(Sender: TObject);
var
total:string;
begin
 if (VerificarCampos) and (StrToInt(edtQuantidade.Text)<>0) then
    begin
      if blEditar then
         begin
            EditaItemTemp();
            blEditar:=false;
         end
         else
            begin
            //if True then
                 AdicionaItemTemp();
            end;
      AtualizaTotal();
    end
     else
     if edtQuantidade.Text='0' then
        application.MessageBox('Quantidade igual a "0" (ZERO) não permitida.', 'Informativo.', MB_OK + MB_ICONSTOP)
        else
         application.MessageBox('Escolha um cliente e um produto.', 'Informativo.', MB_OK + MB_ICONSTOP);

end;

procedure TfrmPedido.btnBuscaPedidoClick(Sender: TObject);
var
  PesquisaPedido : TfrmPesquisaPedido;
begin
     PesquisaPedido := TfrmPesquisaPedido.Create(nil);
     try
       PesquisaPedido.ShowModal;
       if PesquisaPedido.blConfirma then
       begin
          edtCodCliente.Text:=PesquisaPedido.uqPesq.FieldByName('Codigo do Cliente').AsString;
          edtNomeCliente.Text:=PesquisaPedido.uqPesq.FieldByName('Nome do Cliente').AsString;
          CarregarCds(PesquisaPedido.uqPesq.FieldByName('Numero do Pedido').Value);
       end;
     finally
       PesquisaPedido.Free;
     end;
end;

procedure TfrmPedido.btnConfirmarClick(Sender: TObject);
begin
     if cdsTemporario.IsEmpty then
      begin
         application.MessageBox('Não existem Itens para Confirmar um Pedido.', 'Informativo.', MB_OK + MB_ICONSTOP);
         Exit;
      end;
      Confirmar();
      LimpaConfirmado();

end;

procedure TfrmPedido.btnPesqClienteClick(Sender: TObject);
begin
  inherited;
  ChamaCliente();
  edtCodCliente.SetFocus;
end;

procedure TfrmPedido.btnPesqProdClick(Sender: TObject);
begin
   ChamaProduto();
   edtQuantidade.Text:='1';
   edtCodProd.SetFocus;
end;

procedure TfrmPedido.BuscaCodCli;
var
   Existe:integer;
begin
   UniQuery.Close;
   UniQuery.SQL.Clear;
   UniQuery.SQL.Add('select * from clientes where codcli=:pesq');
   UniQuery.ParamByName('pesq').AsString:=edtCodCliente.Text+'%';
   UniQuery.Open();
   Existe:= UniQuery.RecordCount;
   //Existe:=true;
   if Existe>0 then
   begin
      edtNomeCliente.Text:=UniQuery.FieldByName('nome').AsString;
      edtCodProd.SetFocus;
   end
      else
      begin
          application.MessageBox('Codigo do cliente não encontrado.', 'Informação.', MB_OK + MB_iconInformation);
          btnPesqCliente.SetFocus;
      end;

end;

procedure TfrmPedido.BuscaCodIte;
var
   Existe:integer;
begin
   UniQuery.Close;
   UniQuery.SQL.Clear;
   UniQuery.SQL.Add('select * from produtos where codite=:pesq');
   UniQuery.ParamByName('pesq').AsString:=edtCodProd.Text+'%';
   UniQuery.Open();
   Existe:= UniQuery.RecordCount;
   //Existe:=true;
   if Existe>0 then
   begin
      edtDescriProd.Text:=UniQuery.FieldByName('descri').AsString;
      edtValorProd.Text := UniQuery.FieldByName('valor_custo').AsString;
      edtValorProd.SetFocus;
      edtQuantidade.Text:='1';
   end
      else
      begin
          application.MessageBox('Codigo do Produto/Item não encontrado.', 'Informação.', MB_OK + MB_iconInformation);
          btnPesqProd.SetFocus;
      end;
end;

procedure TfrmPedido.btnExcluirClick(Sender: TObject);
var
  formExcluir : TfrmExcluirPedido;
begin
formExcluir := TfrmExcluirPedido.Create(nil);
     try
       formExcluir.ShowModal;
     finally
       formExcluir.Free;
     end;
end;

procedure TfrmPedido.btnLimparClick(Sender: TObject);
begin
     LimparTemporario();
     LimparEdits();
end;

procedure TfrmPedido.CarregarCds(numeroPedidoCarregado: integer);
var
   total : Real;
   campos:integer;
   I: Integer;
begin
   with UniQuery do
      begin
         SQL.Text:= 'SELECT * FROM produtos_pedido;';
         Close;
         sql.Clear;
         sql.Add('SELECT');
         SQL.Add('A.cod_ite_venda,');
         sql.Add('A.cod_produto AS "Codigo do Produto",');
         sql.Add('D.descri AS "Descrição",');
         sql.Add('A.quantidade AS "Quantidade",');
         sql.Add('A.valor_uni_pedido AS "Valor Unitario",');
         sql.Add('A.valor_total_pedido AS "Sub Total",');
         sql.Add('B.valor_total AS "Valor Total"');
         sql.Add('FROM');
         sql.Add('produtos_pedido AS A');
         sql.Add('INNER JOIN dados_gerais_pedido AS B');
         sql.Add('ON A.num_pedido_geral = B.num_pedido');
         sql.Add('INNER JOIN produtos AS D');
         sql.Add('ON D.codite = A.cod_produto');
         sql.Add('WHERE B.num_pedido=:num;');
         ParamByName('num').Value := numeroPedidoCarregado;
         //Active:=true;
         Close;
         Open();
         Campos:=UniQuery.RecordCount;
      end;
      LimparTemporario();
      for I := 1 to Campos do
         begin
           cdsTemporario.Append;
           cdsTemporario.FieldByName('cod_ite_venda').AsInteger := UniQuery.FieldByName('cod_ite_venda').AsInteger;
           cdsTemporario.FieldByName('cod_produto').AsInteger := UniQuery.FieldByName('Codigo do Produto').AsInteger;
           cdsTemporario.FieldByName('quantidade').AsInteger := UniQuery.FieldByName('Quantidade').AsInteger;;
           cdsTemporario.FieldByName('descricao').AsString := UniQuery.FieldByName('Descrição').AsString;
           cdsTemporario.FieldByName('valor_uni_pedido').AsFloat := UniQuery.FieldByName('Valor Unitario').AsFloat;
           cdsTemporario.FieldByName('valor_total_pedido').AsFloat := UniQuery.FieldByName('Sub Total').AsFloat;;
           cdsTemporario.Post;
           UniQuery.Next;
         end;
         AtualizaTotal();
         blCarregado:=true;
         numeroPedido:=numeroPedidoCarregado;

end;

procedure TfrmPedido.ChamaCliente;
var
   formPesqCli : TfrmPesquisaCliente;
   iID:integer;
begin
   inherited;
   formPesqCli := TfrmPesquisaCliente.Create(nil);
     try
       formPesqCli.ShowModal;
       if formPesqCli.blConfirma then
         begin
           //formPesqCli.uqPesq.FindKey([iID]);
           edtCodCliente.Text := IntToStr(formPesqCli.uqPesq.FieldByName('codcli').AsInteger);
           edtNomeCliente.Text := formPesqCli.uqPesq.FieldByName('nome').AsString;
           //edtValorIte.Text := formPesqCli.uqPesq.FieldByName('valor_unidade').AsString;
           //iID:=formPesqCli.uqPesq.FieldByName('cod').AsInteger;
           //fdqConexaoTabelauqPesq.Locate('id',iID,[]);
         end;
     finally
       formPesqCli.Free;
     end;
end;

procedure TfrmPedido.ChamaItemEditar;    //////////////////////////////////////////// EDITAR BLeDITAR
begin
     edtCodProd.Text := cdsTemporario.FieldByName('cod_produto').AsString;
     edtDescriProd.Text := cdsTemporario.FieldByName('descricao').AsString;
     edtQuantidade.Text := cdsTemporario.FieldByName('quantidade').AsString;
     edtValorProd.Text := cdsTemporario.FieldByName('valor_uni_pedido').AsString;
     edtCodCliente.Enabled:=false;
     edtCodProd.Enabled:=false;
     btnPesqCliente.Enabled:=false;
     btnPesqProd.Enabled:=false;
     btnConfirmar.Enabled:=false;
     btnAdicionar.Caption:='Editar';
     blEditar:=true;
     edtQuantidade.SetFocus;

end;

procedure TfrmPedido.ChamaProduto;
var
   formPesqProd : TfrmPesquisaProdutos;
   iID:integer;
begin
   inherited;
   formPesqProd := TfrmPesquisaProdutos.Create(nil);
     try
       formPesqProd.ShowModal;
       if formPesqProd.blConfirma then
         begin
           //formPesqCli.uqPesq.FindKey([iID]);
           edtCodProd.Text := IntToStr(formPesqProd.uqPesq.FieldByName('codite').AsInteger);
           edtDescriProd.Text := formPesqProd.uqPesq.FieldByName('descri').AsString;
           edtValorProd.Text := formPesqProd.uqPesq.FieldByName('valor_custo').AsString;
           //iID:=formPesqCli.uqPesq.FieldByName('cod').AsInteger;
           //fdqConexaoTabelauqPesq.Locate('id',iID,[]);
         end;
     finally
       formPesqProd.Free;
     end;
end;

procedure TfrmPedido.Confirmar;

begin
   //InsertPedido();
   frmConection.UniConnection1.StartTransaction;
   //UniQuery.Transaction.StartTransaction;
   try
    with UniQuery do
      begin
        if blCarregado=false then
        begin
          InsertPedidoNovo();
        end
        else
           begin
            UpdatePedidoCarregado();
           end;
      end;
      item:=0;
      frmConection.UniConnection1.Commit;
   except
         //UniQuery.Transaction.Rollback;
         frmConection.UniConnection1.Rollback;
         ShowMessage('Erro ao inserir dados.');
         raise
   //   on E:Exception do
   //      begin
   //         ShowMessage(E.Message);
   //         Exit;
   //      end
   end;
   //UniQuery.CommitUpdates;
//  -- fk_prod_pe_ger_pe -- inserir depois do confirma
//cod_produto  -- fk_prod_pe_prod
//quantidade
//sequencial
//valor_uni_pedido
//valor_total_pedido

//  cdsTempItensVenda.ApplyUpdates(0);
end;

procedure TfrmPedido.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (cdsTemporario.IsEmpty) and (Key=VK_DELETE) then
      begin
         application.MessageBox('Não existem Itens para remover.', 'Informativo.', MB_OK + MB_ICONERROR);
         Exit;
      end;
   if Key=VK_DELETE then //VK_DELETE 2E 46 Tecla DEL
      Begin
         case application.MessageBox('Deseja realmente REMOVER o item desse pedido?', 'Confirmação', MB_yesno + MB_iconInformation) of
           mrNo, mrCancel: Application.MessageBox('retomando os testes.','Continuando...');
           mrYes:
           begin
           if blCarregado then
              begin
                 item:=item+1;
                 SetLength(ExcluirItem, item+1);
                 ExcluirItem[item]:=cdsTemporario.FieldByName('cod_ite_venda').AsInteger;
                 //ListaNum.i(ListaNum.Count-1,cdsTemporario.FieldByName('cod_ite_venda'));
                 //teste:=ListaNum[1];
              end;
            cdsTemporario.Delete;
            if cdsTemporario.IsEmpty then
               edtValorTotal.Text:='0,00'
               else
                   AtualizaTotal();
           end;
         end;
      end;
end;

procedure TfrmPedido.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
     if (cdsTemporario.IsEmpty) and (Key=#13) then
      begin
         application.MessageBox('Não existem Itens para Editar.', 'Informativo.', MB_OK + MB_ICONERROR);
         Exit;
      end;
     if Key=#13 then //VK_DELETE 2E 46 Tecla DEL
        Begin
             ChamaItemEditar();
             //EditaItemTemp();
        end;
end;

procedure TfrmPedido.EditaItemTemp;                      //////////////////////////////// editar temporario
var
   total : Real;
begin
   cdsTemporario.Edit;
   cdsTemporario.FieldByName('cod_produto').AsInteger := StrToInt(edtCodProd.Text);
   cdsTemporario.FieldByName('quantidade').AsInteger := StrToInt(edtQuantidade.Text);
   cdsTemporario.FieldByName('descricao').AsString := edtDescriProd.Text;
   //cdsTemporario.FieldByName('sequencial').AsInteger := StrToInt(edtSe.Text);
   cdsTemporario.FieldByName('valor_uni_pedido').AsFloat := StrToFloat(edtValorProd.Text);
   Total := StrToInt(edtQuantidade.Text) * StrToFloat(edtValorProd.Text);
   cdsTemporario.FieldByName('valor_total_pedido').AsFloat := Total;
   cdsTemporario.Post;
   edtCodCliente.Enabled:=true;
   edtCodProd.Enabled:=true;
   btnPesqCliente.Enabled:=true;
   btnPesqProd.Enabled:=true;
   btnConfirmar.Enabled:=true;
   btnAdicionar.Caption:='Adicionar';
   blEditar:=false;
  //cdsTemporario.Refresh;
end;

procedure TfrmPedido.edtCodClienteChange(Sender: TObject);
begin
     if edtCodCliente.Text<>'' then
     begin
          btnExcluir.Visible:=false;
          btnBuscaPedido.Visible:=false;
     end
        else
        begin
             btnExcluir.Visible:=true;
             btnBuscaPedido.Visible:=true;
        end;

end;

procedure TfrmPedido.edtCodClienteExit(Sender: TObject);
begin
     if edtCodCliente.Text<>'' then
        BuscaCodCli();
end;

procedure TfrmPedido.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
     if not (Key in ['0'..'9', #13, #8]) then
      Key := #0;
end;

procedure TfrmPedido.edtCodProdExit(Sender: TObject);
begin
     if edtCodProd.Text<>'' then
        BuscaCodIte();
end;

procedure TfrmPedido.edtCodProdKeyPress(Sender: TObject; var Key: Char);
begin
     if not (Key in ['0'..'9', #13, #8]) then
      Key := #0;
end;

procedure TfrmPedido.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
     if not (Key in ['0'..'9', #13, #8]) then
      Key := #0;
end;

procedure TfrmPedido.edtValorProdKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', #13, #8, #44]) then
      Key := #0;
   if pos(',',edtValorProd.text) > 0 then
      if not (Key in ['0'..'9', #13, #8]) then
         Key := #0;
      //não entendi a função decimalSeparator
end;

procedure TfrmPedido.edtValorTotalKeyPress(Sender: TObject; var Key: Char);
begin
     if not (Key in ['0'..'9', #13, #8, #44]) then
      Key := #0;
end;

procedure TfrmPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
end;

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
     cdsTemporario.Active:=true;
end;

procedure TfrmPedido.FormDestroy(Sender: TObject);
begin
     frmPedido:=nil;
end;

procedure TfrmPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_F1 then
      btnLimparClick(Sender);
   if key = vk_F8 then
      btnPesqClienteClick(Sender);
   if key = vk_F9 then
      btnPesqProdClick(Sender);
   if key = vk_F10 then
      btnConfirmarClick(Sender);
   if (key = vk_F11) and (btnBuscaPedido.Visible) then
      btnBuscaPedidoClick(Sender);
   if (key = vk_F12) and (btnExcluir.Visible) then
      btnExcluirClick(Sender);


end;

procedure TfrmPedido.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #27 then    //tem que verificar o keyPreviw
       begin
         case application.MessageBox('Deseja realmente fechar a tela de pedido?', 'Confirmação', MB_yesno + MB_iconInformation) of
           mrNo, mrCancel: Application.MessageBox('retomando os testes.','Continuando...');
           mrYes: Close;
         end;
       end;
       if (Key = #13) then begin
         //Key := #0;
         Perform(Wm_NextDlgCtl,0,0);
       end;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
     cdsTemporario.Active:=true;
     blEditar:=false;
end;

procedure TfrmPedido.InsertPedidoNovo;      //////////////////////////////////////////// pedido novo
begin
with UniQuery do
      begin
         SQL.Clear;
         SQL.Add('Select numero_pedido as NumeroPedido from controle WHERE cod=1;');
         ExecSQL;
         NumeroPedido := UniQuery.FieldByName('NumeroPedido').AsInteger;
         SQL.Clear;
         SQL.add('insert into dados_gerais_pedido(num_pedido,cod_cli,data_emicao,valor_total)values(:num_pedido,:cod_cli,current_date,:valor_total);');
         ParamByName('num_pedido').AsInteger:=numeroPedido;
         ParamByName('cod_cli').AsInteger := StrToInt(edtCodCliente.Text);
         //ParamByName('data_emicao').AsDateTime := date;    // poderia usar a data do computador
         ParamByName('valor_total').AsFloat := StrToFloat(TiraPontos(edtValorTotal.Text));
         // update no sequencial/numero do pedido (ao certo não entendi o que seria um numero sequencial)
//         SQL.Add('UPDATE controle SET numero_pedido = numero_pedido+1 WHERE cod = 1;');
         ExecSQL;
         SQL.Clear;
         SQL.Text:='select * from clientes;';
         Open;
         ////  TEMPORARIO DATA-SET

         cdsTemporario.First;
         while not (cdsTemporario.EOF) do
         begin
            Close;
            SQL.Clear;
            SQL.Text:='select * from produtos_pedido where false;';
            SQL.Add('INSERT INTO');
            SQL.Add('produtos_pedido(');
            SQL.Add('num_pedido_geral,');
            SQL.Add('cod_produto,');
            SQL.Add('quantidade,');
            SQL.Add('valor_uni_pedido,');
            SQL.Add('valor_total_pedido)');
            SQL.Add(' VALUES(:num_pedido_geral,:cod_produto,:quantidade,:valor_uni_pedido,:valor_total_pedido );');
            ParamByName('num_pedido_geral').AsInteger := NumeroPedido;
            //FieldByName('num_pedido_geral').AsInteger := NumeroPedido;
            ParamByName('cod_produto').AsInteger := cdsTemporario.FieldByName('cod_produto').AsInteger;
            ParamByName('quantidade').AsInteger := cdsTemporario.FieldByName('quantidade').AsInteger;
            ParamByName('valor_uni_pedido').AsFloat := cdsTemporario.FieldByName('valor_uni_pedido').AsFloat;
            ParamByName('valor_total_pedido').AsFloat := cdsTemporario.FieldByName('valor_total_pedido').AsFloat;
            ExecSQL;
            cdsTemporario.Delete;
         end;
         ////  TEMPORARIO DATA-SET
         SQL.Clear;
         SQL.Add('UPDATE controle SET numero_pedido = numero_pedido+1 WHERE cod = 1;');
         ExecSQL;
         SQL.Text:='Select numero_pedido as NumeroPedido from controle WHERE cod=1;';
         Open;
      end;
end;

procedure TfrmPedido.LimpaConfirmado;
begin
     edtCodCliente.Clear;
     edtNomeCliente.Clear;
     edtCodProd.Clear;
     edtDescriProd.Clear;
     edtValorProd.Clear;
     edtQuantidade.Clear;
     edtValorTotal.Clear;
     if blCarregado=false then
        application.MessageBox(PChar('Pedido '+intToStr(numeroPedido)+' gravado com sucesso.'), 'Informativo.', MB_OK + MB_ICONINFORMATION)
        else
            application.MessageBox(PChar('Pedido '+IntToStr(numeroPedido)+' Atualizado com sucesso.'), 'Informativo.', MB_OK + MB_ICONINFORMATION);
     blCarregado:=false;
end;

procedure TfrmPedido.LimparEdits;
begin
     edtCodCliente.Clear;
     edtNomeCliente.Clear;
     edtCodProd.Clear;
     edtDescriProd.Clear;
     edtValorProd.Clear;
     edtQuantidade.Clear;
     edtValorTotal.Clear;
end;


procedure TfrmPedido.LimparTemporario;
begin
     while not (cdsTemporario.EOF) do
           cdsTemporario.Delete;
end;

function TfrmPedido.TiraPontos(texto: string): string;
begin
  While pos('.', Texto) <> 0 Do
    delete(Texto,pos('.', Texto),1);
  Result := Texto;
end;

procedure TfrmPedido.UpdatePedidoCarregado;
var
teste:integer;
  //I: TUniQuery;
  x:integer;
begin
with UniQuery do
      begin
         SQL.Clear;
         SQL.Add('Select numero_pedido as NumeroPedido from controle WHERE cod=1;');
         ExecSQL;
         //NumeroPedido := UniQuery.FieldByName('NumeroPedido').AsInteger;
         SQL.Clear;
         SQL.Add('UPDATE dados_gerais_pedido');
         SQL.Add('SET');
   {1}   SQL.Add('num_pedido=:num_pedido,');
   {2}   SQL.Add('cod_cli=:cod_cli,');
   {-}   SQL.Add('data_emicao=current_date,');
   {3}   SQL.Add('valor_total=:valor_total');
         SQL.Add('WHERE num_pedido=:num_pedido;');
   {1}   ParamByName('num_pedido').AsInteger:=numeroPedido;
   {2}   ParamByName('cod_cli').AsInteger := StrToInt(edtCodCliente.Text);
   {3}   ParamByName('valor_total').AsFloat := StrToFloat(TiraPontos(edtValorTotal.Text));
         ExecSQL;
         SQL.Clear;
         SQL.Text:='select * from clientes;';
         Open;
         //remover itens deletados do banco
         if item>=1 then
            for x := 0 to item do
               begin
                 SQL.Text:= 'SELECT * FROM produtos_pedido;';
                  Close;
                  sql.Clear;
                  sql.Add('DELETE FROM produtos_pedido');
                  SQL.Add('WHERE cod_ite_venda=:cod_ite_venda;');
         {0}      ParamByName('cod_ite_venda').AsInteger := ExcluirItem[x];
                  ExecSQL;
                  SQl.Add('SELECT * FROM produtos_pedido;');
                  Open;
                  ExcluirItem[x]:=0; // odiei fazer esse array, mas achei melhor do que deletar todos os itens do pedido e inserir de novo no pedido
               end;
         ////  TEMPORARIO DATA-SET
         cdsTemporario.First;
      while not (cdsTemporario.EOF) do
         begin
         if (cdsTemporario.FieldByName('cod_ite_venda').AsInteger>0) then
             begin
               Close;
               SQL.Clear;
               SQL.Text:='select * from produtos_pedido where false;';
               SQL.Add('UPDATE produtos_pedido');
               SQL.Add('SET');
         {1}   SQL.Add('num_pedido_geral=:num_pedido_geral,');
         {2}   SQL.Add('cod_produto=:cod_produto,');
         {3}   SQL.Add('quantidade=:quantidade,');
         {4}   SQL.Add('valor_uni_pedido=:valor_uni_pedido,');
         {5}   SQL.Add('valor_total_pedido=:valor_total_pedido');
               SQL.Add('WHERE cod_ite_venda=:cod_ite_venda;');
         {0}   ParamByName('cod_ite_venda').AsInteger := cdsTemporario.FieldByName('cod_ite_venda').AsInteger;

         {1}   ParamByName('num_pedido_geral').AsInteger := NumeroPedido;
         {2}   ParamByName('cod_produto').AsInteger := cdsTemporario.FieldByName('cod_produto').AsInteger;
         {3}   ParamByName('quantidade').AsInteger := cdsTemporario.FieldByName('quantidade').AsInteger;
         {4}   ParamByName('valor_uni_pedido').AsFloat := cdsTemporario.FieldByName('valor_uni_pedido').AsFloat;
         {5}   ParamByName('valor_total_pedido').AsFloat := cdsTemporario.FieldByName('valor_total_pedido').AsFloat;
               ExecSQL;
               cdsTemporario.Delete;
             end
             else
                begin
                  Close;
                  SQL.Clear;
                  SQL.Text:='select * from produtos_pedido where false;';
                  SQL.Add('INSERT INTO');
                  SQL.Add('produtos_pedido(');
                  SQL.Add('num_pedido_geral,');
                  SQL.Add('cod_produto,');
                  SQL.Add('quantidade,');
                  SQL.Add('valor_uni_pedido,');
                  SQL.Add('valor_total_pedido)');
                  SQL.Add(' VALUES(:num_pedido_geral,:cod_produto,:quantidade,:valor_uni_pedido,:valor_total_pedido );');
                  ParamByName('num_pedido_geral').AsInteger := NumeroPedido;
                  ParamByName('cod_produto').AsInteger := cdsTemporario.FieldByName('cod_produto').AsInteger;
                  ParamByName('quantidade').AsInteger := cdsTemporario.FieldByName('quantidade').AsInteger;
                  ParamByName('valor_uni_pedido').AsFloat := cdsTemporario.FieldByName('valor_uni_pedido').AsFloat;
                  ParamByName('valor_total_pedido').AsFloat := cdsTemporario.FieldByName('valor_total_pedido').AsFloat;
                  ExecSQL;
                  cdsTemporario.Delete;
                end;
         end;
         ////  TEMPORARIO DATA-SET
         SQL.Clear;
         SQL.Text:='Select numero_pedido as NumeroPedido from controle WHERE cod=1;';
         Open;
      end;

end;

function TfrmPedido.VerificarCampos: Boolean;
var
  cod_cli: boolean;
  cod_ite: boolean;
  quantidade: boolean;
  valor: boolean;
  descricaoItem:Boolean;
begin
  cod_cli := Trim(edtCodCliente.Text) <> EmptyStr;
  cod_ite := Trim(edtCodProd.Text) <> EmptyStr;
  quantidade := Trim(edtQuantidade.Text) <> EmptyStr;
  valor := Trim(edtValorProd.Text) <> EmptyStr;
  descricaoItem := Trim(edtDescriProd.Text) <> EmptyStr;
  result := cod_cli and cod_ite and valor and quantidade and descricaoItem;
end;

end.
