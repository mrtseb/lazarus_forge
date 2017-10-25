unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    TrackBar1: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  var bmp:Tbitmap;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);


begin
   bmp:=Tbitmap.create;
   bmp.Width:=180;
   bmp.Height:=450;
   bmp.Canvas.Brush.Style:=bssolid;
   bmp.Canvas.Brush.Color:=clCream;
   bmp.canvas.pen.Color:=clblack;
   bmp.Canvas.FillRect(0,0,bmp.width,bmp.height);
   bmp.canvas.pen.style:=psDash;
   bmp.Canvas.MoveTo(90,0);
   bmp.Canvas.LineTo(90,450);
   bmp.SaveToFile('base.bmp');
   self.Image1.Canvas.Draw(0,0,bmp);
   TrackBar1Change(sender);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  bmp.LoadFromFile('base.bmp');
  bmp.Canvas.Brush.Color:=clPurple;
  bmp.Canvas.FillRect(5,300-self.TrackBar1.Position*15,bmp.width-5,450-self.TrackBar1.Position*15);
  bmp.SaveToFile('_ascenseur1_'+inttostr(self.TrackBar1.Position)+'.bmp');
  self.Image1.Canvas.Draw(0,0,bmp);
end;

end.

