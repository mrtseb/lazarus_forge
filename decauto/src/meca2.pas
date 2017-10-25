unit meca2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.Button3Click(Sender: TObject);
begin
  Showmessage('Appele le professeur pour obtenir son aide!');

end;

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

procedure TForm3.Image1Click(Sender: TObject);
begin

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  self.hide;
end;

end.

