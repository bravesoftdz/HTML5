object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 620
  ClientWidth = 1159
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1159
    Height = 33
    Align = alTop
    TabOrder = 0
    object BT_GO: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 75
      Height = 25
      Align = alLeft
      Caption = 'GO'
      TabOrder = 0
      OnClick = BT_GOClick
      ExplicitTop = 2
    end
    object BT_RunHTML: TButton
      AlignWithMargins = True
      Left = 85
      Top = 4
      Width = 75
      Height = 25
      Align = alLeft
      Caption = 'RunHTML'
      TabOrder = 1
      OnClick = BT_RunHTMLClick
      ExplicitLeft = 162
      ExplicitTop = 2
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 601
    Width = 1159
    Height = 19
    Panels = <>
  end
  object PG: TPageControl
    Left = 0
    Top = 33
    Width = 1159
    Height = 568
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Web Browser'
      ExplicitLeft = 450
      ExplicitTop = 282
      object Splitter2: TSplitter
        Left = 630
        Top = 0
        Width = 6
        Height = 540
        ExplicitLeft = 185
      end
      object WB: TWebBrowser
        Left = 636
        Top = 0
        Width = 515
        Height = 540
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 579
        ExplicitWidth = 635
        ExplicitHeight = 247
        ControlData = {
          4C0000003A350000D03700000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object MM_HTML: TMemo
        Left = 0
        Top = 0
        Width = 630
        Height = 540
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Inconsolata'
        Font.Style = []
        Lines.Strings = (
          '<!DOCTYPE HTML>'
          '<html>'
          '<head>'
          '<meta charset="UTF-8">'
          '<title>Path - Simple</title>'
          '<link href="style.css" rel="stylesheet" type="text/css">'
          '<script>'
          'function drawPath() {'
          #9'var canvas=document.getElementById("my-canvas");'
          #9'if (canvas.getContext) {'
          #9#9'context = canvas.getContext("2d");'
          #9#9'context.beginPath();'
          #9#9'context.moveTo(50,50);'
          #9#9'context.lineTo(100,100);'
          #9#9'context.stroke();'
          #9'}'
          '}'
          '</script>'
          '</head>'
          '<body>'
          
            '<canvas id="my-canvas" height="200" width="200">Your browser doe' +
            'sn'#39't support canvas.</canvas>'
          '<button onclick="drawPath();">Draw</button>'
          '</body>'
          '</html>')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
        OnDblClick = MM_HTMLDblClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Tools'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 573
        Top = 0
        Width = 6
        Height = 540
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 573
        Height = 540
        Align = alLeft
        Caption = 'Panel2'
        TabOrder = 0
        object MM_Orjinal: TMemo
          Left = 1
          Top = 42
          Width = 571
          Height = 497
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Inconsolata'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 571
          Height = 41
          Align = alTop
          TabOrder = 1
          object BT_Convert: TButton
            AlignWithMargins = True
            Left = 492
            Top = 4
            Width = 75
            Height = 33
            Align = alRight
            Caption = 'Convert'
            TabOrder = 0
            OnClick = BT_ConvertClick
          end
        end
      end
      object Panel4: TPanel
        Left = 579
        Top = 0
        Width = 572
        Height = 540
        Align = alClient
        Caption = 'Panel2'
        TabOrder = 1
        object MM_Modified: TMemo
          Left = 1
          Top = 42
          Width = 570
          Height = 497
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Inconsolata'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object Panel5: TPanel
          Left = 1
          Top = 1
          Width = 570
          Height = 41
          Align = alTop
          TabOrder = 1
        end
      end
    end
  end
end
