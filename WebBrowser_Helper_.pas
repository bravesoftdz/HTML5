unit WebBrowser_Helper_;

interface

uses
    SHDocVw       //  TWebBrowser
  , Vcl.Forms     //  TApplication
  ;

type
  TWebBrowserHelper = class helper for TWebBrowser                         // S�n�f hizmet�isi
    type
      TIEMode = (iemUnknown, iemIE7, iemIE8, iemIE9, iemIE10, iemIE11);
    public
      function GetHTML: String;                                            // TWebBrowser nesnesindeki HTML kodu
      function GetTEXT: String;                                            // TWebBrowser nesnesinde g�sterilen sayfadaki text (HTML kodu i�ermez, d�z metindir...)
      procedure RunHTML(aHTMLCode: String; aApplication: TApplication);    // Do�rudan HTML kodlar�n� �al��t�racak olan yordam�m�z
      class function SetupIEMode(aAyarla: Boolean; IE_Kipi: TIEMode): LongInt;       // Internet Explorer'in hangi versiyon kipinde �al��aca��n� Y�NET�R
      class function SetIEMode(Mode: TIEMode): boolean;                              // Internet Explorer'in hangi versiyon kipinde �al��aca��n� BEL�RLER
      class function GetIEMode: TIEMode;                                             // Internet Explorer'in hangi versiyon kipinde �al��t���n� OKUR
  end;

implementation

uses
    Winapi.ActiveX        //  IPersistStreamInit
  , MSHTML                //  IHTMLElement
  , System.Win.Registry   //  TRegistry
  , System.Classes        //  TStringStream
  , System.SysUtils       //  FreeAndNil
  , Winapi.Windows        //  HKEY_CURRENT_USER
  ;

{ TWebBrowserHelper }

function TWebBrowserHelper.GetHTML: String;
Var
  E: IHTMLElement;
begin
  Result := '';
  if (Assigned(Document) = TRUE) then begin
      E := (Document as IHTMLDocument2).body;
      while (E.parentElement <> nil) do E := E.parentElement;
      Result := E.outerHTML;
  end;
end;

class function TWebBrowserHelper.GetIEMode: TIEMode;
begin
  Result := TIEMode( Byte( SetupIEMode(FALSE, iemUnknown) ) );
end;

function TWebBrowserHelper.GetTEXT: String;
var
  Bodi : IHTMLElement;
begin
  Result := '';
  if  (Assigned(Document) = TRUE)
  then Result := (Document as IHTMLDocument2).body.innerText;
end;

procedure TWebBrowserHelper.RunHTML(aHTMLCode: String; aApplication: TApplication);
var
  SS: TStringStream;                             // HTML Kodlar�m�z�TWebBrowser'a aktarmak i�in kullanaca��z
begin
  Navigate('about:blank');                       // TWebBrowser nesnesine temiz bir sayfa a��yoruz.
  try
    while (ReadyState < READYSTATE_INTERACTIVE)  // TWebBrowser'in i�inin bitmesini bekliyoruz. Bu arada ana thread'imizin rutinine devam etmesini sa�l�yoruz.
       do aApplication.ProcessMessages;          // ProcessMessage'nin bu tarz kullan�m� pek �nerilmeyebiliyor OnDocumentComplete ve READYSTATE_COMPLETE kullan�m�
                                                 // da �nerilmektedir fakat bizim �rne�imiz i�in ProcessMessage kullanmak yeterli olacakt�r.
                                                 // Daha kompleks, daha sa�lamc� yap�lar kurmak isterseniz yukar�da de�indi�im olay i�leyici
                                                 // ve durum bayra��n� kullanmak faydal� olabilir...
  finally
    if (Assigned(Document) = TRUE) then begin    // TWebBrowser bo� sayfam�z� i�lemeye haz�r ise y�kleme i�lemine ba�layabiliriz...
        SS := TStringStream.Create;
        SS.WriteString(aHTMLCode);               // HTML kodlar�m�z� StringStream'�m�za y�kl�yoruz.
        try
          SS.Seek(0, 0);                         // StringStream'in ilk bayt�na pozisyonumuzu al�yoruz.
          (Document as IPersistStreamInit)
          .Load(TStreamAdapter.Create(SS));      // TWebBrowser'in Document nesnesine IPersistStreamInit arabirimi vas�tas�yla HTML i�eri�imizi y�kl�yoruz.
        finally
          SS.Free;                               // Bitti, hepsi bu kadar. Art�k HTML kodlar�n�n�n sonucunu bir web sayfas� olarak g�rebiliriz...
        end;
    end;
  end;
