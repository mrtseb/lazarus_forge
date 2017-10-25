unit autom1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
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
  Form5: TForm5;

implementation
uses autom2;
{$R *.lfm}

{ TForm5 }

procedure TForm5.Button2Click(Sender: TObject);
begin
  self.hide;
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
  self.hide;
  form6.show;
end;

end.

