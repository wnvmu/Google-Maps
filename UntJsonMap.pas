unit UntJsonMap;

interface

uses Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  System.Generics.Collections, IdHTTPServer, IdContext, IdCustomHTTPServer, IWSystem;

type
  TJSON = class
    private
      HTTPServer: TIdHTTPServer;
      FMSG: String;
      FACAO: String;
      FCNPJ: String;
      FHORA: String;
      FIDUSUARIO: String;
      FIDACAO: String;
      FNOMEEMPRESA: String;
      FNOMEUSUARIO: String;
      FDATA: String;
      function URLAmbiente: String;
      procedure IdHTTPServer1CommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    public
      property MSG: String read FMSG write FMSG;
      property NOMEEMPRESA:String read FNOMEEMPRESA write FNOMEEMPRESA;
      property CNPJ:String read FCNPJ write FCNPJ;
      property ACAO:String read FACAO write FACAO;
      property IDACAO:String read FIDACAO write FIDACAO;
      property IDUSUARIO:String read FIDUSUARIO write FIDUSUARIO;
      property DATA:String read FDATA write FDATA;
      property HORA:String read FHORA write FHORA;
      property NOMEUSUARIO:String read FNOMEUSUARIO write FNOMEUSUARIO;
      function EnviarPost: Boolean;
      function CriarServerHTTP: Boolean;
      procedure Clear;
  end;

implementation

const APIMAP = 'AIzaSyDEUj6vrjF8FbqP6bA87ej7b4rCNo_zbU8';

{ TJSON }

procedure TJSON.Clear;
begin
  FMSG         := '';
  FNOMEEMPRESA := '';
  FCNPJ        := '';
  FACAO        := '';
  FIDACAO      := '';
  FIDUSUARIO   := '';
  FDATA        := '';
  FHORA        := '';
  FNOMEUSUARIO := '';
end;

function TJSON.CriarServerHTTP: Boolean;
begin
  HTTPServer := TIdHTTPServer.Create(nil);
  try
    HTTPserver.Bindings.Add.Port:=443;
    HTTPserver.Bindings.Add.Port:=8080;
    HTTPServer.DefaultPort  := 9191;
    HTTPServer.Active       := True;
    HTTPServer.OnCommandGet := IdHTTPServer1CommandGet;
  finally

  end;
end;

function TJSON.EnviarPost: Boolean;
var
  Json      : string;
  sResponse : string;
  Req_Json  : TStream;
  HTTP      : TIdHTTP;
  LHandler  : TIdSSLIOHandlerSocketOpenSSL;
begin
  Json := '';

  LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  HTTP     := TIdHTTP.Create(nil);
  Req_Json := TstringStream.Create('{'+Json+'}');
  try
      Req_Json.Position               := 0;
      HTTP.Request.UserAgent          := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
      HTTP.Request.Accept             := 'application/json, text/javascript, */*; q=0.01';
      HTTP.Request.ContentType        := 'application/vnd.ksql.v1+json';
      HTTP.Request.CharSet            := 'utf-8';
      HTTP.ReadTimeout                := 30000;
      HTTP.ProtocolVersion            := pv1_1;
      LHandler.SSLOptions.Method      := sslvSSLv23;
      LHandler.SSLOptions.Mode        := sslmClient;
      LHandler.SSLOptions.VerifyMode  := [];
      LHandler.SSLOptions.VerifyDepth := 0;
      HTTP.IOHandler                  := LHandler;
      HTTP.Request.CustomHeaders.Clear;
      sResponse := HTTP.Post(URLAmbiente, Req_Json);
      Result    := True;

      FMSG := ('HTTP: '+HTTP.ResponseText);
      FMSG := FMSG + (' JSON: '+sResponse);

      Req_Json.Free;
      LHandler.Free;
      HTTP.Free;
  except
    Result := False;
  end;
end;

procedure TJSON.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  var Caminho: String; arq: TextFile; Linha: TStringList; Texto: String;
begin
  Caminho := gsAppPath + 'ExportFile.kml';
  if ARequestInfo.Document = '/ExportFile.kml' then begin
    try
      AResponseInfo.ResponseNo := 200;
      AResponseInfo.ContentStream := TFileStream.Create(Caminho, fmOpenRead or fmShareDenyWrite);
      AResponseInfo.ContentType := HTTPServer.MIMETable.GetFileMIMEType(Caminho);
    finally

    end;

  end else
  if ARequestInfo.Document = '/' then
  begin
    Linha := TStringList.Create;
    try
      Linha.Clear;
      AssignFile(arq, Caminho);
      {$I-}
      Reset(arq);
      {$I+}
      while not Eof(arq) do
      begin
        ReadLn(arq, Texto);
        linha.Add(Texto);
      end;
      AResponseInfo.ContentText := Linha.Text;
    finally
      Closefile(arq);
      Linha.Free;
    end;
  end;
end;

function TJSON.URLAmbiente: String;
var Ambiente  : Integer;
begin
  Result := 'https://maps.googleapis.com/maps/api/js/xml?';
end;

end.
