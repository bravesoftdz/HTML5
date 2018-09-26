unit HTML5_Objects_;

interface

type
  THTML5 = record
    type
      TStringArray = Array of String;
      TStringArray_Helper = record helper for TStringArray
        function toString(aSplitter: String = ''): string;
      end;
    strict private
      _HTML: string;
      function iif(aKosul: Boolean; aTrue, aFalse: String): String;
      function tag(aTagName: String; aValue: String; aAttributes: TStringArray = []; aSelfClosable: Boolean = True; aNoClose: Boolean = False): string;
    public
      function Attr(aKey, aValue: string): string;
      function toString: String;
      function New: THTML5;
      function HTML(aValue: THTML5): THTML5;
      function HEAD(aValue: THTML5): THTML5;
      function Base(aHref: String; aTarget: String = '_blank'): THTML5;
      function Link(aRef: String; aHref: String): THTML5;
      function Script(aSrc: string; aScript: String = ''): THTML5;
      function Meta(aAttributes: TStringArray): THTML5;
      function BODY(aValue: THTML5): THTML5;
      function HEADER(aValue: THTML5): THTML5;
      function FOOTER(aValue: THTML5): THTML5;
      function Article(aValue: THTML5): THTML5;
      function Main(aValue: THTML5): THTML5;
      function H1(aValue: String): THTML5;
      function H2(aValue: String): THTML5;
      function H3(aValue: String): THTML5;
      function H4(aValue: String): THTML5;
      function H5(aValue: String): THTML5;
      function H6(aValue: String): THTML5;
      function P(aValue: String): THTML5;
      function Mark(aValue: String): THTML5;
      function Title(aValue: String): THTML5;
      function Meter(aValue, aMin, aMax: Integer; aText: string = ''): THTML5;
  end;

implementation

uses
    System.SysUtils             //
  ;

{ THTML5.TStringArray_Helper }

function THTML5.TStringArray_Helper.toString(aSplitter: String = ''): string;
var
  S: String;
begin
  for S in Self do
      Result := Result + S.Trim + aSplitter;
end;

{ THTML5 }

function THTML5.iif(aKosul: Boolean; aTrue, aFalse: String): String;
begin
  case aKosul of
       TRUE : Result := aTrue;
       FALSE: Result := aFalse;
  end;
end;

function THTML5.toString: String;
begin
  Result := _HTML;
end;

function THTML5.Attr(aKey, aValue: string): string;
begin
  Result := format('%s="%s"', [aKey.Trim, aValue.Trim]);
end;

function THTML5.tag(aTagName: String; aValue: String; aAttributes: TStringArray = []; aSelfClosable: Boolean = True; aNoClose: Boolean = False): string;
var
  A: string;
begin
  if (aTagName.Trim.IsEmpty = TRUE) then begin
      raise Exception.Create('Tag belirtilmemiş');
  end else begin
      A := aAttributes.toString(' ').Trim;
      Result := Format( iif( (aSelfClosable = TRUE)
                           , iif( (aValue.Trim.IsEmpty = TRUE)
                                , iif ( (A.IsEmpty = True)
                                      , iif( aNoClose, '<%0:s>', '<%0:s/>')
                                      , iif( aNoClose, '<%0:s %2:s>', '<%0:s %2:s/>')
                                      )
                                , iif( (A.IsEmpty = True), '<%0:s>%1:s</%0:s>', '<%0:s %2:s>%1:s</%0:s>')
                                )
                           , iif( (A.IsEmpty = True), '<%0:s>%1:s</%0:s>', '<%0:s %2:s>%1:s</%0:s>')
                           )
                      , [ {0} aTagName.Trim
                        , {1} aValue.Trim
                        , {2} A
                        ]
                      ) + #13#10;
  end;
end;

function THTML5.Mark(aValue: String): THTML5;
begin
  _HTML  := _HTML + tag ( 'title', aValue);
  Result := Self;
end;

