unit eval1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    Shape1: TShape;
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form4: TForm4;

implementation
uses syn1,autom1,decauto1;
{$R *.lfm}

{ TForm4 }

procedure TForm4.Button2Click(Sender: TObject);
begin
  self.hide;

  if not self.CheckBox1.Checked
  and self.CheckBox3.Checked
  and self.CheckBox5.Checked
  and not self.CheckBox7.Checked
  and not self.CheckBox9.Checked
  and not self.CheckBox11.checked then begin
       form11.show;
       form1.Frame1_1.BitBtn3.Glyph.LoadFromFile('LED2ON.BMP');
  end else
  begin
    showmessage('Vous devriez relire la leçon!');
    form1.Frame1_1.BitBtn3.Glyph.LoadFromFile('LED1ON.BMP');
    form5.Show;
  end;


end;

procedure TForm4.CheckBox1Change(Sender: TObject);
begin
  if (sender as TCheckbox).tag mod 2 = 1 then begin;

   checkbox2.Checked:=not checkbox1.Checked;
   checkbox4.Checked:=not checkbox3.Checked;
   checkbox6.Checked:=not checkbox5.Checked;
   checkbox8.Checked:=not checkbox7.Checked;
   checkbox10.Checked:=not checkbox9.Checked;
   checkbox12.Checked:=not checkbox11.Checked;

 end else begin


   checkbox1.Checked:=not checkbox2.Checked;
   checkbox3.Checked:=not checkbox4.Checked;
   checkbox5.Checked:=not checkbox6.Checked;
   checkbox7.Checked:=not checkbox8.Checked;
   checkbox9.Checked:=not checkbox10.Checked;
   checkbox11.Checked:=not checkbox12.Checked;

 end;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  //self.CheckBox1Change(self.CheckBox1);
end;

end.

