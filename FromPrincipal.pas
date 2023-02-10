unit FromPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UntJsonMap, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.OleCtrls, SHDocVw;

type
  TFrmMaps = class(TForm)
    WebBrowser1: TWebBrowser;
    Panel1: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ExibirMapa;
  end;

var
  FrmMaps: TFrmMaps;

implementation

{$R *.dfm}

procedure TFrmMaps.Button1Click(Sender: TObject);
var JSON: TJSON;
begin
  JSON := TJSON.Create;
  try
    JSON.CriarServerHTTP;
    ExibirMapa;
  finally

  end;
 // ExibirMapa;
end;

procedure TFrmMaps.ExibirMapa;
var slXSL: TStringList;
const
  APIMAP = 'AIzaSyDEUj6vrjF8FbqP6bA87ej7b4rCNo_zbU8';
  APIMAP2 = 'AIzaSyB41DRUbKWJHPxaFjMAwdrzWzbVKartNGg';
begin
  try
    slXSL := TStringList.Create;
    slXSL.Add('<!doctype html><html lang="en"><head><meta charset="utf-8"><title>Geagro</title><script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>');
    slXSL.Add('<style rel="stylesheet" type="text/css">html,body {height: 100%;margin: 0;padding: 0;}#container {height: 100%;display: flex;}#sidebar {flex-basis: 15rem;flex-grow: 1;');
    slXSL.Add('padding: 1rem;max-width: 30rem;height: 100%;box-sizing: border-box;overflow: auto;display: none;}#map {flex-basis: 0;flex-grow: 4;height: 100%;}</style>');
    slXSL.Add('<script type="text/javascript">');
    slXSL.Add('function initMap() {');
    slXSL.Add('const map = new google.maps.Map(document.getElementById("map"), {');
    slXSL.Add('zoom: 13,');
    slXSL.Add('center: {');
    slXSL.Add('lat: -20.6033717,');
    slXSL.Add('lng: -41.2106458},');
    slXSL.Add('streetViewControl: false,mapTypeControl: true,mapTypeIds: ["satellite", "roadmap"]});');
    slXSL.Add('const kmlLayer = new google.maps.KmlLayer({');
    slXSL.Add('url: "https://raw.githubusercontent.com/wnvmu/wnvmu/main/Casa%20do%20Fim.kml",');
    slXSL.Add('suppressInfoWindows: true,map: map,});');
    slXSL.Add('kmlLayer.addListener("click", (kmlEvent) => {');
    slXSL.Add('const text = kmlEvent.featureData.description;');
    slXSL.Add('showInContentWindow(text);');
    slXSL.Add('if (sidebar.style.display === "block") {');
    slXSL.Add('sidebar.style.display = "none";');
    slXSL.Add('} else {');
    slXSL.Add('sidebar.style.display = "block";');
    slXSL.Add('}});');
    slXSL.Add('function showInContentWindow(text) {');
    slXSL.Add('const sidebar = document.getElementById("sidebar");');
    slXSL.Add('sidebar.innerHTML = text;');
    slXSL.Add('}}');
    slXSL.Add('</script>');
    slXSL.Add('</head>');
    slXSL.Add('<body><div id="container"><div id="map"></div><div id="sidebar" class="container"></div></div>');
    slXSL.Add('<script src="https://maps.googleapis.com/maps/api/js?key='+APIMAP2+'&callback=initMap&v=weekly" async></script>');
    slXSL.Add('</body></html>');

    {salva o arquivo Mapa.html no diretorio da Aplicação.}

    slXSL.SaveToFile(ExtractFilePath(Application.ExeName) + 'Mapa.html');
  finally
    FreeAndNil(slXSL);
  end;
end;

end.
