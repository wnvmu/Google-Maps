program Maps;

uses
  Vcl.Forms,
  FromPrincipal in 'FromPrincipal.pas' {FrmMaps},
  UntJsonMap in 'UntJsonMap.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMaps, FrmMaps);
  Application.Run;
end.
