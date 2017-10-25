unit decauto1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, buttons, frame1, frame2, frame3;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nom: TEdit;
    Frame1_1: TFrame1;
    Frame2_1: TFrame2;
    Label1: TLabel;
    prenom: TEdit;
    classe: TEdit;
    Panel1: TPanel;
    procedure BitBtn2Click(Sender: TObject);

    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    //procedure Frame2_1Click(Sender: TObject);
    //procedure Label4Click(Sender: TObject);
    //procedure Panel1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation
uses meca1, eval1, autom1, pcpo1,soc1,evalf1;
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  self.Frame1_1.Top:= 5 ;
  self.Frame1_1.Left:= 5;
  self.Frame1_1.Width:=self.Panel1.Width-10;
  self.Frame1_1.Height:=self.Panel1.Height-10;

  self.Frame2_1.Hide;
  self.Frame1_1.show;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  self.close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  form4.show;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  self.Frame1_1.hide;
  self.Frame2_1.show;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  form12.show
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  if (self.nom.Text='') or (self.prenom.Text='') then ShowMessage('Merci de préciser les nom, prénom et classe') else form16.show;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
   form7.show;
end;



end.

