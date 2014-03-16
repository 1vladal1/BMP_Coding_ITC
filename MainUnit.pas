unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Buttons, ComCtrls, ExtDlgs, ExtCtrls, StdCtrls, Gauges{, Unit2};

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    FileM: TMenuItem;
    OpenM: TMenuItem;
    PrintM: TMenuItem;
    SetPrintM: TMenuItem;
    ExitM: TMenuItem;
    CodeM: TMenuItem;
    Gorizontal: TMenuItem;
    Vertical: TMenuItem;
    Coners: TMenuItem;
    DecodeM: TMenuItem;
    OpenPictureDialog1: TOpenDialog;
    SavePictureDialog1: TSaveDialog;
    SpeedBar: TPanel;
    SpeedOpen: TSpeedButton;
    SpeedPrint: TSpeedButton;
    PopupMenu1: TPopupMenu;
    SavePop1: TMenuItem;
    StatusLine: TStatusBar;
    Timer1: TTimer;
    TimeLabel: TLabel;
    TimeText: TLabel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    ScrollBox3: TScrollBox;
    ScrollBox4: TScrollBox;
    RealImage: TImage;
    GorCodedIm: TImage;
    VerCodedIm: TImage;
    ConersCodedIm: TImage;
    CheckBox1: TCheckBox;
    PopupMenu2: TPopupMenu;
    Close1: TMenuItem;
    SavePop2: TMenuItem;
    ClosePop2: TMenuItem;
    PopupMenu3: TPopupMenu;
    SavePop3: TMenuItem;
    ClosePop3: TMenuItem;
    PopupMenu4: TPopupMenu;
    SavePop4: TMenuItem;
    ClosePop4: TMenuItem;
    SavePictureDialog2: TSaveDialog;
    SavePictureDialog3: TSaveDialog;
    SavePictureDialog4: TSaveDialog;
    Gauge1: TGauge;
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure OpenMClick(Sender: TObject);
    procedure ExitMClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SizeIm_TO_BOX;
    procedure SizeIm_TO_PIC;
    procedure PaintIm;
    procedure SavePop1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure SavePop2Click(Sender: TObject);
    procedure ClosePop2Click(Sender: TObject);
    procedure SavePop3Click(Sender: TObject);
    procedure ClosePop3Click(Sender: TObject);
    procedure SavePop4Click(Sender: TObject);
    procedure ClosePop4Click(Sender: TObject);
    procedure SpeedOpenClick(Sender: TObject);
    procedure Check(Sender: TImage);
    procedure PrintMClick(Sender: TObject);
    procedure SetPrintMClick(Sender: TObject);
    procedure SpeedPrintClick(Sender: TObject);
    procedure CheckVis;
    procedure GorizontalClick(Sender: TObject);
    procedure VerticalClick(Sender: TObject);
    procedure ConersClick(Sender: TObject);
    procedure DecodeMClick(Sender: TObject);
    procedure Size(Sender : TImage);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
Application.OnHint := ShowHint;
GorCodedIm.Picture.RegisterFileFormat('gcf','Gorizontal Coded File',TBitmap);
VerCodedIm.Picture.RegisterFileFormat('vcf','Vertical Coded File',TBitmap);
ConersCodedIm.Picture.RegisterFileFormat('ccf','Coners Coded File',TBitmap);
Gauge1.ForeColor:=clBlue;
Gauge1.BackColor:=clWhite;
end;

procedure TForm1.ShowHint(Sender: TObject);
begin
  StatusLine.SimpleText := Application.Hint;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
TimeLabel.Caption:=TimeToStr(time);
end;

procedure TForm1.ExitMClick(Sender: TObject);
var q:integer;
begin
q:=MessageDlg('Вы действительно хотите выйти?',mtConfirmation,[mbYes,mbNo],0);
case q of
mrYes:Close;
mrNo:Exit;
end;
end;

