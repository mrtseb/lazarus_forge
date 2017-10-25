unit eval3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm14 }

  TForm14 = class(TForm)
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
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form14: TForm14;

implementation
uses syn3,soc1, decauto1;
{$R *.lfm}

{ TForm14 }

procedure TForm14.Button2Click(Sender: TObject);
begin
  self.hide;
  if not self.CheckBox1.Checked
  and self.CheckBox6.Checked
  and self.CheckBox8.Checked
  and not self.CheckBox10.Checked
  and self.CheckBox12.checked then
      begin
        form15.show;
        form1.Frame1_1.BitBtn4.Glyph.LoadFromFile('LED2ON.BMP');


      end else
  begin
    showmessage('Vous devriez relire la leçon!');
    form1.Frame1_1.BitBtn4.Glyph.LoadFromFile('LED1ON.BMP');
    form12.Show;
  end;
end;

procedure TForm14.CheckBox1Change(Sender: TObject);
begin
 if (sender as TCheckbox).tag mod 2 = 1 then begin;

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

procedure TForm14.FormCreate(Sender: TObject);
begin
  //self.CheckBox1Change(self.CheckBox1);
end;

end.

