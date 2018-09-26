unit Ana_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw,


    HTML5_Objects_
  , WebBrowser_Helper_
  ;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    PG: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    WB: TWebBrowser;
    Panel2: TPanel;
    MM_Orjinal: TMemo;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    MM_Modified: TMemo;
    Panel5: TPanel;
    BT_ConvertToString: TButton;
    Splitter2: TSplitter;
    Panel6: TPanel;
    Panel1: TPanel;
    BT_Test: TButton;
    BT_RunHTML: TButton;
    MM_HTML: TMemo;
    BT_Clear_Tools: TButton;
    BT_Copy: TButton;
    procedure BT_Klik(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BT_Klik(Sender: TObject);
var
  X: THTML5;
  L: TStringList;
  I: Integer;
begin
  { Bazı örnekler için şu siteleri inceleyin
    https://html5demos.com/
    https://www.html5canvastutorials.com/
    https://www.webucator.com/tutorial/learn-html5/html5-canvas.cfm
    http://www.chiptune.com/starfield/starfield.html
    http://andrew.wang-hoyer.com/
    http://andrew.wang-hoyer.com/experiments/particle_system/particles.html
  }
  if (Sender = BT_Copy) then begin
      MM_Modified.SelectAll;
      MM_Modified.CopyToClipboard;
  end else
  if (Sender = BT_Clear_Tools) then begin
      MM_HTML.Clear;
  end else
  if (Sender = BT_ConvertToString) then begin
      L := TStringList.Create;
      L.Text := StringReplace(MM_Orjinal.Text, #39, #39#39, [rfReplaceAll]);
      for I := 0 to L.Count - 1 do L.Strings[I] := '+'#39+L.Strings[I]+#39+'#13#10';
      MM_Modified.Text := L.Text;
  end else
  if (Sender = BT_RunHTML) then begin
      WB.RunHTML(MM_HTML.Text, Application);
  end else
  if (Sender = BT_Test) then begin
      WB.RunHTML( X.HTML (X
                  .New
                  .HEAD (X
                        .New
                        .Title('Başlık')
                        .Base('http://www.potansif.com/')
                        .Link('stylesheet', 'style.css')
                        .Meta([ X.Attr('charset','UTF-8') ]                                                     )
                        .Meta([ X.Attr('name','author')         , X.Attr('content','Uğur PARLAYAN') ]           )
                        .Meta([ X.Attr('name','description')    , X.Attr('content','Free Web tutorials') ]      )
                        .Meta([ X.Attr('name','keywords')       , X.Attr('content','HTML,CSS,XML,JavaScript') ] )
                        .Meta([ X.Attr('http-equiv','refresh')  , X.Attr('content','30') ]                      )
                        )
                  .BODY (X
                        .New
                        .H1('test')
                        .H2('mest')
                        .P('jest')
                        )
                  ).toString
                , Application);
  end;
end;

end.
