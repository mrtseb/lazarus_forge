unit pcpo1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm7 }

  TForm7 = class(TForm)
    Button2: TButton;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form7: TForm7;

implementation
uses pcpo2;
{$R *.lfm}

{ TForm7 }

procedure TForm7.Button2Click(Sender: TObject);
begin
  self.hide;
  form8.show;
end;

end.