//Расширить сузить картинку
procedure TForm1.CheckBox1Click(Sender: TObject);
begin
If CheckBox1.Checked=True then begin
   SizeIm_TO_BOX;
   PaintIm;
   end
else begin
   SizeIm_TO_PIC;
   PaintIm;
   end;
end;

procedure TForm1.SizeIm_TO_BOX;
begin
   RealImage.Width:=ScrollBox1.Width;
   RealImage.Height:=ScrollBox1.Height;

   GorCodedIm.Width:=ScrollBox2.Width;
   GorCodedIm.Height:=ScrollBox2.Height;

   VerCodedIm.Width:=ScrollBox3.Width;
   VerCodedIm.Height:=ScrollBox3.Height;

   ConersCodedIm.Width:=ScrollBox4.Width;
   ConersCodedIm.Height:=ScrollBox4.Height;

   RealImage.Stretch:=True;
   GorCodedIm.Stretch:=True;
   VerCodedIm.Stretch:=True;
   ConersCodedIm.Stretch:=True;

end;

procedure TForm1.SizeIm_TO_PIC;
begin
   if ScrollBox1.Visible then Size(RealImage);
   if ScrollBox2.Visible then Size(GorCodedIm);
   if ScrollBox3.Visible then Size(VerCodedIm);
   if ScrollBox4.Visible then Size(ConersCodedIm);

   RealImage.Stretch:=False;
   GorCodedIm.Stretch:=False;
   VerCodedIm.Stretch:=False;
   ConersCodedIm.Stretch:=False;
end;

//Рисуем картинки
procedure TForm1.PaintIm;
begin
   RealImage.Repaint;
   GorCodedIm.Repaint;
   VerCodedIm.Repaint;
   ConersCodedIm.Repaint;
end;

procedure TForm1.SavePop1Click(Sender: TObject);
var ext:string;
    num:integer;
begin
if SavePictureDialog1.Execute then begin
   num:=SavePictureDialog1.FilterIndex;
      if num=1 then ext:='.bmp';
      if num=2 then ext:='.gcf';
      if num=3 then ext:='.vcf';
      if num=4 then ext:='.ccf';
   RealImage.Picture.SaveToFile(SavePictureDialog1.FileName+ext);
   end;
   SavePictureDialog1.FileName:='';
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
RealImage.Visible:=False;
ScrollBox1.Visible:=False;
CheckVis;
end;

procedure TForm1.SavePop2Click(Sender: TObject);
var ext:string;
    num:integer;
begin
if SavePictureDialog2.Execute then begin
   num:=SavePictureDialog2.FilterIndex;
      if num=1 then ext:='.gcf';
      if num=2 then ext:='.bmp';
   GorCodedIm.Picture.SaveToFile(SavePictureDialog2.FileName+ext);
   end;
SavePictureDialog2.FileName:='';
end;

procedure TForm1.ClosePop2Click(Sender: TObject);
begin
GorCodedIm.Visible:=False;
ScrollBox2.Visible:=False;
CheckVis;
end;

procedure TForm1.SavePop3Click(Sender: TObject);
var ext:string;
    num:integer;
begin
if SavePictureDialog3.Execute then begin
   num:=SavePictureDialog3.FilterIndex;
      if num=1 then ext:='.vcf';
      if num=2 then ext:='.bmp';
   VerCodedIm.Picture.SaveToFile(SavePictureDialog3.FileName+ext);
   end;
SavePictureDialog3.FileName:='';
end;

procedure TForm1.ClosePop3Click(Sender: TObject);
begin
VerCodedIm.Visible:=False;
ScrollBox3.Visible:=False;
CheckVis;
end;

procedure TForm1.SavePop4Click(Sender: TObject);
var ext:string;
    num:integer;
begin
if SavePictureDialog4.Execute then begin
   num:=SavePictureDialog4.FilterIndex;
      if num=1 then ext:='.ccf';
      if num=2 then ext:='.bmp';
      ConersCodedIm.Picture.SaveToFile(SavePictureDialog4.FileName+ext);
   end;
