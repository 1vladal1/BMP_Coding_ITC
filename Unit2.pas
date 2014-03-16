unit Unit2;

interface
uses
  Dialogs, ExtCtrls, Graphics, Classes;
  type
      TPRCFile = class
         FileLen     : longint;
         Width       : word;
         Height      : word;
         Resolution  : integer;
         mas         : Smallint;
         constructor Create (FileName : string; Image : TImage);
         {constructor Open (FileName : string);}
         destructor Done;
         {procedure Read;}
      end;
implementation

var PRCFile : TPRCFile;
    f : file of TPRCFile;

constructor TPRCFile.Create(FileName : string; Image : TImage);
var i,j : integer;
    flag : boolean;
begin
  AssignFile(f,FileName);
  Rewrite(F);
  with PRCFile do begin
       Width:=Image.Width;
       Height:=Image.Height;
       Resolution:=Image.InstanceSize;
       for j:=0 to Height do begin
           flag:=False;
           for i:= 0 to Width do begin
               if Image.Canvas.Pixels[i,j]=clBlack then Flag:=True;

           end;
       end;
  Write(F,PRCFile);
  end;
  Done;
end;

destructor TPRCFile.Done;
begin
close(F);
end;

end.
