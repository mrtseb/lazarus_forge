unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, SdpoSerial, firmata, crt;

type

  { TForm1 }

  TForm1 = class(TForm)
    A0: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    serie: TSdpoSerial;
    MonPort: TTrackBar;
    procedure A0Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure serieRxData(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  mask:byte;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.serieRxData(Sender: TObject);
var i:integer;
    lsb, msb:string;
    s:string;
    message,pin,data:byte;
begin
  s:=self.serie.ReadData;
  for i:=0 to length(s)-1 do begin
     memo1.lines.Add(inttostr(ord(s[i])));
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  self.serie.BaudRate:=br_57600;
  self.serie.Device:='COM3';
  self.serie.Active:=true;
  self.serie.WriteData(chr(SYSTEM_RESET));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  self.serie.WriteData(chr(START_SYSEX));
end;

procedure TForm1.A0Click(Sender: TObject);
begin

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  self.serie.WriteData(chr(END_SYSEX));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  self.serie.WriteData(chr(REPORT_VERSION));
end;

procedure TForm1.Button4Click(Sender: TObject);
var pin,value:byte;

begin

  pin := self.MonPort.Position;

  value:= $01;
  mask:= (value shl pin);
  self.serie.WriteData(chr($90));
  self.serie.WriteData(chr(mask mod 128));
  self.serie.WriteData(chr(mask shr $07));

  delay(100);

  value:= $00;
  mask:= (value shl pin);
  self.serie.WriteData(chr($90));
  self.serie.WriteData(chr(mask mod 128));
  self.serie.WriteData(chr(mask shr $07));


end;

end.

