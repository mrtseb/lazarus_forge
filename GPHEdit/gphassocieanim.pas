unit gphassocieanim;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, Buttons, AnimateImage, imgList;

type

  { TForm2 }

  TForm2 = class(TForm)
    AnimateImage1: TAnimateImage;
    BitBtn1: TBitBtn;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    SpinEdit1: TSpinEdit;
    procedure FormHide(Sender: TObject);
    procedure Split(Delimiter: Char; Str: string) ;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    FListOfStrings:Tstringlist;
  public
     procedure SetAnimation(fn:string);
  end;

var
  Form2: TForm2;

implementation
uses GphEditForm1;
{$R *.lfm}

{ TForm2 }
procedure TForm2.Split(Delimiter: Char; Str: string) ;
  begin
   FListOfStrings.Clear;
   FListOfStrings.Delimiter       := Delimiter;
   FListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   FListOfStrings.DelimitedText   := Str;
end;

procedure TForm2.FormHide(Sender: TObject);
begin
  self.AnimateImage1.Images:=nil;
end;

procedure Tform2.SetAnimation(fn:string);
var
    f:Textfile;
    nom,s,plus:string;

    i,inpC,outC,W,H,mx:integer;
    bmp:Tbitmap;
begin
  self.ImageList1.Clear;
        assignfile(f,fn);
        reset(f);
        readln(f,nom);
        GphEditForm1.Form1.FAnimMode:= pos('_',nom)>0;
        GphEditForm1.Form1.SetAnim(nom);
        //lit nb entree
        readln(f,s);
        inpC:=strtoint(s);
        plus:='';
        //lire le nom des entrees
        GphEditForm1.Form1.l2.Clear;
        GphEditForm1.Form1.l.Clear;
        GphEditForm1.Form1.l.Items.Add('-');
        for i:=1 to inpC do begin
          readln(f,s);
          if pos('#',s)<>0 then
          begin
          delete(s,1,1);
          GphEditForm1.Form1.l.Items.Add(s);
          GphEditForm1.Form1.FDico[s]:='0';
          plus:=plus+'0';
          end else
          //capteurs de cles
          if pos('_',s)<>0 then
          begin
          delete(s,1,1);
          split(':',s);
          GphEditForm1.Form1.l2.Items.Add(self.FListOfStrings[0]);
          GphEditForm1.Form1.FDicoCapt[self.FListOfStrings[0]]:=self.FListOfStrings[1];
          end;
          //todo entrees analogiques @
        end;
        //lit nb sortie
        readln(f,s);
        outC:=strtoint(s);
        //lire le nom des sorties
        for i:=1 to outC do begin
        readln(f,s);
        end;
        //fixe W et H
        readln(f,s);
        W:=strtoint(s);
        readln(f,s);
        H:=strtoint(s);

        self.AnimateImage1.Width:=W;
        self.AnimateImage1.Height:=H;
        self.ImageList1.Width:=W;
        self.ImageList1.Height:=H;
        bmp:=TBitmap.Create;
        bmp.Width:=W;
        bmp.Height:=H;

        //ajout d'une image
        if GphEditForm1.Form1.FAnimMode then begin
             //lit le nombre d'img à la fin
             readln(f,s);
             mx:=strtoint(s);
        end else
        begin
          mx:=1;
          for i:=1 to inpC do mx:=mx*2;
        end;

        for i:=0 to mx-1 do begin
          bmp.LoadFromFile(getCurrentdir()+'\images\'+nom+inttostr(i)+'.bmp');
          self.ImageList1.AddMasked(bmp,clNone);
        end;
        self.SpinEdit1.MaxValue:=self.ImageList1.Count-1;
        GphEditForm1.Form1.Fanim.Width:=W;
        GphEditForm1.Form1.Fanim.Height:=H;
        GphEditForm1.Form1.Fanim.Images:=self.ImageList1;

        closefile(f);

end;

procedure TForm2.BitBtn1Click(Sender: TObject);

begin
  //l:=TcustomImageList.create(self);
  self.OpenDialog1.InitialDir:=getCurrentDir()+'\anims\';
  self.OpenDialog1.Filter:='*.ani';
  self.OpenDialog1.FileName:='*.ani';
  if self.OpenDialog1.execute then begin
       self.SetAnimation(self.OpenDialog1.FileName);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FListOfStrings:=Tstringlist.create;
end;

procedure TForm2.SpinEdit1Change(Sender: TObject);
begin
  self.AnimateImage1.FrameIndex:=self.SpinEdit1.Value;
end;

end.

