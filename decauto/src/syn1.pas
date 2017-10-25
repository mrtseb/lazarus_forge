unit syn1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm11 }

  TForm11 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form11: TForm11;

implementation
uses decauto1;
{$R *.lfm}

{ TForm10 }

procedure TForm11.Button1Click(Sender: TObject);
begin
  self.hide;
  form1.Frame2_1.Hide;
  form1.Frame1_1.Show;
end;

end.

