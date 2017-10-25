unit prog_unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, SynHighlighterAny, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, RichMemo,tabassoc,ParseExpr;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    debug: TMemo;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    aide: TRichMemo;
    SaveDialog1: TSaveDialog;
    editeur: TSynEdit;
    SynAnySyn1: TSynAnySyn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
     dir:string;
     parser:TExpressionParser;
     enroute:boolean;
     memoire:TableauAssociatif;
     PC,saut:integer;
     function analyse(code:string):string;
     function affecterVariables(code:string):string;
     function CalculerCondition(code:string):boolean;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function Tform1.CalculerCondition(code:string):boolean;
var s:string;
I:integer;
begin
CalculerCondition:=false;

I := parser.AddExpression(code);
s:=parser.AsString[I];
if s='True' then CalculerCondition:=true;
end;


function Tform1.affecterVariables(code:string):string;

var a:integer;
    temp,brique,flux:string;

begin


temp:=trim(code);

while(pos(chr(34),temp))<>0 do
  begin
     delete(temp,pos(chr(34),temp),1);
  end;

temp:=temp+'|';


while pos('|',temp)<> 0 do
  begin

     a:=pos('|',temp);
     brique:=copy(temp,1,a-1);
     if memoire[brique]<> '' then flux := flux+' '+memoire[brique]
     else flux := flux+' '+brique;
     delete(temp,1,a);
  end;

     affecterVariables:=flux;
end;



function Tform1.analyse(code:string):string;
var temp:string;
a:integer;
begin
analyse:='?';
temp:=trim(code);
if temp = '' then analyse:='<ligne vide>'
else if pos('//',temp) <> 0 then analyse:='<commentaire>' else
begin

delete(temp,pos('(',temp),pos(')',temp));
temp:=trim(temp);
a:=self.SynAnySyn1.KeyWords.IndexOf(temp);
if a <> -1 then analyse:='<code n°'+inttostr(a)+'>';
end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  dir:=ExtractFilePath(Application.ExeName);
  self.OpenDialog1.initialdir:=dir+'\prg';
  self.OpenDialog1.FileName:='default.prg';
  self.SaveDialog1.initialdir:=dir+'\prg';
  self.saveDialog1.FileName:='default.prg';
  self.editeur.Lines.LoadFromFile(dir+'\prg\demo.prg');

  parser:=TExpressionparser.create;
  memoire:=TableauAssociatif.create;


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if self.OpenDialog1.Execute then self.editeur.Lines.LoadFromfile(self.opendialog1.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   if self.SaveDialog1.Execute then self.editeur.Lines.SaveTofile(self.savedialog1.FileName);
end;

procedure TForm1.Button3Click(Sender: TObject);
var k:integer;
instruction:string;
nomVar,temp,temp2,prompt,rep,typ:string;
condition:boolean;
s:string;
begin

debug.clear;
self.enroute:=false;
self.PC:=0;
self.saut:=1;

while (self.PC < editeur.lines.count) do


  begin

  instruction:=editeur.lines[self.PC];
  typ:=self.analyse(instruction);

  if (typ = '<code n°2>') then
  //afficher
  if self.enroute then
  begin

  self.debug.Lines.Add('Affiche un message.');
  temp:=trim(instruction);
  temp:=copy(temp,pos('(',temp)+1,pos(')',temp));
  delete(temp,length(temp),1);
  temp:=trim(temp);
  prompt:=affecterVariables(temp);
  if MessageDlg(prompt,mtConfirmation,[mbOk],0) = mrOk then
  self.PC:=Self.PC+self.saut;
  end;

  if (typ = '<ligne vide>') then  self.PC:=Self.PC+self.saut;
  if (typ = '<commentaire>') then  self.PC:=Self.PC+self.saut;

  if (typ = '<code n°6>') then
  //saisie
  if self.enroute then
  begin
  temp:=trim(instruction);
  temp:=copy(temp,pos('(',temp)+1,pos(')',temp));
  delete(temp,length(temp),1);
  temp:=trim(temp);
  NomVar:=copy(temp,1,pos(',',temp)-1);
  debug.lines.add(NomVar);
  delete(temp,1,pos(',',temp));
  prompt:=temp;
  rep:='';
  if InputQuery('Saisie',prompt,rep ) then
  begin
  memoire[NomVar]:=rep;
  self.debug.Lines.Add(NomVar + '=' + rep);
  self.PC:=Self.PC+self.saut;
  end else
  begin
  self.enroute:=false;
  self.debug.Lines.Add('Le programme est interrompu!');
  self.PC:=self.editeur.Lines.Count;
  end;
  end;

  if (typ = '<code n°1>') then
  //affecter
  if self.enroute then
  begin
  temp:=trim(instruction);
  temp:=copy(temp,pos('(',temp)+1,pos(')',temp));
  delete(temp,length(temp),1);
  temp:=trim(temp);
  NomVar:=copy(temp,1,pos(',',temp)-1);
  debug.lines.add(NomVar);

  delete(temp,1,pos(',',temp));
  prompt:=temp;
  prompt:=self.affecterVariables(prompt);
  debug.lines.Add(Nomvar+' = '+prompt);
  K := parser.AddExpression(prompt);
  s:= parser.AsString[K];
  debug.lines.Add(s);
  memoire[Nomvar]:=s;
  self.PC:=Self.PC+self.saut;
  end;

  if (typ = '<code n°3>') then
  begin
  if (self.enroute)
  then
  begin
  temp2:=trim(instruction);
  temp2:=copy(temp2,pos('(',temp2)+1,pos(')',temp2));
  delete(temp2,length(temp2),1);
  temp2:=trim(temp2);
  self.PC:= strtoint(temp2)-1;
  self.saut:=1;
  self.debug.Lines.Add('Sauter à la ligne '+temp2);
  end;
  end;

  if (typ = '<code n°4>') then
  begin
  self.enroute:=true;
  self.debug.Lines.Add('Le programme démarre ...');
  self.PC:=Self.PC+self.saut;
  end;

  if (typ = '<code n°5>') then
  begin
  self.enroute:=false;
  self.debug.Lines.Add('Programme achevé !');
  self.PC:=Self.editeur.Lines.Count;
  exit;
  end;


  if (typ = '<code n°7>') then
  //Si
  if self.enroute then
  begin
  temp:=trim(instruction);
  temp:=copy(temp,pos('(',temp)+1,pos(')',temp));
  delete(temp,length(temp),1);
  temp:=trim(temp);
  prompt:=affecterVariables(temp);
  prompt:=trim(prompt);
  self.debug.Lines.Add(prompt);
  condition:=CalculerCondition(prompt);
  if condition then self.debug.Lines.Add('Vrai') else self.debug.Lines.Add('Faux');
  if condition then
  begin

    self.PC:=Self.PC+self.saut;
    self.saut:=2;
  end
  else
  begin
   self.PC:=Self.PC+2;
   self.saut:=1;
  end;

  end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var i:integer;
instruction:string;
typ:string;
begin
debug.clear;
for i:=0 to editeur.lines.Count-1 do
  begin
  instruction:=editeur.lines[i];
  typ:=self.analyse(instruction);
  debug.lines.add('Ligne n°'+inttostr(i+1)+' est codée comme: '+typ);
  end;

end;

end.