SavePictureDialog4.FileName:='';
end;

procedure TForm1.ClosePop4Click(Sender: TObject);
begin
ConersCodedIm.Visible:=False;
ScrollBox4.Visible:=False;
CheckVis;
end;

procedure TForm1.SpeedOpenClick(Sender: TObject);
begin
OpenMClick(Sender);
end;

procedure TForm1.OpenMClick(Sender: TObject);
var num:integer;
begin
if OpenPictureDialog1.Execute then begin
   num:=OpenPictureDialog1.FilterIndex;
   if num=1 then begin
      RealImage.Visible:=True;
      ScrollBox1.Visible:=True;
      RealImage.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      OpenPictureDialog1.FileName:='';
      Size(RealImage);

      GorCodedIm.Visible:=False;
      ScrollBox2.Visible:=False;

      VerCodedIm.Visible:=False;
      ScrollBox3.Visible:=False;

      ConersCodedIm.Visible:=False;
      ScrollBox4.Visible:=False;

      {if CheckBox1.Checked=False then Check(RealImage);}
      CheckVis;
   end;
   if num=2 then begin
      GorCodedIm.Visible:=True;
      ScrollBox2.Visible:=True;
      GorCodedIm.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      OpenPictureDialog1.FileName:='';
      Size(GorCodedIm);

      RealImage.Visible:=False;
      ScrollBox1.Visible:=False;

      VerCodedIm.Visible:=False;
      ScrollBox3.Visible:=False;

      ConersCodedIm.Visible:=False;
      ScrollBox4.Visible:=False;
{      if CheckBox1.Checked=False then Check(GorCodedIm);}
      CheckVis;
   end;
   if num=3 then begin
      VerCodedIm.Visible:=True;
      ScrollBox3.Visible:=True;
      VerCodedIm.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      OpenPictureDialog1.FileName:='';
      Size(VerCodedIm);

      RealImage.Visible:=False;
      ScrollBox1.Visible:=False;

      GorCodedIm.Visible:=False;
      ScrollBox2.Visible:=False;

      ConersCodedIm.Visible:=False;
      ScrollBox4.Visible:=False;
{      if CheckBox1.Checked=False then Check(VerCodedIm);}
      CheckVis;
   end;
   if num=4 then begin
      ConersCodedIm.Visible:=True;
      ScrollBox4.Visible:=True;
      ConersCodedIm.Picture.LoadFromFile(OpenPictureDialog1.FileName);
      OpenPictureDialog1.FileName:='';
      Size(ConersCodedIm);

      RealImage.Visible:=False;
      ScrollBox1.Visible:=False;

      GorCodedIm.Visible:=False;
      ScrollBox2.Visible:=False;

      VerCodedIm.Visible:=False;
      ScrollBox3.Visible:=False;
{      if CheckBox1.Checked=False then Check(ConersCodedIm);}
      CheckVis;
   end;

end;
CheckVis;
end;

procedure TForm1.Size(Sender : TImage);
begin
      RealImage.Height:=Sender.Picture.Height;
      RealImage.Width:=Sender.Picture.Width;

      GorCodedIm.Height:=Sender.Picture.Height;
      GorCodedIm.Width:=Sender.Picture.Width;

      VerCodedIm.Height:=Sender.Picture.Height;
      VerCodedIm.Width:=Sender.Picture.Width;

      ConersCodedIm.Height:=Sender.Picture.Height;
      ConersCodedIm.Width:=Sender.Picture.Width;
end;

procedure TForm1.Check(Sender: TImage);
begin
Sender.Height:=Sender.Picture.Height;
Sender.Width:=Sender.Picture.Width;
end;

procedure TForm1.PrintMClick(Sender: TObject);
begin
PrintDialog1.Execute;
end;

procedure TForm1.SetPrintMClick(Sender: TObject);
begin
PrinterSetupDialog1.Execute;
end;

