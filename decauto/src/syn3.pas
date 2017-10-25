unit syn3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm15 }

  TForm15 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form15: TForm15;

implementation

{$R *.lfm}

{ TForm15 }

procedure TForm15.Button1Click(Sender: TObject);
begin
  self.hide;
end;

end.

