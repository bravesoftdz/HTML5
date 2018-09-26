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
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    BT_GO: TButton;
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
    BT_Convert: TButton;
    MM_HTML: TMemo;
    Splitter2: TSplitter;
    BT_RunHTML: TButton;
    procedure BT_GOClick(Sender: TObject);
    procedure BT_ConvertClick(Sender: TObject);
    procedure BT_RunHTMLClick(Sender: TObject);
    procedure MM_HTMLDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BT_ConvertClick(Sender: TObject);
var
  S: String;
  L: TStringList;
  I: Integer;
begin
  //

  S := MM_Orjinal.Text;
  S := StringReplace(S,#39,#39#39,[rfReplaceAll]);
  L := TStringList.Create;
  L.Text := S;
  for I := 0 to L.Count - 1 do begin
      L.Strings[I] := '+'#39+L.Strings[I]+#39+'#13#10';
  end;
  MM_Modified.Text := L.Text;
end;

procedure TForm1.BT_GOClick(Sender: TObject);
var
  S: String;
  X: THTML5;
begin
  S := X.HTML (X
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
              ).toString;
              ;
  //WB.RunHTML(S, Application);
  (*
  WB.RunHTML( '<!DOCTYPE html>'    // -> HTML5
            + '<html>'
            + '<body>'
            + '<svg height="150" width="400">'    // Bir vektörel Grafik (SVG)
            + '  <defs>'
            + '    <radialGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">'
            + '      <stop offset="0%" style="stop-color:rgb(255,255,0);stop-opacity:1" />'
            + '      <stop offset="100%" style="stop-color:rgb(255,0,0);stop-opacity:1" />'
            + '    </radialGradient>'
            + '  </defs>'
            + '  <rect width="300" height="100" style="fill:rgb(0,0,255);stroke-width:3;stroke:rgb(0,0,0)" />'        // Dikdörtgen (Vektör bazlıdır...)
            + '  <ellipse cx="200" cy="70" rx="85" ry="55" stroke="black" stroke-width="4" fill="url(#grad1)" />'     // Elips
            + '  <text fill="#ffffff" font-size="20" font-family="Calibri" x="140" y="80">Uğur PARLAYAN</text>'       // metin
            + '  Maalesef, tarayıcınız satır içi SVG desteklemiyor.'
            + '</svg>'
            + '<canvas id="myCanvas" width="200" height="100" style="border:1px solid #000000;"></canvas>'            // Canvas bir dikdörtgen (pixel bazlıdır...)
            + '<img alt="32x32 Rubicube Logo" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAIAAAD8GO2jAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAYdEVYdF' // bir PNG resim dosyası...
            + 'NvZnR3YXJlAHBhaW50Lm5ldCA0LjAuNWWFMmUAAAUNSURBVEhLlZZ9UNNlAMcf3rKgSKFICSUUKoo/KvPy+sPyqn+EozquspArhMISeTFizHivMd7GeBsCG8OBUEAiDGy8CAxTYMaGsCGvEw4HHDBIEETkrWc9j7/9+G0D+t7nOI7bPp+D5z'
            + 'n2A+vb2/TiMv7uf25bgTrVfYtc6XtlctHwzBr+2Xa3daBieO7J/G7AuQlSr0PeKOr4vW9qeXW7oS0CRYP3TPndgKcAmRIUQBzIb8/uGl9cXsWvM7zNArm9M8Z5Co0dktFGDiB2c292Ty/gVxuYwUCt6r4RUiPSWyl2hLBH1dnZOTU1tbys/x'
            + 'boD6hUKp+yG1o7JK2FokYwSkXNYnF/f//AwMDExMTS0hJWPJ6ewMLCgkQiOZxZvSGgo0YwSnCA2NjY2OLiInbpBubn59VqdUNDg3NWg9bOlVO8BDAgbmrCbtJmZ2eRcEMA2eGEwkrb7BZsz5YBXyY4HgZ+4gOWWDfQpC8wPT2NnNrAysoKss'
            + 'MVFxeZczs0dmg5TrP3+vxZDy9wzBe4fw/8ksEvVRsCjY3YStrk5CTSagPwfLBereZweRo74wr4+LRHxNHBW2byVhMW3/Gd065Grr6a0ld0EHoB/kIw0KgvMD4+jrTawIMHD7Beraan5cD3m7n7xOW5qAfAaDfo/xtTX2vpxzz0/BeeMONwkp'
            + '7/RwU8MGwlDd5DpNUGiAMYHR2NYTA+/fHUldrd0A5RKbQBxG2JsaDEsb4mvEDAP0ens5KTRSJRb28v1vf3j4yMIK02AM8d2pVKZXx8fGKc54j8GWSH3JVTAwTJTI9guufZ0O+CAgNhqbCgQNreDgNDQ0NIqw3MzMzIpNKf6XTmUdfKdCfCDh'
            + 'nponoJ4jlOgWyn6KLXw88fCY35MjgoIDgoKCUlBR4M0uLA2tpaTU1NmP8ZoePhEvBCc8IT5MBwJ9VLEJdjiwKIKMGbdNaxbF4S/GMgMw7AO9pSXNps9dotsJcPbGQFpuTAUAfVS0AJPMZFcNV7dW1FG5i/JpFbOkM7JAM8N1BvTA7ckVG9BA'
            + 'YCGhYe/qMNjJ6NRXZIgpHVhMKIHBiUUr0EmwTUc5pzxoE7bt8QgXjrnWS7Ugr++hN0t1LVCE0gRX/g7lSnNtDz8hFkbwd2bBd8Qcdvg8ZKwM8Aeemar5cEoLkKKG5QAwEGAgOj13Bg7dGjTlMHFGgGL/I+soD2DjG4mKNR61KWD5qEQH59i0'
            + 'DXUBUOPOxVIjtEBPbw3MwrCqlSvVzg7aCx9wWw9AckvRdxYFZYj+xSsFcAbCLBrohdlnHvmqf5mHETjShSRCr7KVrinlNxB3yiHLzo9iejHGCGznMmB8RdWTgwmZQD7XXAFl7QJGCNYAKrWGAVYbIzxunpJPcdWWEm/6mN01L2hSTY+TH2e0'
            + 'c6eIXZn6BtwDvCwT/ZMSz3VRgQtTNxoO9b+FFiQ6gpJAJrBrCKNrPJSQrnZEZHxvn7RLxC8epCY78v7SPO4N6ssrpWHBJZ+PYHLFNqKdnCLtPtMy47NS+Px+XmZmZmsFKSIn8NDI76xPfcwRO0l8jeH2LfElRGDo7I4NWBZhwgb2l2TlldJw'
            + '6JKjz0IXf/watRTB6HA9W6ZGefT09PYyZG02K+zijy5/x2pqOnYWWV+vBCDVAGP4Xa2lovXy7n8/MoAURVlVChUMD/lfgNOtsiQAw+icB/8a2tLeXll2CstLRUJpMSjw6bbLsB8nSfrgxuff1fnEkfInYK53IAAAAASUVORK5CYII=">'
            + '</body>'
            + '</html>'
            , Application
            );
            *)
  WB.RunHTML( '<!DOCTYPE HTML>'#13#10
+'<html>'#13#10
+''#13#10
+'<head>'#13#10
+'<meta charset="UTF-8">'#13#10
+'<title>Canvas Shape and Color Effects</title>'#13#10
+'<style type="text/css">'#13#10
+''#13#10
+'body{'#13#10
+'  overflow:hidden;'#13#10
+'  background:#000;'#13#10
+'}'#13#10
+'canvas{'#13#10
+'  width:100vw;'#13#10
+'  height:100vh;'#13#10
+'}'#13#10
+''#13#10
+'</style>'#13#10
+''#13#10
+'<body>'#13#10
+'	'#13#10
+''#13#10
+'	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>'#13#10
+'	'#13#10
+'	<script>'#13#10
+''#13#10
+'//pure js & canvas > no library'#13#10
+''#13#10
+'var c = document.createElement("canvas"),'#13#10
+'	 $ = c.getContext("2d");'#13#10
+''#13#10
+'var w = window.innerWidth,'#13#10
+'	 h = window.innerHeight;'#13#10
+''#13#10
+'c.width = w;'#13#10
+'c.height = h;'#13#10
+''#13#10
+'c.addEventListener("mousedown", mouseDown, true);'#13#10
+''#13#10
+'document.body.appendChild(c);'#13#10
+''#13#10
+'var part;  //particle '#13#10
+'var meshW = 100;  //mesh width'#13#10
+'var dispX = -50;  //x disposition'#13#10
+'var dispY = -100;  //y disposition'#13#10
+'var partX = 0;  //particle x'#13#10
+'var partY = 0;  //particle y'#13#10
+'var partIndX = 0;  //particle index x'#13#10
+'var partIndY = 0;  //particle index y'#13#10
+''#13#10
+'var col0 = "rgb(74, 1, ";  //shading color-starts'#13#10
+'var col1 = "rgb(0, 3, ";'#13#10
+''#13#10
+'var partList = [];  //particle array'#13#10
+'var gridW = w + meshW;   //grid width '#13#10
+'var gridH = h + meshW * 2;  //grid height'#13#10
+''#13#10
+'while(partY < gridH)'#13#10
+'{'#13#10
+'	while(partX < gridW)'#13#10
+'	{'#13#10
+'		part = new Object(partX, partY, partIndX, partIndY);'#13#10
+'		partList.push(part);'#13#10
+''#13#10
+'		partX += meshW;'#13#10
+'		partIndX++;'#13#10
+'	}'#13#10
+'	'#13#10
+'	partX = 0;'#13#10
+'	partIndX = 0;'#13#10
+'	partY += meshW;'#13#10
+'	partIndY++;'#13#10
+'}'#13#10
+''#13#10
+''#13#10
+'var partArrayL= partList.length;'#13#10
+'var rowCt = Math.ceil( gridW / meshW );  //row count'#13#10
+'var colCt = Math.ceil( gridH / meshW );  //column count'#13#10
+''#13#10
+'$.clearRect(0, 0, w, h);'#13#10
+''#13#10
+'for(var i = 0; i < partArrayL; ++i)'#13#10
+'{'#13#10
+'	part = partList[i];'#13#10
+'	part.next = partList[i + 1];'#13#10
+'	'#13#10
+'	if(part.indX % rowCt != rowCt - 1 && part.indY != colCt - 1)'#13#10
+'	{'#13#10
+'		part.connectAll.push(partList[i + 1]);'#13#10
+'		part.connectAll.push(partList[i + rowCt + 1]);'#13#10
+'		part.connectAll.push(partList[i + rowCt]);'#13#10
+'		part.ready();'#13#10
+'	}'#13#10
+'}'#13#10
+''#13#10
+'var int = setInterval(intHandler, 1000 / 30);'#13#10
+''#13#10
+'function mouseDown()'#13#10
+'{'#13#10
+'	if(int != undefined)'#13#10
+'	{'#13#10
+'		clearInterval(int);'#13#10
+'		int = undefined;'#13#10
+'	}'#13#10
+'	else'#13#10
+'	{'#13#10
+'		int = setInterval(intHandler, 1000 / 30);		'#13#10
+'	}'#13#10
+'}'#13#10
+''#13#10
+'part = partList[0];'#13#10
+''#13#10
+'function intHandler()'#13#10
+'{'#13#10
+'	$.clearRect(0, 0, w, h);'#13#10
+'	'#13#10
+'	while(part != undefined)'#13#10
+'	{'#13#10
+'		part.draw();'#13#10
+'		part = part.next;'#13#10
+'	}'#13#10
+'	'#13#10
+'	part = partList[0];'#13#10
+'	'#13#10
+'	while(part != undefined)'#13#10
+'	{'#13#10
+'		part.fill();'#13#10
+'		part = part.next;'#13#10
+'	}'#13#10
+'	'#13#10
+'	part = partList[0];'#13#10
+'}'#13#10
+''#13#10
+'function Object(pX, pY, pIndX, pIndY)'#13#10
+'{'#13#10
+'	this.distort = 50;'#13#10
+'	'#13#10
+'	this.x = dispX + pX + ( Math.random() - Math.random() ) * this.distort;'#13#10
+'	this.y = dispY + pY + ( Math.random() - Math.random() ) * this.distort;'#13#10
+'	this.indX = pIndX;'#13#10
+'	this.indY = pIndY;'#13#10
+'	this.color = "hsla(261, 55%, 5%, 1)";  //part border color'#13#10
+'		'#13#10
+'	this.size = 2;'#13#10
+'	this.next = undefined;'#13#10
+'	'#13#10
+'	this.tracker = (Math.PI / 2) + this.indX * .5;'#13#10
+'	this.diffX = Math.random();'#13#10
+'	this.diffY = Math.random();'#13#10
+'	this.speed = .1;'#13#10
+'	this.vol = 30;  //volume  (higher #, more movement)'#13#10
+'	'#13#10
+'	this.colRngDiff = 70;  //shading variation'#13#10
+'  //color range > changing the 225 to vals between 0 and 255, as well as the color range difference # above,  will change base color'#13#10
+'	this.colRng = (225 - this.colRngDiff) + Math.floor(Math.random() * this.colRngDiff);'#13#10
+'	'#13#10
+'	this.draw = function()'#13#10
+'	{	'#13#10
+'		this.tracker += this.speed;'#13#10
+'		this.tracker = this.tracker == 1 ? 0 : this.tracker;'#13#10
+'		'#13#10
+'		this.x += (Math.sin( this.tracker ) * this.speed) * this.vol;'#13#10
+'		this.y += (Math.cos( this.tracker ) * this.speed) * this.vol;'#13#10
+'		'#13#10
+'	}'#13#10
+''#13#10
+'	this.readyW = 0;  //start point'#13#10
+'	this.readyW1 = 0;'#13#10
+''#13#10
+'	this.ready = function()'#13#10
+'	{'#13#10
+'		this.readyW = Math.abs(this.connectAll[0].x - this.x);'#13#10
+'		this.readyW1 = Math.abs(this.connectAll[1].x - this.connectAll[2].x);'#13#10
+'	}'#13#10
+''#13#10
+'	'#13#10
+'	this.connectAll = [];'#13#10
+'	'#13#10
+'	this.connect = function()'#13#10
+'	{'#13#10
+'		if(this.connectAll.length > 0)'#13#10
+'		{			'#13#10
+'			$.beginPath();'#13#10
+'			$.strokeStyle = this.color;'#13#10
+'			$.moveTo(this.x, this.y);'#13#10
+'	'#13#10
+'			for(var j = 0; j < this.connectAll.length; ++j)	'#13#10
+'				$.lineTo(this.connectAll[j].x, this.connectAll[j].y);'#13#10
+'					'#13#10
+'			$.lineTo(this.x, this.y);'#13#10
+'			$.lineTo(this.connectAll[1].x, this.connectAll[1].y);'#13#10
+'			$.stroke();'#13#10
+'		}'#13#10
+'	}'#13#10
+'	'#13#10
+'	this.calcW = 0;'#13#10
+'	this.calcW1 = 0;'#13#10
+'	'#13#10
+'	this.fill = function()'#13#10
+'	{		'#13#10
+'		if(this.connectAll.length > 0)'#13#10
+'		{	'#13#10
+'			this.calcW = Math.abs(this.connectAll[0].x - this.x);'#13#10
+'			this.calcW1 = Math.abs(this.connectAll[1].x - this.connectAll[2].x);	'#13#10
+'						'#13#10
+'			$.beginPath();'#13#10
+'			$.fillStyle = col0 + (Math.floor((this.readyW / this.calcW) * this.colRng)).toString() + ")";'#13#10
+'			'#13#10
+'			$.moveTo(this.x, this.y);'#13#10
+'			$.lineTo(this.connectAll[2].x, this.connectAll[2].y);'#13#10
+'			$.lineTo(this.connectAll[1].x, this.connectAll[1].y);'#13#10
+'			$.lineTo(this.x, this.y);'#13#10
+'			'#13#10
+'			$.fill();'#13#10
+'			'#13#10
+'			'#13#10
+'			$.beginPath();'#13#10
+'			$.fillStyle = col1 + (Math.floor((this.readyW1 / this.calcW1) * this.colRng)).toString() + ")";'#13#10
+'			'#13#10
+'			$.moveTo(this.x, this.y);'#13#10
+'			$.lineTo(this.connectAll[1].x, this.connectAll[1].y);'#13#10
+'			$.lineTo(this.connectAll[0].x, this.connectAll[0].y);'#13#10
+'			$.lineTo(this.x, this.y);'#13#10
+'			'#13#10
+'			$.fill();'#13#10
+'		}		'#13#10
+'	}'#13#10
+'	'#13#10
+'}'#13#10
+''#13#10
+''#13#10
+' '#13#10
+'  </script>'#13#10
+'	'#13#10
+'</body>      '#13#10

, Application
);

end;

procedure TForm1.BT_RunHTMLClick(Sender: TObject);
begin
  {
    Bazı örnekler için şu sitelere bakın;

    https://www.html5canvastutorials.com/
    https://html5demos.com/
    https://www.webucator.com/tutorial/learn-html5/html5-canvas.cfm

    view-source:http://www.chiptune.com/starfield/starfield.html

    http://andrew.wang-hoyer.com/
    view-source:http://andrew.wang-hoyer.com/experiments/particle_system/particles.html



  }
  WB.RunHTML(MM_HTML.Text, Application);
end;

procedure TForm1.MM_HTMLDblClick(Sender: TObject);
begin
  MM_HTML.Clear;
end;

end.
