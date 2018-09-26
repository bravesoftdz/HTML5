program HTML5;

uses
  Vcl.Forms,
  Ana_ in 'Ana_.pas' {Form1},
  HTML5_Objects_ in 'HTML5_Objects_.pas',
  WebBrowser_Helper_ in 'WebBrowser_Helper_.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
