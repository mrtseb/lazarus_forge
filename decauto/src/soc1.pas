unit soc1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm12 }

  TForm12 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form12: TForm12;

implementation
uses soc2;
{$R *.lfm}

{ TForm12 }

procedure TForm12.Button1Click(Sender: TObject);
begin
  self.hide;
  form13.show;
end;

end.

