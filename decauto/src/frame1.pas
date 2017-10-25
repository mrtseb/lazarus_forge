unit frame1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, ExtCtrls, Buttons;

type

  { TFrame1 }

  TFrame1 = class(TFrame)
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1Paint(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation
uses pcpo1;
{$R *.lfm}

{ TFrame1 }

procedure TFrame1.Image1Click(Sender: TObject);
begin

end;

procedure TFrame1.Image1Paint(Sender: TObject);
begin

end;

procedure TFrame1.Image2Click(Sender: TObject);
begin

end;

procedure TFrame1.BitBtn3Click(Sender: TObject);
begin

end;

procedure TFrame1.BitBtn2Click(Sender: TObject);
begin
    form7.show;
end;

end.

