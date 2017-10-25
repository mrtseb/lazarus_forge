unit eval2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm9 }

  TForm9 = class(TForm)
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Shape1: TShape;
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form9: TForm9;

implementation
uses syn2,pcpo1, decauto1;
{$R *.lfm}

{ TForm9 }

procedure TForm9.Button2Click(Sender: TObject);
begin
  self.hide;

  if  self.CheckBox1.Checked
  and not self.CheckBox6.Checked
  and self.CheckBox8.Checked
  and not self.CheckBox10.Checked
  and self.CheckBox12.checked then
    begin
        form10.show;
        form1.Frame1_1.BitBtn2.Glyph.LoadFromFile('LED2ON.BMP');
    end else begin
    showmessage('Vous devriez relire la leçon!');
    form1.Frame1_1.BitBtn2.Glyph.LoadFromFile('LED1ON.BMP');
    form7.Show;
  end;


end;

procedure TForm9.CheckBox1Click(Sender: TObject);
begin
  if (sender as TCheckbox).taborder mod 2 = 1 then begin;

   checkbox2.Checked:=not checkbox1.Checked;
   checkbox5.Checked:=not checkbox6.Checked;
   checkbox7.Checked:=not checkbox8.Checked;
   checkbox9.Checked:=not checkbox10.Checked;
   checkbox11.Checked:=not checkbox12.Checked;

 end else begin


 checkbox1.Checked:=not checkbox2.Checked;
 checkbox6.Checked:=not checkbox5.Checked;
 checkbox8.Checked:=not checkbox7.Checked;
 checkbox10.Checked:=not checkbox9.Checked;
 checkbox12.Checked:=not checkbox11.Checked;

 end;
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
  //self.CheckBox1Click(self.CheckBox1);
end;

end.

