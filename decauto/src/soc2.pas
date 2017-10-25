unit soc2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm13 }

  TForm13 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form13: TForm13;

implementation
uses eval3;
{$R *.lfm}

{ TForm13 }

procedure TForm13.Button1Click(Sender: TObject);
begin
  form14.show;
  self.hide;
end;

end.