function THTML5.Title(aValue: String): THTML5;
begin
  _HTML  := _HTML + tag ( 'title', aValue);
  Result := Self;
end;

function THTML5.HTML(aValue: THTML5): THTML5;
begin
  _HTML  := '<!DOCTYPE HTML>'#13#10
          + tag ( 'html'
                , aValue.toString
                );
  Result := Self;
end;

function THTML5.HEAD(aValue: THTML5): THTML5;
begin
  _HTML  := _HTML + tag ( 'head'
                , aValue.toString
                );
  Result := Self;
end;

function THTML5.Link(aRef, aHref: String): THTML5;
begin
  _HTML := _HTML + tag ( 'link', '', [Attr(aRef, aHref)], True, True);
  Result := Self;
end;

function THTML5.Meta(aAttributes: TStringArray): THTML5;
begin
  _HTML := _HTML + tag ( 'meta', '', aAttributes, True, True);
  Result := Self;
end;

function THTML5.Meter(aValue, aMin, aMax: Integer; aText: string = ''): THTML5;
begin
  _HTML := _HTML + tag ( 'meter', aText, [Attr('value', aValue.ToString), Attr('min', aMin.ToString), Attr('max', aMax.ToString)]);
  //  <meter value="2" min="0" max="10">2 out of 10</meter>
end;

function THTML5.Script(aSrc, aScript: String): THTML5;
begin
  _HTML := _HTML + tag ( 'script', aScript, [aSrc], false, False);
  Result := Self;
end;

function THTML5.Base(aHref, aTarget: String): THTML5;
begin
  _HTML  := _HTML
          + tag ( 'base', '', [Attr('href',aHref), Attr('target', aTarget)], True, True)
          ;
  Result := Self;
end;

function THTML5.BODY(aValue: THTML5): THTML5;
begin
  _HTML  := _HTML + tag ( 'body'
                , aValue.toString
                );
  Result := Self;
end;

function THTML5.HEADER(aValue: THTML5): THTML5;
begin
  _HTML  := _HTML + tag ( 'header'
                , aValue.toString
                );
  Result := Self;
end;

function THTML5.FOOTER(aValue: THTML5): THTML5;
begin
  _HTML  := _HTML + tag ( 'footer'
                , aValue.toString
                );
  Result := Self;
end;

function THTML5.Article(aValue: THTML5): THTML5;
begin
  _HTML  := _HTML + tag ( 'article'
                , aValue.toString
                );
  Result := Self;
end;

function THTML5.Main(aValue: THTML5): THTML5;
begin
  _HTML  := _HTML + tag ( 'main'
                , aValue.toString
                );
  Result := Self;
end;

function THTML5.New: THTML5;
begin
  _HTML := '';
  Result := Self;
end;

function THTML5.H1(aValue: String): THTML5;
begin
  _HTML  := _HTML + tag ( 'h1'
                , aValue
                );
  Result := Self;
end;

function THTML5.H2(aValue: String): THTML5;
begin
  _HTML  := _HTML + tag ( 'h2'
                , aValue
                );
  Result := Self;
end;

function THTML5.H3(aValue: String): THTML5;
begin
  _HTML  := _HTML + tag ( 'h3'
                , aValue
                );
  Result := Self;
end;

function THTML5.H4(aValue: String): THTML5;
begin
  _HTML  := _HTML + tag ( 'h4'
                , aValue
                );
  Result := Self;
end;

function THTML5.H5(aValue: String): THTML5;
begin
  _HTML  := _HTML + tag ( 'h5'
                , aValue
                );
  Result := Self;
end;

function THTML5.H6(aValue: String): THTML5;
begin
  _HTML  := _HTML + tag ( 'h6'
                , aValue
                );
  Result := Self;
end;

function THTML5.P(aValue: String): THTML5;
begin
  _HTML  := _HTML + tag ( 'p'
                , aValue
                );
  Result := Self;
end;

end.
