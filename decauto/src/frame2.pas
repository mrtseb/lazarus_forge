unit frame2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Buttons, StdCtrls;

type

  { TFrame2 }

  TFrame2 = class(TFrame)
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FrameClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation
 uses meca1,autom1,eval1;
{$R *.lfm}

{ TFrame2 }

procedure TFrame2.BitBtn3Click(Sender: TObject);
begin
  form2.show;
end;

procedure TFrame2.Button1Click(Sender: TObject);
begin
  form4.show;
end;

procedure TFrame2.FrameClick(Sender: TObject);
begin

end;

procedure TFrame2.BitBtn2Click(Sender: TObject);
begin
  form5.show;
end;

end.