procedure TForm1.SpeedPrintClick(Sender: TObject);
begin
PrintDialog1.Execute;
end;

procedure TForm1.CheckVis;
begin
if RealImage.Visible then CodeM.Enabled:=True
   else CodeM.Enabled:=False;

if (GorCodedIm.Visible) or (VerCodedIm.Visible) or
   (ConersCodedIm.Visible) then DecodeM.Enabled:=True
   else DecodeM.Enabled:=False;

if (GorCodedIm.Visible) and (VerCodedIm.Visible) or
   (GorCodedIm.Visible) and (ConersCodedIm.Visible) or
   (VerCodedIm.Visible) and (ConersCodedIm.Visible) then
   DecodeM.Enabled:=False;
end;

//Уголки
procedure TForm1.ConersClick(Sender: TObject);
var i,j:longint;
    H,W:longint;
    flag : real;
    iter : longint;
    k : integer;
begin
H:=RealImage.Picture.Height;
W:=RealImage.Picture.Width;

ConersCodedIm.Height:=H;
ConersCodedIm.Width:=W;

ConersCodedIm.Visible:=False;
ScrollBox4.Visible:=True;
flag:=W*H/100;
iter:=0;
k:=0;
if GorCodedIm.Visible=False then begin
for j:=0 to H do
    for i:=1 to W do begin
    iter:=iter+1;
    if (iter>flag) then begin
         k:=k+1;
         Gauge1.Progress:=k;
         iter:=0;
    end;
    if RealImage.Canvas.Pixels[i-1,j]<>RealImage.Canvas.Pixels[i,j] then
         GorCodedIm.Canvas.Pixels[i,j]:=clBlack
    else GorCodedIm.Canvas.Pixels[i,j]:=clWhite;
    end;
iter:=0;
k:=0;
for i:=0 to W do
    for j:=1 to H do begin
    iter:=iter+1;
    if (iter>flag) then begin
         k:=k+1;
         Gauge1.Progress:=k;
         iter:=0;
     end;
     if GorCodedIm.Canvas.Pixels[i,j-1]<>GorCodedIm.Canvas.Pixels[i,j] then
        ConersCodedIm.Canvas.Pixels[i,j]:=clBlack
     else
         ConersCodedIm.Canvas.Pixels[i,j]:=clWhite;
    end;
end;

if GorCodedIm.Visible=True then begin
iter:=0;
k:=0;
for i:=0 to W do
    for j:=1 to H do begin
    iter:=iter+1;
    if (iter>flag) then begin
         k:=k+1;
         Gauge1.Progress:=k;
         iter:=0;
     end;
     if GorCodedIm.Canvas.Pixels[i,j-1]<>GorCodedIm.Canvas.Pixels[i,j] then
        ConersCodedIm.Canvas.Pixels[i,j]:=clBlack
     else
         ConersCodedIm.Canvas.Pixels[i,j]:=clWhite;
    end;
end;
ConersCodedIm.Picture.Bitmap.Mask(clWhite);
ConersCodedIm.Visible:=True;
Gauge1.Progress:=0;
CheckVis;
{Check(ConersCodedIm);}
{CheckBox1Click(Sender);}
end;

//Горизонтальные перепады
procedure TForm1.GorizontalClick(Sender: TObject);
var i,j:longint;
    H,W:longint;
    flag : real;
    iter : longint;
    k : integer;
begin
H:=RealImage.Picture.Height;
W:=RealImage.Picture.Width;

GorCodedIm.Height:=H;
GorCodedIm.Width:=W;

GorCodedIm.Visible:=False;
ScrollBox2.Visible:=True;

flag:=W*H/100;
iter:=0;
k:=0;
for j:=0 to H do
    for i:=1 to W do begin
    iter:=iter+1;
    if (iter>flag) then begin
         k:=k+1;
         Gauge1.Progress:=k;
         iter:=0;
     end;
    if RealImage.Canvas.Pixels[i-1,j]<>RealImage.Canvas.Pixels[i,j] then
         GorCodedIm.Canvas.Pixels[i,j]:=clBlack
    else GorCodedIm.Canvas.Pixels[i,j]:=clWhite;
    end;
