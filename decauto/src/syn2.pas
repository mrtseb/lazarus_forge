unit syn2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm10 }

  TForm10 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form10: TForm10;

implementation
uses decauto1;
{$R *.lfm}

{ TForm11 }

procedure TForm10.Button1Click(Sender: TObject);
begin
  self.hide;
  form1.show;
end;

end.

