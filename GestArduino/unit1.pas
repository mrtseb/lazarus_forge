unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, RackCtls, SdpoSerial, Forms, Controls,
  Graphics, Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    a0: TEdit;
    a1: TEdit;
    a2: TEdit;
    a3: TEdit;
    IdleTimer1: TIdleTimer;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LEDButton1: TLEDButton;
    LEDButton2: TLEDButton;
    LEDButton3: TLEDButton;
    LEDButton4: TLEDButton;
    LEDButton5: TLEDButton;
    LEDButton7: TLEDButton;
    LEDButton8: TLEDButton;
    Memo1: TMemo;
    SdpoSerial1: TSdpoSerial;
    procedure FormCreate(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure LEDButtonClick(Sender: TObject);
    procedure SdpoSerial1RxData(Sender: TObject);


  private
    { private declarations }

  public
    { public declarations }
    procedure analyse;

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;

{ TForm1 }
procedure TForm1.analyse;
var
i:integer;
OutPutList: TStringList;
str:string;
begin
  str := StringReplace(memo1.text, sLineBreak, '', [rfReplaceAll]);
  //self.caption :=str;
  OutPutList := TStringList.Create;
   try
     Split(';', str, OutPutList) ;
     //self.caption:=inttostr(OutPutList.count);
   finally
     if  OutPutList.count = 4 then begin
       self.a0.text:=OutPutList.Strings[0];
       self.a1.text:=OutPutList.Strings[1];
       self.a2.text:=OutPutList.Strings[2];
       self.a3.text:=OutPutList.Strings[3];
   end;
     OutPutList.Free;
   end;
end;




procedure TForm1.FormCreate(Sender: TObject);
begin
  SdpoSerial1.Active:=true;
end;

procedure TForm1.IdleTimer1Timer(Sender: TObject);
begin
  memo1.clear;
  SdpoSerial1.WriteData('@');
  if (a2.text = '1014') then
  begin
      self.LEDButton2.StateOn:=not self.LEDButton2.StateOn;
      if self.LEDButton2.StateOn then SdpoSerial1.WriteData('5-255.') else
      SdpoSerial1.WriteData('5-0.');
  end;

end;


procedure TForm1.LEDButtonClick(Sender: TObject);
var percent:integer;
  i:integer;
begin
  if (sender as TLedButton).StateOn then percent:=0 else percent := 1;
  sleep(1);
  SdpoSerial1.WriteData(inttostr((sender as TLedButton).tag)+'-');
  SdpoSerial1.WriteData(inttostr(percent*255)+'.');
end;

procedure TForm1.SdpoSerial1RxData(Sender: TObject);
  var rec:string;
  begin
     rec:=SdpoSerial1.ReadData;
     Memo1.Append(rec);
     analyse;
  end;






end.