GorCodedIm.Picture.Bitmap.Mask(clWhite);
GorCodedIm.Visible:=True;
Gauge1.Progress:=0;
CheckVis;
{Check(GorCodedIm);}
{CheckBox1Click(Sender);}
end;

//Вертикальные перепады
procedure TForm1.VerticalClick(Sender: TObject);
var i,j : longint;
    H,W : longint;
    flag : real;
    iter : longint;
    k : integer;
begin
H:=RealImage.Picture.Height;
W:=RealImage.Picture.Width;

VerCodedIm.Height:=H;
VerCodedIm.Width:=W;

VerCodedIm.Visible:=False;
ScrollBox3.Visible:=True;

flag:=W*H/100;
iter:=0;
k:=0;
for i:=0 to W do
    for j:=1 to H do begin
     iter:=iter+1;
     if (iter>flag) then begin
         k:=k+1;
         Gauge1.Progress:=k;
         iter:=0;
     end;
     if RealImage.Canvas.Pixels[i,j-1]<>RealImage.Canvas.Pixels[i,j] then
        VerCodedIm.Canvas.Pixels[i,j]:=clBlack
     else
         VerCodedIm.Canvas.Pixels[i,j]:=clWhite;
    end;
VerCodedIm.Picture.Bitmap.Mask(clWhite);
VerCodedIm.Visible:=True;
Gauge1.Progress:=0;
CheckVis;
{Check(VerCodedIm);}
{CheckBox1Click(Sender);}
end;

procedure TForm1.DecodeMClick(Sender: TObject);
var i,j: integer;
    H,W: integer;
    iter: longint;
    flag: real;
    k: integer;
begin
if GorCodedIm.Visible then begin
   iter:=0;
   k:=0;
   H:=GorCodedIm.Picture.Height;
   W:=GorCodedIm.Picture.Width;
   RealImage.Width:=W;
   RealImage.Height:=H;
   flag:=H*W/100;
   for j:=0 to H do
       for i:=1 to W do begin
       iter:=iter+1;
       if (iter>flag) then begin
         k:=k+1;
         Gauge1.Progress:=k;
         iter:=0;
       end;
       if (GorCodedIm.Canvas.Pixels[i,j]=clBlack) and
          (RealImage.Canvas.Pixels[i-1,j]=clBlack) then
          RealImage.Canvas.Pixels[i,j]:=clWhite;

       if (GorCodedIm.Canvas.Pixels[i,j]=clBlack) and
          (RealImage.Canvas.Pixels[i-1,j]=clWhite) then
          RealImage.Canvas.Pixels[i,j]:=clBlack;

       if (GorCodedIm.Canvas.Pixels[i,j]=clWhite) and
          (RealImage.Canvas.Pixels[i-1,j]=clBlack) then
          RealImage.Canvas.Pixels[i,j]:=clBlack;

       if (GorCodedIm.Canvas.Pixels[i,j]=clWhite) and
          (RealImage.Canvas.Pixels[i-1,j]=clWhite) then begin
          RealImage.Canvas.Pixels[i,j]:=clWhite;
       end;
       end;
   Gauge1.Progress:=0;