end;

class function TWebBrowserHelper.SetIEMode(Mode: TIEMode): boolean;
begin
  Result := ( SetupIEMode(TRUE, Mode) > 0 );
end;

class function TWebBrowserHelper.SetupIEMode(aAyarla: Boolean; IE_Kipi: TIEMode): LongInt;
const
  REG_KEY = 'Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION';
var
  Reg     : TRegistry;
  Value   : LongInt;
  I       : LongInt;
  Uygulama: String;
begin

  Result := 0;
  if  (aAyarla = TRUE )
  and ( IE_Kipi = iemUnknown ) then Exit;                     // IE'nin bilinmeyen (muhtemelen daha yeni) bir s�r�m�yse ��k...

  Uygulama := ExtractFileName(ParamStr(0));                   // Kendi uygulamam�z�n EXE ad� (Mesela "Project1.exe" gibi...)

  Value := 0;
  if (aAyarla = TRUE ) then begin                             // A�a��daki k�s�m ile ilgili olarak �u linki incelemenizi tavsiye ederim;
                                                              // http://www.ahmetaltay.com.tr/2016/02/del...mulasyonu/
     case IE_Kipi of                                          // IE'nin ne �ekilde �al��aca��n� se�iyoruz...
          iemIE7 : Value := 7000;
          iemIE8 : Value := 8888;                             // IE 8  + DOCTYPE spesifikasyonunu destekler
          iemIE9 : Value := 9999;                             // IE 9  + DOCTYPE spesifikasyonunu destekler
          iemIE10: Value := 10001;                            // IE 10 + DOCTYPE spesifikasyonunu destekler
          iemIE11: Value := 11001;                            // IE 11 + DOCTYPE spesifikasyonunu destekler
          else     Value := 11001;                            // IE 11 ve �zeriise IE11 + DOCTYPE spesifikasyonunu destekler
      end;
  end;

  Reg := nil;
  try
    // Bu noktada uygulamam�z i�in REGISTRY'de bir ayarlama yap�yoruz
    // Bu ayarlama uygulamam�z�n hangi IE s�r�m�yle �al��aca��n�
    // ��letim sistemine s�ylemi� olacak...
    Reg := TRegistry.Create();
    Reg.RootKey := HKEY_CURRENT_USER;
    if (Reg.OpenKey(REG_KEY, True) ) then begin
        if (aAyarla = TRUE) then begin
            Reg.WriteInteger(Uygulama, Value);
            Result := Value;
        end else begin
            Value := Reg.ReadInteger( Uygulama );
        end;
        Reg.CloseKey;
    end;
  except;
    // Herhangi bir hata mesaj� g�rmek istemiyoruz...
  end;

  if (Assigned(Reg) = TRUE) then FreeAndNil(Reg);             // REG nesnesinin Temizli�i...

  if (aAyarla = FALSE) and (Value > 0) then begin
      I := Value div 1000;
      if (I >= 7) and (I <= 11) then begin
          case I of
           7000 : Result := Byte(iemIE7);
           8888 : Result := Byte(iemIE8);
           9999 : Result := Byte(iemIE9);
           10001: Result := Byte(iemIE10);
           11001: Result := Byte(iemIE11);
          else    if (I >= 12) then Result := Byte(iemIE11);
          end;
      end;
  end;
end;


initialization
  TWebBrowser.SetIEMode( iemIE11);

end.
