//---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------

unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, System.Sensors, FMX.StdCtrls,
  FMX.Edit, FMX.WebBrowser, FMX.ListBox, FMX.Layouts, System.Sensors.Components,
  FMX.Controls.Presentation, FMX.EditBox, FMX.NumberBox, system.math, system.notification;

type
  TLocationForm = class(TForm)
    LocationSensor1: TLocationSensor;
    WebBrowser1: TWebBrowser;
    ListBox1: TListBox;
    lbLocationSensor: TListBoxItem;
    swLocationSensorActive: TSwitch;
    lbTriggerDistance: TListBoxItem;
    nbTriggerDistance: TNumberBox;
    Button1: TButton;
    Button2: TButton;
    lbAccuracy: TListBoxItem;
    Button3: TButton;
    Button4: TButton;
    nbAccuracy: TNumberBox;
    lbLatitude: TListBoxItem;
    lbLongitude: TListBoxItem;
    ToolBar1: TToolBar;
    Label1: TLabel;
    NC1: TNotificationCenter;
    lbl1: TLabel;
    btn1: TButton;
    swtch1: TSwitch;
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure swLocationSensorActiveSwitch(Sender: TObject);
    procedure nbTriggerDistanceChange(Sender: TObject);
    procedure nbAccuracyChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    var
      locais: Tstringlist;
      latAtual, lonAtual: Double;
    procedure procuraPonto(lat1, long1: Double);
    function calcDistancia(lat1, lon1, lat2, lon2: double): Double;
    procedure criaNotificacao(nome, detalhe: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LocationForm: TLocationForm;

implementation

{$R *.fmx}

procedure TLocationForm.criaNotificacao(nome, detalhe: string);
var
  MyNotification: TNotification;
begin
  // Create an instance of TNotification
  MyNotification := NC1.CreateNotification;
  try
    MyNotification.Name := nome;
      // --- your code goes here ---
      // Set the icon or notification number
//    MyNotification.Number := 18;
      // Set the alert message
    MyNotification.AlertBody := detalhe;
    MyNotification.EnableSound := True;
      // Note: You must send the notification to the notification center for the Icon Badge Number to be displayed.
    NC1.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf;
  end;
end;

procedure TLocationForm.FormCreate(Sender: TObject);
begin
  if not Assigned(locais) then
    locais := TStringList.Create;
{
  locais.add('-8,0588643|-34,92507090000004|Correios');
  locais.add('-8,040787|-34,91034400000001|Carrefour');
  locais.add('-8,0538735|-34,92006739999999|Souza Leao');
  locais.add('-8,043171|-34,908338000000015|Atacado dos presentes');
 }
  locais.add('-8,043171|-34,908338000000015|Atacado dos presentes');
  locais.add('-8,029650400000001|-34,91635600000001|Mainha');
  locais.add('-8,040439899999999|-34,910154000000034|Carrefour');
  locais.add('-8,022122599999998|-34,9196824|Kinitos');

end;

procedure TLocationForm.btn1Click(Sender: TObject);
begin
  showmessage(FormatFloat('0.,####', latAtual) + ' - ' + FormatFloat('0.,####', lonAtual));
  ShowMessage(FormatFloat('0.,####', calcDistancia(latAtual, lonAtual, -8.040787, -34.91034400000001)));
end;

procedure TLocationForm.Button1Click(Sender: TObject);
begin
  nbTriggerDistance.Value := nbTriggerDistance.Value - 1;
end;

procedure TLocationForm.Button2Click(Sender: TObject);
begin
  nbTriggerDistance.Value := nbTriggerDistance.Value + 1;
end;

procedure TLocationForm.Button3Click(Sender: TObject);
begin
  nbAccuracy.Value := nbAccuracy.Value - 1;
end;

procedure TLocationForm.Button4Click(Sender: TObject);
begin
  nbAccuracy.Value := nbAccuracy.Value + 1;
end;

procedure TLocationForm.LocationSensor1LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
const
  LGoogleMapsURL: string = 'https://maps.google.com/maps?q=%s,%s';
var
  ENUSLat, ENUSLong: string; // holders for URL strings
begin
  ENUSLat := NewLocation.Latitude.ToString(ffGeneral, 5, 8, TFormatSettings.Create('en-US'));
  ENUSLong := NewLocation.Longitude.ToString(ffGeneral, 5, 8, TFormatSettings.Create('en-US'));
  { convert the location to latitude and longitude }

//  lbLatitude.Text := 'Latitude: ' + ENUSLat;
//  lbLongitude.Text := 'Longitude: ' + ENUSLong;
  lbLatitude.Text := 'Latitude: ' + FormatFloat('0.########', NewLocation.Latitude);
  lbLongitude.Text := 'Longitude: ' + FormatFloat('0.########', NewLocation.Longitude);

  latAtual := NewLocation.Latitude;
  lonAtual := NewLocation.Longitude;

 // lbl1.text := FloatToStr(calcdistancia(ENUSLat, ENUSLong, strtofloat(edt3.Text), strtofloat(edt4.Text)));
  procuraPonto(NewLocation.Latitude, NewLocation.Longitude);
  { and track the location via Google Maps }
  if (swtch1.IsChecked = True) then
    WebBrowser1.Navigate(Format(LGoogleMapsURL, [ENUSLat, ENUSLong]));
end;

procedure TLocationForm.procuraPonto(lat1, long1: Double);
var
  percorre: tstringlist;
  I: Integer;
  distancia, perto: double;
  local: string;
begin
  percorre := TStringList.Create;
  percorre.StrictDelimiter := true;
  percorre.Delimiter := '|';
  for I := 0 to locais.Count - 1 do
  begin
    percorre.DelimitedText := locais[I];
    distancia := calcDistancia(lat1, long1, StrToFloat(percorre[0]), StrToFloat(percorre[1]));
    if perto <= 0 then
      perto := distancia;
    if distancia <= perto then
    begin
      perto := distancia;
      local := percorre[2];
    end;

    if distancia <= 120 then
    { Dispara notificação de perto do local}
      criaNotificacao('Local Próximo', percorre[2] + ' está a ' + FormatFloat('0.####', distancia) + ' metros de você!');

  end;
  lbl1.Text := local + ' - ' + FormatFloat('0,.##', perto) + ' metros.';

  percorre.Free;
end;

procedure TLocationForm.nbAccuracyChange(Sender: TObject);
begin
  { set the precision }
  LocationSensor1.Accuracy := nbAccuracy.Value;
end;

procedure TLocationForm.nbTriggerDistanceChange(Sender: TObject);
begin
  { set the triggering distance }
  LocationSensor1.Distance := nbTriggerDistance.Value;
end;

procedure TLocationForm.swLocationSensorActiveSwitch(Sender: TObject);
begin
  { activate or deactivate the location sensor }
  LocationSensor1.Active := swLocationSensorActive.IsChecked;
end;

function TLocationForm.calcDistancia(lat1, lon1, lat2, lon2: double): Double;
const
  R: Double = 6378.137;   // Radius of earth in KM
var
  dLat, dLon, a, c, d: double;
begin
  dLat := lat2 * PI / 180 - lat1 * PI / 180;
  dLon := lon2 * PI / 180 - lon1 * PI / 180;
  a := sin(dLat / 2) * sin(dLat / 2) + cos(lat1 * PI / 180) * cos(lat2 * PI / 180) * sin(dLon / 2) * sin(dLon / 2);
  c := 2 * arctan2(sqrt(a), sqrt(1 - a));
  d := R * c;
  Result := d * 1000; // meters

end;

end.