end;
if VerCodedIm.Visible then begin
   iter:=0;
   k:=0;
   H:=VerCodedIm.Picture.Height;
   W:=VerCodedIm.Picture.Width;
   RealImage.Width:=W;
   RealImage.Height:=H;
   flag:=W*H/100;
   for i:=0 to W do
       for j:=1 to H do begin
       iter:=iter+1;
       if (iter>flag) then begin
         k:=k+1;
         Gauge1.Progress:=k;
         iter:=0;
       end;
       if (VerCodedIm.Canvas.Pixels[i,j]=clBlack) and
          (RealImage.Canvas.Pixels[i,j-1]=clBlack) then
          RealImage.Canvas.Pixels[i,j]:=clWhite;

       if (VerCodedIm.Canvas.Pixels[i,j]=clBlack) and
          (RealImage.Canvas.Pixels[i,j-1]=clWhite) then
          RealImage.Canvas.Pixels[i,j]:=clBlack;

       if (VerCodedIm.Canvas.Pixels[i,j]=clWhite) and
          (RealImage.Canvas.Pixels[i,j-1]=clBlack) then
          RealImage.Canvas.Pixels[i,j]:=clBlack;

       if (VerCodedIm.Canvas.Pixels[i,j]=clWhite) and
          (RealImage.Canvas.Pixels[i,j-1]=clWhite) then begin
          RealImage.Canvas.Pixels[i,j]:=clWhite;
       end;

end;
Gauge1.Progress:=0;
end;

if ConersCodedIm.Visible then begin
   iter:=0;
   k:=0;
   H:=ConersCodedIm.Picture.Height;
   W:=ConersCodedIm.Picture.Width;
   RealImage.Width:=W;
   RealImage.Height:=H;
   flag:=W*H/100;
   for j:=0 to H do
       for i:=1 to W do begin
       iter:=iter+1;
       if (iter>flag) then begin
         k:=k+1;
         Gauge1.Progress:=k;
         iter:=0;
       end;
       if (ConersCodedIm.Canvas.Pixels[i,j]=clBlack) and
          (VerCodedIm.Canvas.Pixels[i-1,j]=clBlack) then
          VerCodedIm.Canvas.Pixels[i,j]:=clWhite;

       if (ConersCodedIm.Canvas.Pixels[i,j]=clBlack) and
          (VerCodedIm.Canvas.Pixels[i-1,j]=clWhite) then
          VerCodedIm.Canvas.Pixels[i,j]:=clBlack;

       if (ConersCodedIm.Canvas.Pixels[i,j]=clWhite) and
          (VerCodedIm.Canvas.Pixels[i-1,j]=clBlack) then
          VerCodedIm.Canvas.Pixels[i,j]:=clBlack;

       if (ConersCodedIm.Canvas.Pixels[i,j]=clWhite) and
          (VerCodedIm.Canvas.Pixels[i-1,j]=clWhite) then begin
          VerCodedIm.Canvas.Pixels[i,j]:=clWhite;
       end;
       end;
   Gauge1.Progress:=0;
   iter:=0;
   k:=0;
   for i:=0 to W do
       for j:=1 to H do begin
       iter:=iter+1;
       if (iter>flag) then begin
         k:=k+1;
         Gauge1.Progress:=k;
         iter:=0;
       end;
       if (VerCodedIm.Canvas.Pixels[i,j]=clBlack) and
          (RealImage.Canvas.Pixels[i,j-1]=clBlack) then
          RealImage.Canvas.Pixels[i,j]:=clWhite;

       if (VerCodedIm.Canvas.Pixels[i,j]=clBlack) and
          (RealImage.Canvas.Pixels[i,j-1]=clWhite) then
          RealImage.Canvas.Pixels[i,j]:=clBlack;

       if (VerCodedIm.Canvas.Pixels[i,j]=clWhite) and
          (RealImage.Canvas.Pixels[i,j-1]=clBlack) then
          RealImage.Canvas.Pixels[i,j]:=clBlack;

       if (VerCodedIm.Canvas.Pixels[i,j]=clWhite) and
          (RealImage.Canvas.Pixels[i,j-1]=clWhite) then begin
          RealImage.Canvas.Pixels[i,j]:=clWhite;
       end;

end;
Gauge1.Progress:=0;
end;
{CheckBox1Click(Sender);}
RealImage.Picture.Bitmap.Mask(clWhite);
RealImage.Visible:=True;
ScrollBox1.Visible:=True;
end;

end.

