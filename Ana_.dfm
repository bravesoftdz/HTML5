object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 692
  ClientWidth = 1283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 673
    Width = 1283
    Height = 19
    Panels = <>
  end
  object PG: TPageControl
    Left = 0
    Top = 0
    Width = 1283
    Height = 673
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Web Browser'
      object Splitter2: TSplitter
        Left = 603
        Top = 0
        Width = 6
        Height = 645
        ExplicitLeft = 185
        ExplicitHeight = 540
      end
      object WB: TWebBrowser
        Left = 609
        Top = 0
        Width = 666
        Height = 645
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 579
        ExplicitWidth = 635
        ExplicitHeight = 247
        ControlData = {
          4C000000D5440000AA4200000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 603
        Height = 645
        Align = alLeft
        Caption = 'Panel6'
        TabOrder = 1
        object Panel1: TPanel
          Left = 1
          Top = 1
          Width = 601
          Height = 33
          Align = alTop
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 3
          ExplicitWidth = 441
          object BT_Test: TButton
            AlignWithMargins = True
            Left = 522
            Top = 4
            Width = 75
            Height = 25
            Align = alRight
            Caption = 'Test'
            TabOrder = 0
            OnClick = BT_Klik
            ExplicitLeft = 4
          end
          object BT_RunHTML: TButton
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 109
            Height = 25
            Align = alLeft
            Caption = 'Run HTML Code'
            TabOrder = 1
            OnClick = BT_Klik
          end
        end
        object MM_HTML: TMemo
          Left = 1
          Top = 34
          Width = 601
          Height = 610
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Inconsolata'
          Font.Style = []
          Lines.Strings = (
            '<!DOCTYPE HTML>'
            '<html>'
            ''
            '<head>'
            '    <meta charset="UTF-8">'
            '    <title>Canvas Shape and Color Effects</title>'
            '    <style type="text/css">'
            '        body {'
            '            overflow: hidden;'
            '            background: #000;'
            '        }'
            '        '
            '        canvas {'
            '            width: 100vw;'
            '            height: 100vh;'
            '        }'
            '    </style>'
            ''
            '    <body>'
            ''
            
              '        <script src="https://ajax.googleapis.com/ajax/libs/jquer' +
              'y/1.11.3/jquery.min.js"></script>'
            ''
            '        <script>'
            '            //pure js & canvas > no library'
            ''
            '            var c = document.createElement("canvas"),'
            '                $ = c.getContext("2d");'
            ''
            '            var w = window.innerWidth,'
            '                h = window.innerHeight;'
            ''
            '            c.width = w;'
            '            c.height = h;'
            ''
            '            c.addEventListener("mousedown", mouseDown, true);'
            ''
            '            document.body.appendChild(c);'
            ''
            '            var part; //particle '
            '            var meshW = 100; //mesh width'
            '            var dispX = -50; //x disposition'
            '            var dispY = -100; //y disposition'
            '            var partX = 0; //particle x'
            '            var partY = 0; //particle y'
            '            var partIndX = 0; //particle index x'
            '            var partIndY = 0; //particle index y'
            ''
            '            var col0 = "rgb(74, 1, "; //shading color-starts'
            '            var col1 = "rgb(0, 3, ";'
            ''
            '            var partList = []; //particle array'
            '            var gridW = w + meshW; //grid width '
            '            var gridH = h + meshW * 2; //grid height'
            ''
            '            while (partY < gridH) {'
            '                while (partX < gridW) {'
            
              '                    part = new Object(partX, partY, partIndX, pa' +
              'rtIndY);'
            '                    partList.push(part);'
            ''
            '                    partX += meshW;'
            '                    partIndX++;'
            '                }'
            ''
            '                partX = 0;'
            '                partIndX = 0;'
            '                partY += meshW;'
            '                partIndY++;'
            '            }'
            ''
            '            var partArrayL = partList.length;'
            '            var rowCt = Math.ceil(gridW / meshW); //row count'
            '            var colCt = Math.ceil(gridH / meshW); //column count'
            ''
            '            $.clearRect(0, 0, w, h);'
            ''
            '            for (var i = 0; i < partArrayL; ++i) {'
            '                part = partList[i];'
            '                part.next = partList[i + 1];'
            ''
            
              '                if (part.indX % rowCt != rowCt - 1 && part.indY ' +
              '!= colCt - 1) {'
            '                    part.connectAll.push(partList[i + 1]);'
            
              '                    part.connectAll.push(partList[i + rowCt + 1]' +
              ');'
            '                    part.connectAll.push(partList[i + rowCt]);'
            '                    part.ready();'
            '                }'
            '            }'
            ''
            '            var int = setInterval(intHandler, 1000 / 30);'
            ''
            '            function mouseDown() {'
            '                if (int != undefined) {'
            '                    clearInterval(int);'
            '                    int = undefined;'
            '                } else {'
            '                    int = setInterval(intHandler, 1000 / 30);'
            '                }'
            '            }'
            ''
            '            part = partList[0];'
            ''
            '            function intHandler() {'
            '                $.clearRect(0, 0, w, h);'
            ''
            '                while (part != undefined) {'
            '                    part.draw();'
            '                    part = part.next;'
            '                }'
            ''
            '                part = partList[0];'
            ''
            '                while (part != undefined) {'
            '                    part.fill();'
            '                    part = part.next;'
            '                }'
            ''
            '                part = partList[0];'
            '            }'
            ''
            '            function Object(pX, pY, pIndX, pIndY) {'
            '                this.distort = 50;'
            ''
            
              '                this.x = dispX + pX + (Math.random() - Math.rand' +
              'om()) * this.distort;'
            
              '                this.y = dispY + pY + (Math.random() - Math.rand' +
              'om()) * this.distort;'
            '                this.indX = pIndX;'
            '                this.indY = pIndY;'
            
              '                this.color = "hsla(261, 55%, 5%, 1)"; //part bor' +
              'der color'
            ''
            '                this.size = 2;'
            '                this.next = undefined;'
            ''
            '                this.tracker = (Math.PI / 2) + this.indX * .5;'
            '                this.diffX = Math.random();'
            '                this.diffY = Math.random();'
            '                this.speed = .1;'
            
              '                this.vol = 30; //volume  (higher #, more movemen' +
              't)'
            ''
            '                this.colRngDiff = 70; //shading variation'
            
              '                //color range > changing the 225 to vals between' +
              ' 0 and 255, as well as the color range difference # above,  will' +
              ' change base color'
            
              '                this.colRng = (225 - this.colRngDiff) + Math.flo' +
              'or(Math.random() * this.colRngDiff);'
            ''
            '                this.draw = function() {'
            '                    this.tracker += this.speed;'
            
              '                    this.tracker = this.tracker == 1 ? 0 : this.' +
              'tracker;'
            ''
            
              '                    this.x += (Math.sin(this.tracker) * this.spe' +
              'ed) * this.vol;'
            
              '                    this.y += (Math.cos(this.tracker) * this.spe' +
              'ed) * this.vol;'
            ''
            '                }'
            ''
            '                this.readyW = 0; //start point'
            '                this.readyW1 = 0;'
            ''
            '                this.ready = function() {'
            
              '                    this.readyW = Math.abs(this.connectAll[0].x ' +
              '- this.x);'
            
              '                    this.readyW1 = Math.abs(this.connectAll[1].x' +
              ' - this.connectAll[2].x);'
            '                }'
            ''
            '                this.connectAll = [];'
            ''
            '                this.connect = function() {'
            '                    if (this.connectAll.length > 0) {'
            '                        $.beginPath();'
            '                        $.strokeStyle = this.color;'
            '                        $.moveTo(this.x, this.y);'
            ''
            
              '                        for (var j = 0; j < this.connectAll.leng' +
              'th; ++j)'
            
              '                            $.lineTo(this.connectAll[j].x, this.' +
              'connectAll[j].y);'
            ''
            '                        $.lineTo(this.x, this.y);'
            
              '                        $.lineTo(this.connectAll[1].x, this.conn' +
              'ectAll[1].y);'
            '                        $.stroke();'
            '                    }'
            '                }'
            ''
            '                this.calcW = 0;'
            '                this.calcW1 = 0;'
            ''
            '                this.fill = function() {'
            '                    if (this.connectAll.length > 0) {'
            
              '                        this.calcW = Math.abs(this.connectAll[0]' +
              '.x - this.x);'
            
              '                        this.calcW1 = Math.abs(this.connectAll[1' +
              '].x - this.connectAll[2].x);'
            ''
            '                        $.beginPath();'
            
              '                        $.fillStyle = col0 + (Math.floor((this.r' +
              'eadyW / this.calcW) * this.colRng)).toString() + ")";'
            ''
            '                        $.moveTo(this.x, this.y);'
            
              '                        $.lineTo(this.connectAll[2].x, this.conn' +
              'ectAll[2].y);'
            
              '                        $.lineTo(this.connectAll[1].x, this.conn' +
              'ectAll[1].y);'
            '                        $.lineTo(this.x, this.y);'
            ''
            '                        $.fill();'
            ''
            '                        $.beginPath();'
            
              '                        $.fillStyle = col1 + (Math.floor((this.r' +
              'eadyW1 / this.calcW1) * this.colRng)).toString() + ")";'
            ''
            '                        $.moveTo(this.x, this.y);'
            
              '                        $.lineTo(this.connectAll[1].x, this.conn' +
              'ectAll[1].y);'
            
              '                        $.lineTo(this.connectAll[0].x, this.conn' +
              'ectAll[0].y);'
            '                        $.lineTo(this.x, this.y);'
            ''
            '                        $.fill();'
            '                    }'
            '                }'
            ''
            '            }'
            '        </script>'
            ''
            '    </body>')
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 1
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Tools'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 573
        Top = 0
        Width = 6
        Height = 645
        ExplicitHeight = 540
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 573
        Height = 645
        Align = alLeft
        Caption = 'Panel2'
        TabOrder = 0
        object MM_Orjinal: TMemo
          Left = 1
          Top = 42
          Width = 571
          Height = 602
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Inconsolata'
          Font.Style = []
          Lines.Strings = (
            '<!DOCTYPE HTML>'
            '<html>'
            ''
            '<head>'
            '    <meta charset="UTF-8">'
            '    <title>Canvas Interactive Text Particles</title>'
            '    <style type="text/css">'
            '        body {'
            '            margin: 0px;'
            '        }'
            '    </style>'
            ''
            '    <body>'
            ''
            '        <canvas id="canvas"></canvas>'
            ''
            '        <script '
            
              'src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.' +
              'min.js"></script>'
            ''
            '        <script type="text/javascript">'
            '            function Banner() {'
            ''
            '                var keyword = "COOL";'
            '                var canvas;'
            '                var context;'
            ''
            '                var bgCanvas;'
            '                var bgContext;'
            ''
            '                var denseness = 10;'
            ''
            '                //Each particle/icon'
            '                var parts = [];'
            ''
            '                var mouse = {'
            '                    x: -100,'
            '                    y: -100'
            '                };'
            '                var mouseOnScreen = false;'
            ''
            '                var itercount = 0;'
            '                var itertot = 40;'
            ''
            '                this.initialize = function(canvas_id) {'
            '                    canvas = document.getElementById(canvas_id);'
            '                    context = canvas.getContext('#39'2d'#39');'
            ''
            '                    canvas.width = window.innerWidth;'
            '                    canvas.height = window.innerHeight;'
            ''
            '                    bgCanvas = document.createElement('#39'canvas'#39');'
            '                    bgContext = bgCanvas.getContext('#39'2d'#39');'
            ''
            '                    bgCanvas.width = window.innerWidth;'
            '                    bgCanvas.height = window.innerHeight;'
            ''
            
              '                    canvas.addEventListener('#39'mousemove'#39', MouseMo' +
              've, false);'
            
              '                    canvas.addEventListener('#39'mouseout'#39', MouseOut' +
              ', false);'
            ''
            '                    start();'
            '                }'
            ''
            '                var start = function() {'
            ''
            '                    bgContext.fillStyle = "#000000";'
            '                    bgContext.font = '#39'300px impact'#39';'
            '                    bgContext.fillText(keyword, 85, 275);'
            ''
            '                    clear();'
            '                    getCoords();'
            '                }'
            ''
            '                var getCoords = function() {'
            '                    var imageData, pixel, height, width;'
            ''
            
              '                    imageData = bgContext.getImageData(0, 0, can' +
              'vas.width, canvas.height);'
            ''
            
              '                    // quickly iterate over all pixels - leaving' +
              ' density gaps'
            
              '                    for (height = 0; height < bgCanvas.height; h' +
              'eight += denseness) {'
            
              '                        for (width = 0; width < bgCanvas.width; ' +
              'width += denseness) {'
            
              '                            pixel = imageData.data[((width + (he' +
              'ight * bgCanvas.width)) * '
            '4) - 1];'
            
              '                            //Pixel is black from being drawn on' +
              '. '
            '                            if (pixel == 255) {'
            '                                drawCircle(width, height);'
            '                            }'
            '                        }'
            '                    }'
            ''
            '                    setInterval(update, 40);'
            '                }'
            ''
            '                var drawCircle = function(x, y) {'
            ''
            '                    var startx = (Math.random() * canvas.width);'
            
              '                    var starty = (Math.random() * canvas.height)' +
              ';'
            ''
            '                    var velx = (x - startx) / itertot;'
            '                    var vely = (y - starty) / itertot;'
            ''
            '                    parts.push({'
            
              '                        c: '#39'#'#39' + (Math.random() * 0x949494 + 0xa' +
              'aaaaa | 0).toString(16),'
            '                        x: x, //goal position'
            '                        y: y,'
            '                        x2: startx, //start position'
            '                        y2: starty,'
            '                        r: true, //Released (to fly free!)'
            '                        v: {'
            '                            x: velx,'
            '                            y: vely'
            '                        }'
            '                    })'
            '                }'
            ''
            '                var update = function() {'
            '                    var i, dx, dy, sqrDist, scale;'
            '                    itercount++;'
            '                    clear();'
            '                    for (i = 0; i < parts.length; i++) {'
            ''
            '                        //If the dot has been released'
            '                        if (parts[i].r == true) {'
            '                            //Fly into infinity!!'
            '                            parts[i].x2 += parts[i].v.x;'
            '                            parts[i].y2 += parts[i].v.y;'
            
              '                            //Perhaps I should check if they are' +
              ' out of screen... and kill '
            'them?'
            '                        }'
            '                        if (itercount == itertot) {'
            '                            parts[i].v = {'
            '                                x: (Math.random() * 6) * 2 - 6,'
            '                                y: (Math.random() * 6) * 2 - 6'
            '                            };'
            '                            parts[i].r = false;'
            '                        }'
            ''
            
              '                        //Look into using svg, so there is no mo' +
              'use tracking.'
            '                        //Find distance from mouse/draw!'
            '                        dx = parts[i].x - mouse.x;'
            '                        dy = parts[i].y - mouse.y;'
            '                        sqrDist = Math.sqrt(dx * dx + dy * dy);'
            ''
            '                        if (sqrDist < 20) {'
            '                            parts[i].r = true;'
            '                        }'
            ''
            '                        //Draw the circle'
            '                        context.fillStyle = parts[i].c;'
            '                        context.beginPath();'
            
              '                        context.arc(parts[i].x2, parts[i].y2, 4,' +
              ' 0, Math.PI * 2, true);'
            '                        context.closePath();'
            '                        context.fill();'
            ''
            '                    }'
            '                }'
            ''
            '                var MouseMove = function(e) {'
            '                    if (e.layerX || e.layerX == 0) {'
            '                        //Reset particle positions'
            '                        mouseOnScreen = true;'
            ''
            '                        mouse.x = e.layerX - canvas.offsetLeft;'
            '                        mouse.y = e.layerY - canvas.offsetTop;'
            '                    }'
            '                }'
            ''
            '                var MouseOut = function(e) {'
            '                    mouseOnScreen = false;'
            '                    mouse.x = -100;'
            '                    mouse.y = -100;'
            '                }'
            ''
            '                //Clear the on screen canvas'
            '                var clear = function() {'
            '                    context.fillStyle = '#39'#333'#39';'
            '                    context.beginPath();'
            
              '                    context.rect(0, 0, canvas.width, canvas.heig' +
              'ht);'
            '                    context.closePath();'
            '                    context.fill();'
            '                }'
            '            }'
            ''
            '            var banner = new Banner();'
            '            banner.initialize("canvas");'
            '        </script>'
            ''
            '    </body>')
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
          object BT_ConvertToString: TButton
            AlignWithMargins = True
            Left = 408
            Top = 4
            Width = 159
            Height = 33
            Align = alRight
            Caption = 'Convert to Quoted String'
            TabOrder = 0
            OnClick = BT_Klik
          end
          object BT_Clear_Tools: TButton
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 47
            Height = 33
            Align = alLeft
            Caption = 'Clear'
            TabOrder = 1
            OnClick = BT_Klik
          end
        end
      end
      object Panel4: TPanel
        Left = 579
        Top = 0
        Width = 696
        Height = 645
        Align = alClient
        Caption = 'Panel2'
        TabOrder = 1
        object MM_Modified: TMemo
          Left = 1
          Top = 42
          Width = 694
          Height = 602
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
          Width = 694
          Height = 41
          Align = alTop
          TabOrder = 1
          object BT_Copy: TButton
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 117
            Height = 33
            Align = alLeft
            Caption = 'Copy to Clipboard'
            TabOrder = 0
            OnClick = BT_Klik
          end
        end
      end
    end
  end
end
