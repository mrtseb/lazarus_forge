unit frame3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ExtCtrls, StdCtrls;

type

  { TFrame3 }

  TFrame3 = class(TFrame)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure FrameClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

{ TFrame3 }

procedure TFrame3.FrameClick(Sender: TObject);
begin

end;

procedure TFrame3.Image1Click(Sender: TObject);
begin

end;

end.

