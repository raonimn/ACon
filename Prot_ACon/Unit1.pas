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
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI,
  FMX.ListBox, System.ioutils, IPPeerClient, REST.Backend.ServiceTypes, REST.Backend.MetaTypes,
  System.JSON, REST.Backend.KinveyServices, REST.Backend.Providers, REST.Backend.ServiceComponents,
  REST.Backend.KinveyProvider;

type
  TForm1 = class(TForm)
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
    pnl2: TPanel;
    grpGPS: TGroupBox;
    grpOpe: TGroupBox;
    btnMin: TSpeedButton;
    btnMed: TSpeedButton;
    btnMax: TSpeedButton;
    actlst1: TActionList;
    TitleAction: TControlAction;
    PreviousTabAction1: TPreviousTabAction;
    NextTabAction1: TNextTabAction;
    cbb1: TComboBox;
    lbl1: TLabel;
    lbl5: TLabel;
    cbb2: TComboBox;
    lbl6: TLabel;
    cbb3: TComboBox;
    KinveyProvider1: TKinveyProvider;
    BackendStorage1: TBackendStorage;
    procedure FormCreate(Sender: TObject);
    procedure TitleActionUpdate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btn1Click(Sender: TObject);
    procedure lv1ItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure TabControl1Change(Sender: TObject);
    procedure con1BeforeConnect(Sender: TObject);
    procedure cbb2Change(Sender: TObject);
  private
    procedure FillCent;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

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
  aCentr: string;
begin
  aCentr := cbb3.Items[cbb3.ItemIndex];
  Cidades := TStringList.Create;
  try
    con1.Connected := true;
    if con1.Connected then
    try
      fdqry1.SQL.Text := 'SELECT Cidade FROM Geo_busca WHERE Centralizadora = ' + quotedstr(aCentr) + ' GROUP BY Cidade order by Cidade;';
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
      lv1.Items.Clear;
      for I := 0 to Cidades.Count - 1 do
      begin
        Item := lv1.Items.Add;
        Item.Text := Cidades[I];
        Item.Purpose := TListItemPurpose.Header;
        fdqry1.SQL.Text := 'SELECT Destinatario, Bairro from Geo_Busca WHERE Centralizadora = ' + quotedstr(aCentr) + ' AND Cidade = ' + quotedstr(Cidades[I]) + ' ORDER BY Bairro';
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
        { Tratar caso não retorne as escolas (?) }
        end;
      end;
    finally
      con1.Connected := False;

    end;

  finally
    Cidades.Free;
  end;

end;

procedure TForm1.cbb2Change(Sender: TObject);
{var
 LJSONArray: TJSONArray;
  LItem: TListViewItem;
  I: Integer;
  LQuery: string;

 }
begin
  FillCent;
//  LQuery := Format('query={"SE":"%s"}', [cbb2.Items[cbb2.ItemIndex]]);
{  LJSONArray := TJSONArray.Create;
  try
    BackendStorage1.Storage.QueryObjects('GeoData', [LQuery], LJSONArray);
    lv1.Items.Clear;
    for I := 0 to LJSONArray.Count - 1 do
    begin
      LItem := lv1.Items.Add;
      LItem.Text := (LJSONArray.Items[I].GetValue < string > ('DESTINATARIO'));
    end;
  finally
    LJSONArray.Free;
  end;

}
end;

procedure TForm1.con1BeforeConnect(Sender: TObject);
begin
  {$IFDEF ANDROID}
  con1.Params.Values['Database'] := TPath.GetDocumentsPath + PathDelim + 'BD_remoto.db';
  {$ENDIF}
end;

procedure TForm1.FillCent;
var
  LJSONArray: TJSONArray;
  LItem: TListViewItem;
  I: Integer;
  LQuery: string;
begin

  LQuery := Format('query={"SE":"%s"}', [cbb2.Items[cbb2.ItemIndex]]);
  LJSONArray := TJSONArray.Create;
  try
    BackendStorage1.Storage.QueryObjects('CentData', [LQuery], LJSONArray);
    cbb3.Items.Clear;
    for I := 0 to LJSONArray.Count - 1 do
    begin
      cbb3.Items.Add(LJSONArray.Items[I].GetValue < string > ('CENTRALIZADORA'));
    end;
  finally
    LJSONArray.Free;
  end;
  if cbb3.Items.Count > 0 then
    cbb3.ItemIndex := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Item: TListViewItem;
begin
  { This defines the default active tab at runtime }
  TabControl1.First(TTabTransition.None);
  try
    con1.Connected := true;
    if con1.connected then
      fdqry1.ExecSQL;
  finally
    fdqry1.SQL.Clear;
    con1.Connected := false;
  end;

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

