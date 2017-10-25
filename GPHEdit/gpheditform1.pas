unit GphEditForm1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, tabassoc, AnimateImage,GphAssocieAnim;

const MAX=500;
      //H
      max_char=72;

type

  Tgraphe = record
    de:integer;
    a:integer;
    cond:string;
  end;

  TPoint2D = record
    x: integer;
    y:integer;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    IdleTimer1: TIdleTimer;
    IdleTimer2: TIdleTimer;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    mnuAssocierAnim: TMenuItem;
    mnuSimulate: TMenuItem;
    MenuItem3: TMenuItem;
    mnuSimulStart: TMenuItem;
    mnuSimulStop: TMenuItem;
    mnuSave: TMenuItem;
    mnuOuvrir: TMenuItem;
    mnuFichier: TMenuItem;
    mnuNew: TMenuItem;
    mnuEdition: TMenuItem;
    mnuInsEtape: TMenuItem;
    mnuSupprEtape: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure IdleTimer2Timer(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure mnuAssocierAnimClick(Sender: TObject);
    procedure mnuEditionClick(Sender: TObject);
    procedure mnuFichierClick(Sender: TObject);
    procedure mnuNewClick(Sender: TObject);
    procedure mnuInsEtapeClick(Sender: TObject);
    procedure mnuOuvrirClick(Sender: TObject);
    procedure mnuSaveClick(Sender: TObject);
    procedure mnuSimulStartClick(Sender: TObject);
    procedure mnuSimulStopClick(Sender: TObject);
    procedure mnuSupprEtapeClick(Sender: TObject);
  private

    FAnimFn: string;
    FFrame:integer;
    Fdeb,Ffin,Fcount:integer;
    FLinkCount:integer;
    FEtapeCount:integer;
    FGraphe: array[0..MAX,0..MAX] of string;
    FReceptivites: array[0..MAX,0..MAX] of string;
    FOrdres: array[0..MAX] of string;
    FEtapes_actives: array[0..MAX] of integer;
    FTempo: array[0..MAX] of integer;
    FFilename:string;
    procedure clean;
    function Fequations(eq:string):string;
    function giveLocation(i:integer):TPoint2D;
    procedure add_link(g: Tgraphe);
    function montreGph:TStringList;
    procedure cleanGph;
    procedure draw_link(deb,fin:integer;cond:string);
    procedure doCheck(Sender: TObject);
    procedure inputClick(Sender: TObject; User: boolean);
    procedure gere_ordres;
  public
    FAnim: TanimateImage;
    FAnimMode:boolean;
    FDico:TableauAssociatif;
    FDicoCapt:TableauAssociatif;
    l,l2:Tlistbox;
    procedure redraw;
    procedure SetAnim(a:string);
    procedure MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure DragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
    procedure DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure save(fn:string);

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
procedure Tform1.gere_ordres;
var i:integer;
begin
  For i:=0 to FEtapecount-1 do begin
     if FanimMode then begin
       if pos('Monter',Fordres[i])>0 then if (Fanim.FrameIndex<Fanim.Images.count) then Fanim.FrameIndex:=Fanim.FrameIndex+1;
       if pos('Descendre',Fordres[i])>0 then if (Fanim.FrameIndex>0) then Fanim.FrameIndex:=Fanim.FrameIndex-1;
       self.update;
     end;

  end;
end;

function powerint(base,puissance:integer):integer;
var i:integer;
begin
powerint:=1;
for i:=0 to puissance-1 do powerint:=powerint*base;
end;

procedure Tform1.inputClick(Sender: TObject; User: boolean);
var i:integer;

begin
 if l.itemindex=-1 then exit;
  if l.itemindex=0 then exit;

 FFrame:=0;
 for i:=1 to l.Count-1 do if l.Selected[i] then
    begin
      FDico[l.Items[i]]:='1';
      FFrame:=FFrame+powerint(2,i-1);
    end
 else
   begin
     FDico[l.Items[i]]:='0';
   end;
  if not FAnimMode then FAnim.FrameIndex:=FFrame else self.update;
 end;

procedure Tform1.SetAnim(a:string);
begin
  FanimFN:=a;
end;

function Tform1.Fequations(eq:string):string;
var s,add,test:string;
    kk,t:integer;
begin
    s := Trim(eq);
    if self.FAnimMode then
    for kk:=0 to FdicoCapt.keys.Count-1 do begin
      if pos(FdicoCapt.Keys[kk],s)<>0  then
      begin
        test:='0';
        t:=strtoint(FdicoCapt[FdicoCapt.Keys[kk]]);
        if (t>=0) and (t<Fanim.Images.Count) then
        if (Fanim.FrameIndex=t) then test:='1';
        s  := Trim(StringReplace(s,FdicoCapt.Keys[kk],test , [rfReplaceAll, rfIgnoreCase]));
      end;
    end;

    for kk:=0 to Fdico.keys.Count-1 do begin
       if pos(Fdico.Keys[kk],s)<>0  then s  := Trim(StringReplace(s,Fdico.Keys[kk],trim(Fdico[Fdico.Keys[kk]]) , [rfReplaceAll, rfIgnoreCase]));
    end;
    For kk := 65 To max_char do
    begin
    add:=FDico['chk_'+chr(kk)];
    s  := Trim(StringReplace(s,Chr(kk), add, [rfReplaceAll, rfIgnoreCase]));
    end;
    s  := Trim(StringReplace(s,'/0', '1', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'/1', '0', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'0.0', '0', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'0.1', '0', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'1.0', '0', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'1.1', '1', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'0+0', '0', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'0+1', '1', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'1+0', '1', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'1+1', '1', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'0~0', '0', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'0~1', '1', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'1~0', '1', [rfReplaceAll, rfIgnoreCase]));
    s  := Trim(StringReplace(s,'1~1', '0', [rfReplaceAll, rfIgnoreCase]));
    Fequations:=s;
end;


procedure Tform1.doCheck(Sender: TObject);
begin
   if (Sender as Tcheckbox).Checked then FDico[chr(65+(Sender as Tcheckbox).tag)]:='1' else FDico[chr(65+(Sender as Tcheckbox).tag)]:='0';
end;

procedure TForm1.save(fn:string);
var f:textfile;
    i,j,k:integer;
begin
     assignfile(f,fn);
     rewrite(f);
     writeln(f,self.FEtapeCount-1);
     for i:=0 to self.FEtapeCount-1 do begin
       writeln(f,'@');
       for k:=0 to (self.Components[self.Fcount+i] as Tmemo).Lines.Count-1 do
         writeln(f,(self.Components[self.Fcount+i] as Tmemo).Lines[k]);
       writeln(f,'#');
       writeln(f,(self.Components[self.Fcount+i] as Tmemo).Top);
       writeln(f,(self.Components[self.Fcount+i] as Tmemo).Left);
     end;
     for i:=0 to self.FEtapeCount-1 do
     for j:=0 to self.FEtapeCount-1 do
       writeln(f,FGraphe[i,j]);
     writeln(f,self.FAnimFn);
     closefile(f);
end;

procedure Tform1.cleanGph;
var i:integer;
begin
   for i:=0 to FEtapecount-1 do FGraphe[i,FEtapeCount-1] :='-1';
   for i:=0 to FEtapecount-1 do FGraphe[FEtapeCount-1,i] :='-1';
end;

function Tform1.montreGph:TStringList;
var i,j:integer;
    p,s:string;
begin
  montreGph:=TstringList.create;
  for j:= 0 to FEtapeCount do
  for i:= 0 to FEtapeCount do begin
     p:=Fgraphe[j,i];
     s:='de: '+inttostr(j)+' a:'+inttostr(i)+' cond:'+p;
     if p<>'-1' then montreGph.Add(s);
  end;
end;

procedure TForm1.clean;
var i,j:integer;
begin
FAnimFn:='default';
l.clear;
FAnim.Images:=nil;
FFrame:=0;
self.idletimer1.Enabled:=false;
FFilename:='*.GPH';
FDeb:=-1;
FFin:=-1;
self.Refresh;
for i:=0 to max do
for j:=0 to max do
FGraphe[i,j]:='-1';
if FEtapeCount=0 then exit;
repeat
self.Components[self.ComponentCount-1].Destroy;
dec(FEtapeCount);
until (self.ComponentCount = self.Fcount);
FDico.fElems.Clear;
FDicoCapt.fElems.Clear;
end;


procedure Tform1.add_link(g: Tgraphe);
begin
  if g.cond='' then g.cond:='-1';
  Fgraphe[g.de,g.a]:=g.cond;
  if g.cond <>'-1' then draw_link(g.de,g.a,g.cond);
end;

procedure Tform1.draw_link(deb,fin:integer;cond:string);
var Rx,Ry,Rm:integer;
begin
  Rx:=(self.Components[self.ComponentCount-1] as Tmemo).Width div 2;
  Ry:=(self.Components[self.ComponentCount-1] as Tmemo).height div 2;
  form1.Canvas.MoveTo(Rx+giveLocation(deb).x,Ry+giveLocation(deb).y);
  form1.Canvas.LineTo(Rx+giveLocation(fin).x,Ry+giveLocation(deb).y);
  form1.Canvas.LineTo(Rx+giveLocation(fin).x,Ry+giveLocation(fin).y);
  Rm := (giveLocation(fin).y+giveLocation(deb).y) div 2;
  if (giveLocation(deb).y > giveLocation(fin).y) then
  begin
     form1.Canvas.MoveTo(Rx+giveLocation(fin).x,Ry+Rm);
     form1.Canvas.LineTo(Rx+giveLocation(fin).x-15,Ry+Rm+15);
     form1.Canvas.MoveTo(Rx+giveLocation(fin).x,Ry+Rm);
     form1.Canvas.LineTo(Rx+giveLocation(fin).x+15,Ry+Rm+15);
  end;
  form1.Canvas.TextOut(Rx+giveLocation(fin).x+5,Ry+Rm-15, cond);
end;

function Tform1.giveLocation(i:integer):TPoint2D;
begin
  giveLocation.x := (self.Components[Fcount+i] as Tmemo).Left;
  giveLocation.y := (self.Components[Fcount+i] as Tmemo).Top;
end;

procedure TForm1.mnuNewClick(Sender: TObject);
begin
  clean;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i,j:integer;
    t:Tcheckbox;

begin

 FDico:=TableauAssociatif.create;
 FDicoCapt:=TableauAssociatif.create;
 FAnim:=TanimateImage.Create(self);
 FAnim.Parent:=self;
 FAnim.Width:=100;
 FAnim.Height:=100;
 FAnim.Left:=1100;
 FAnim.Top:=40;
 //TODO A l'ouverture placer les images dans un image list

  for i:=0 to 7 do begin
  t:=Tcheckbox.Create(self.Panel1);
  t.parent:=self.Panel1;
  t.Caption:=chr(65+i);
  t.top := 15*(i div 2);
  t.left:= (i mod 2) * 45;
  t.name:='chk_'+ chr(65+i);
  FDico[chr(65+i)]:='0';
  t.tag:=i;
  t.onclick:=@doCheck;
  end;
  l2:=Tlistbox.create(Panel1);
  l2.Parent:=Panel1;
  l2.Top := 160;
  l2.Name:='lstCapteursKeys';
  l2.MultiSelect:=true;
  l2.left:=5;
  l2.Width:=90;
  l2.enabled:=false;
  //creation zone pour capteurs
  l:=Tlistbox.create(Panel1);
  l.Parent:=Panel1;
  l.Top := 70;
  l.Name:='lstCapteurs';
  l.MultiSelect:=true;
  l.left:=5;
  l.Width:=90;
  l.OnSelectionchange:=@inputClick;
  Fcount:=self.ComponentCount;
  clean;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
end;

procedure TForm1.DragDrop(Sender, Source: TObject; X, Y: Integer);
var cond:string;
    g:Tgraphe;
begin
 FFin:=(sender as Tmemo).tag;
 if (Fdeb <> Ffin) then
 begin
    cond:=InputBox('Edition de la condition', 'condition de transition', Fgraphe[Fdeb,Ffin]);
    g.de:=Fdeb;
    g.a :=Ffin;
    g.cond:=cond;
    add_link(g);
 end;
 Fdeb:=-1;
 FFin:=-1;
end;

procedure TForm1.FormDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  X:= (X div 50) * 50;
  Y:= (Y div 50) * 50;
  if (source is Tmemo) then
  with (source as Tmemo) do begin
    left:= X;
    top:=Y;
  end;
  form1.Update;
end;

procedure TForm1.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept:=(source is Tmemo);
end;
procedure Tform1.redraw;
var i,j:integer;
    p:Tgraphe;
begin
   for j:=0 to FEtapecount-1 do
   for i:=0 to FEtapecount-1 do begin
     if Fgraphe[j,i]<> '-1' then draw_link(j,i,FGraphe[j,i]);
   end;
   memo1.Lines:=montreGph;
end;
procedure TForm1.FormPaint(Sender: TObject);
begin
 self.redraw;
end;

procedure TForm1.IdleTimer1Timer(Sender: TObject);
var cond:string;
    i,j,k,kk:integer;
begin
    for i:=0 to FEtapeCount do begin
       if Fetapes_actives[i]=1 then for j:=0 to FEtapeCount do begin
          cond:=FGraphe[i,j];
          if cond<>'-1' then begin
             //cond a 1
             if cond='1' then Freceptivites[i,j]:='1' else Freceptivites[i,j]:='-1';
             //Receptivites checkbox
             For k := 65 to max_char do
             begin
             //If (cond = Chr(k)) Then if Tcheckbox(FindComponent('chk_'+chr(k))).Checked  Then Freceptivites[i, j] := '1' Else Freceptivites[i, j] := '-1';
             //If (cond = '/'+Chr(k)) Then if Tcheckbox(FindComponent('chk'+chr(k))).Checked  Then receptivites[i, j] := '-1' Else receptivites[i, j] := '1';
             If (Pos('/', cond)<>0) or (Pos('+', cond)<>0) or (Pos('~', cond)<>0) or (Pos('.', cond)<>0) then Freceptivites[i, j]:=Fequations(cond);
             for kk:=0 to Fdico.keys.Count-1 do begin
                 if pos(Fdico.Keys[kk],cond)<>0  then Freceptivites[i, j]:=Fequations(cond);
             end;
             for kk:=0 to FdicoCapt.keys.Count-1 do begin
                 if pos(FdicoCapt.Keys[kk],cond)<>0  then Freceptivites[i, j]:=Fequations(cond);
             end;
             end;
          end;
       end;
       //traiter les receptivites
       //for ii:=0 to step_count do
       For j:=0 to FEtapecount do
       If (Fetapes_actives[i] = 1) and (trim(Freceptivites[i, j]) = '1') Then begin
              Fetapes_actives[i] := -1;
              (self.Components[self.Fcount+i] as Tmemo).Color:=clYellow;
              self.Fordres[i]:='';
              self.Ftempo[i]:=0;
              Fetapes_actives[j] := 1;
              (self.Components[self.Fcount+j] as Tmemo).Color:=TColor($3378E4);
              self.Ftempo[j]:=0;
              self.Fordres[j]:=(self.Components[self.Fcount+j] as Tmemo).Text;
              //memo1.lines.Add('unset '+inttostr(i)+' set '+inttostr(j)+' '+self.ordres[j]);
              form1.update;
       end; //if
       gere_ordres();
       self.Ftempo[i]:=self.Ftempo[i]+self.idleTimer1.Interval;
       self.update;
    end;//for
end;

procedure TForm1.IdleTimer2Timer(Sender: TObject);
begin
  self.refresh;
  self.redraw;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  self.SaveDialog1.InitialDir:=GetCurrentDir()+'/GPH/';
  self.SaveDialog1.FileName:='*.GPH';
  self.SaveDialog1.Filter:='*.GPH';
  if self.SaveDialog1.Execute then begin
     save(self.SaveDialog1.FileName);
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  self.close;
end;

procedure TForm1.mnuAssocierAnimClick(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.mnuEditionClick(Sender: TObject);
begin
  mnuSimulStopClick(Sender);
end;

procedure TForm1.mnuFichierClick(Sender: TObject);
begin
  mnuSimulStopClick(Sender);
end;

procedure Tform1.DragOver(Sender, Source: TObject; X, Y: Integer;State: TDragState; var Accept: Boolean);
begin
  Accept := (source is Tmemo) and (sender <> source);
end;

procedure TForm1.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   (sender as Tmemo).BeginDrag(true);
   Fdeb:=(sender as Tmemo).tag;
end;

procedure TForm1.mnuInsEtapeClick(Sender: TObject);
var t:Tmemo;
begin
   t:=Tmemo.create(self);
   t.color:=clYellow;
   t.parent:=self;
   t.left:=90;
   t.top:=0;
   t.height:=32;
   t.tag:=FEtapeCount;
   t.lines[0]:='Etape '+inttostr(FEtapeCount);
   //t.readonly:=True;
   t.onMouseDown:=@Mousedown;
   t.onDragOver:=@DragOver;
   t.onDragDrop:=@DragDrop;
   inc(FEtapeCount);
end;

procedure TForm1.mnuOuvrirClick(Sender: TObject);
var f:textfile;
s,txt:string;
i,j,cnt:integer;
begin
idletimer1.Enabled:=false;
Fdico.fElems.Clear;
self.OpenDialog1.InitialDir:=GetCurrentDir()+'/GPH/';
self.OpenDialog1.FileName:='*.GPH';
self.OpenDialog1.Filter:='GPH';
if self.OpenDialog1.Execute then begin
   if self.OpenDialog1.Filename='*.GPH' then exit;
   self.clean;
   self.Ffilename:=self.OpenDialog1.FileName;
   assignfile(f,self.OpenDialog1.filename);
   reset(f);
   //lit nb etapes
   readln(f,s);
   cnt:=strtoint(trim(s));
   //lit @
   readln(f,s);
   //lit le texte
   readln(f,txt);
   while s<>'#' do begin
       readln(f,s);
       if (s<>'#') then txt:=txt+chr(13)+chr(10)+s;
   end;
   //Ajouter etape 0
   mnuInsEtapeClick(sender);
   (self.Components[self.Fcount] as Tmemo).Text:=txt;
   readln(f,s); (self.Components[self.Fcount] as Tmemo).Top:=StrToint(trim(s));
   readln(f,s); (self.Components[self.FCount] as Tmemo).Left:=StrToint(trim(s));
   for i:=1 to cnt do begin
      readln(f,s);
      readln(f,txt);
      while s<>'#' do begin
       readln(f,s);
       if (s<>'#') then txt:=txt+chr(13)+chr(10)+s;
      end;
      mnuInsEtapeClick(sender);
      (self.Components[self.FCount+i] as Tmemo).Text:=txt;
      readln(f,s); (self.Components[self.FCount+i] as Tmemo).Top:=StrToint(trim(s));
      readln(f,s); (self.Components[self.FCount+i] as Tmemo).Left:=StrToint(trim(s));
   end;
   for i:=0 to cnt do
     for j:=0 to cnt do
       begin
         readln(f,s);
         self.FGraphe[i,j]:=trim(s);
       end;

   if not(eof(f)) then begin
     readln(f,s);

     //form1.caption:=s;
     if (s <> 'defaut') and (pos('swf',s) = 0) then
        begin
        GphAssocieAnim.Form2.SetAnimation(getCurrentDir()+'/anims/'+s+'.ani');
        self.FAnimFn:=s;
        end;
   end;
   closefile(f);
   self.update;
 end;//if
end;

procedure TForm1.mnuSaveClick(Sender: TObject);
begin
  self.SaveDialog1.InitialDir:=GetCurrentDir()+'/GPH/';
  self.SaveDialog1.FileName:=FFilename;
  self.SaveDialog1.Filter:='*.GPH';
  if self.SaveDialog1.Execute then begin
     save(self.SaveDialog1.FileName);
  end;
end;

procedure TForm1.mnuSimulStartClick(Sender: TObject);
  var i,j:integer;
begin
mnuSimulStopClick(Sender);
if FEtapeCount=0 then exit;
for i:=0 to FEtapeCount-1 do
for j:=0 to FEtapeCount-1 do
Freceptivites[i,j]:='-1';
(self.Components[self.Fcount] as Tmemo).Color:=TColor($3378E4);
idletimer1.Enabled:=true;
Fetapes_actives[0]:=1;
for i:=1 to max do Fordres[i]:='';
for i:=1 to max do Fetapes_actives[i]:=-1;

end;

procedure TForm1.mnuSimulStopClick(Sender: TObject);
var i,j:integer;
begin
Fanim.FrameIndex:=0;
idletimer1.enabled:=false;
for i:=0 to max do begin Fetapes_actives[i]:=-1; Ftempo[i]:=0;  end;
for i:=0 to FEtapeCount-1 do (self.Components[self.Fcount+i] as Tmemo).Color:=clYellow;
for i:=0 to FEtapeCount do
for j:=0 to FEtapeCount do
Freceptivites[i,j]:='-1';
end;

procedure TForm1.mnuSupprEtapeClick(Sender: TObject);
begin
  if FEtapecount = 0 then exit;
  self.Components[self.ComponentCount-1].Destroy;
  cleanGph;
  dec(FEtapeCount);
  form1.update;
end;

end.
