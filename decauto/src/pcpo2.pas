unit pcpo2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm8 }

  TForm8 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form8: TForm8;

implementation
uses eval2;
{$R *.lfm}

{ TForm8 }

procedure TForm8.Button1Click(Sender: TObject);
begin
  self.hide;
  form9.show;
end;

end.

