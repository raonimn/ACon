unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.Objects, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI;

type
  TForm1 = class(TForm)
    ActionList1: TActionList;
    PreviousTabAction1: TPreviousTabAction;
    TitleAction: TControlAction;
    NextTabAction1: TNextTabAction;
    TopToolBar: TToolBar;
    btnBack: TSpeedButton;
    ToolBarLabel: TLabel;
    btnNext: TSpeedButton;
    TabControl1: TTabControl;
    tab1: TTabItem;
    tab2: TTabItem;
    BottomToolBar: TToolBar;
    btn1: TSpeedButton;
    lv1: TListView;
    tab3: TTabItem;
    con1: TFDConnection;
    fdsqlite1: TFDPhysSQLiteDriverLink;
    fdwait1: TFDGUIxWaitCursor;
    fdqry1: TFDQuery;
    lvDet: TListView;
    pnl1: TPanel;
    lblEscola: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lblResp: TLabel;
    lblFone: TLabel;
    lblQtd: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure TitleActionUpdate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btn1Click(Sender: TObject);
    procedure lv1ItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure TabControl1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

procedure TForm1.TabControl1Change(Sender: TObject);
var
  item: TListViewItem;
begin
  case TabControl1.ActiveTab.Index of
    0:
      begin
        ToolBarLabel.Text := 'ACon - Pagina inicial'
      end;
    1:
      begin
        ToolBarLabel.Text := 'ACon - Configurações'
      end;
    2:
      begin
        ToolBarLabel.Text := 'ACon - Detalhes';
        item := lvDet.Items.Add;
        item.Text := 'MALOTES';
        item.Purpose := TListItemPurpose.Header;
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
        item := lvDet.Items.Add;
        item.Text := 'IP123456785BR';
      end;
  end;
end;

procedure TForm1.TitleActionUpdate(Sender: TObject);
begin
  if Sender is TCustomAction then
  begin
    if TabControl1.ActiveTab <> nil then
      TCustomAction(Sender).Text := TabControl1.ActiveTab.Text
    else
      TCustomAction(Sender).Text := '';
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  Cidades: TStringList;
  I: Integer;
  Item: TListViewItem;
begin
  Cidades := TStringList.Create;
  try
    con1.Connected := true;
    if con1.Connected then
    try
      fdqry1.SQL.Text := 'select Cidade from Geo_busca where Centralizadora = ' + quotedstr('01_PE_RCE') + ' GROUP BY Cidade order by Cidade;';
      fdqry1.Active := True;
      if fdqry1.RecordCount > 0 then
      begin
        fdqry1.First;
        while not fdqry1.eof do
        begin
          Cidades.Add(fdqry1.Fields[0].AsString);
          fdqry1.Next
        end;
      end
      else
      begin
        { Tratar caso não retorne cidade (?) }
      end;
      fdqry1.Active := False;
      for I := 0 to Cidades.Count - 1 do
      begin
        Item := lv1.Items.Add;
        Item.Text := Cidades[I];
        Item.Purpose := TListItemPurpose.Header;
        fdqry1.SQL.Text := 'SELECT Destinatario, Bairro from Geo_Busca where Centralizadora = ' + quotedstr('01_PE_RCE') + ' AND Cidade = ' + quotedstr(Cidades[I]) + ' ORDER BY Bairro';
        fdqry1.Active := True;
        if fdqry1.RecordCount > 0 then
        begin
          fdqry1.First;
          while not fdqry1.eof do
          begin
            Item := lv1.Items.Add;
            Item.Text := fdqry1.Fields[0].AsString;
            Item.Detail := fdqry1.Fields[1].AsString;
            fdqry1.Next
          end;
        end
        else
        begin
        { Tratar caso não retorne cidade (?) }
        end;
      end;
    finally
      con1.Connected := False;

    end;

  finally
    Cidades.Free;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Item: TListViewItem;
begin
  { This defines the default active tab at runtime }
  TabControl1.First(TTabTransition.None);
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkHardwareBack) and (TabControl1.TabIndex <> 0) then
  begin
    TabControl1.First;
    Key := 0;
  end;
end;

procedure TForm1.lv1ItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
{ Se o click for no botão de detalhes }
  if (assigned(ItemObject) and (ItemObject.Name = 'A')) then
    TabControl1.SetActiveTabWithTransition(tab3, TTabTransition.Slide);
end;

end.

