unit WebBrowser_Helper_;

interface

uses
    SHDocVw                                                                    //  TWebBrowser
  , Vcl.Forms                                                                  //  TApplication
  ;

type
  TWebBrowserHelper = class helper for TWebBrowser                             // Sınıf hizmetçisi
    type
      TIEMode = (iemUnknown, iemIE7, iemIE8, iemIE9, iemIE10, iemIE11);
    public
      function GetHTML: String;                                                // TWebBrowser nesnesindeki HTML kodu
      function GetTEXT: String;                                                // TWebBrowser nesnesinde gösterilen sayfadaki text (HTML kodu içermez, düz metindir...)
      procedure RunHTML(aHTMLCode: String; aApplication: TApplication);        // Doğrudan HTML kodlarını çalıştıracak olan yordamımız
      class function SetupIEMode(aAyarla: Boolean; IE_Kipi: TIEMode): LongInt; // Internet Explorer'in hangi versiyon kipinde çalışacağını YÖNETİR
      class function SetIEMode(Mode: TIEMode): boolean;                        // Internet Explorer'in hangi versiyon kipinde çalışacağını BELİRLER
      class function GetIEMode: TIEMode;                                       // Internet Explorer'in hangi versiyon kipinde çalıştığını OKUR
  end;

implementation

uses
    Winapi.ActiveX                                                             //  IPersistStreamInit
  , MSHTML                                                                     //  IHTMLElement
  , System.Win.Registry                                                        //  TRegistry
  , System.Classes                                                             //  TStringStream
  , System.SysUtils                                                            //  FreeAndNil
  , Winapi.Windows                                                             //  HKEY_CURRENT_USER
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
  SS: TStringStream;                             // HTML KodlarımızıTWebBrowser'a aktarmak için kullanacağız
begin
  Navigate('about:blank');                       // TWebBrowser nesnesine temiz bir sayfa açıyoruz.
  try
    while (ReadyState < READYSTATE_INTERACTIVE)  // TWebBrowser'in işinin bitmesini bekliyoruz. Bu arada ana thread'imizin rutinine devam etmesini sağlıyoruz.
       do aApplication.ProcessMessages;          // ProcessMessage'nin bu tarz kullanımı pek önerilmeyebiliyor OnDocumentComplete ve READYSTATE_COMPLETE kullanımı
                                                 // da önerilmektedir fakat bizim örneğimiz için ProcessMessage kullanmak yeterli olacaktır.
                                                 // Daha kompleks, daha sağlamcı yapılar kurmak isterseniz yukarıda değindiğim olay işleyici
                                                 // ve durum bayrağını kullanmak faydalı olabilir...
  finally
    if (Assigned(Document) = TRUE) then begin    // TWebBrowser boş sayfamızı işlemeye hazır ise yükleme işlemine başlayabiliriz...
        SS := TStringStream.Create;
        SS.WriteString(aHTMLCode);               // HTML kodlarımızı StringStream'ımıza yüklüyoruz.
        try
          SS.Seek(0, 0);                         // StringStream'in ilk baytına pozisyonumuzu alıyoruz.
          (Document as IPersistStreamInit)
          .Load(TStreamAdapter.Create(SS));      // TWebBrowser'in Document nesnesine IPersistStreamInit arabirimi vasıtasıyla HTML içeriğimizi yüklüyoruz.
        finally
          SS.Free;                               // Bitti, hepsi bu kadar. Artık HTML kodlarınının sonucunu bir web sayfası olarak görebiliriz...
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
  and ( IE_Kipi = iemUnknown ) then Exit;                     // IE'nin bilinmeyen (muhtemelen daha yeni) bir sürümüyse çık...

  Uygulama := ExtractFileName(ParamStr(0));                   // Kendi uygulamamızın EXE adı (Mesela "Project1.exe" gibi...)

  Value := 0;
  if (aAyarla = TRUE ) then begin                             // Aşağıdaki kısım ile ilgili olarak şu linki incelemenizi tavsiye ederim;
                                                              // http://www.ahmetaltay.com.tr/2016/02/del...mulasyonu/
     case IE_Kipi of                                          // IE'nin ne şekilde çalışacağını seçiyoruz...
          iemIE7 : Value := 7000;
          iemIE8 : Value := 8888;                             // IE 8  + DOCTYPE spesifikasyonunu destekler
          iemIE9 : Value := 9999;                             // IE 9  + DOCTYPE spesifikasyonunu destekler
          iemIE10: Value := 10001;                            // IE 10 + DOCTYPE spesifikasyonunu destekler
          iemIE11: Value := 11001;                            // IE 11 + DOCTYPE spesifikasyonunu destekler
          else     Value := 11001;                            // IE 11 ve üzeriise IE11 + DOCTYPE spesifikasyonunu destekler
      end;
  end;

  Reg := nil;
  try
    // Bu noktada uygulamamız için REGISTRY'de bir ayarlama yapıyoruz. Bu ayarlama uygulamamızın hangi IE sürümüyle çalışacağını İşletim sistemine söylemiş olacak...
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
    // Herhangi bir hata mesajı görmek istemiyoruz...
  end;

  if (Assigned(Reg) = TRUE) then FreeAndNil(Reg);             // REG nesnesinin Temizliği...

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
