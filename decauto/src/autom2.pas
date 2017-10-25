unit autom2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm6 }

  TForm6 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.lfm}

{ TForm6 }

procedure TForm6.Button2Click(Sender: TObject);
begin
  self.hide;
end;

procedure TForm6.Button3Click(Sender: TObject);
begin
  Showmessage('Appele le professeur pour obtenir son aide!');
end;

end.

