program Parser;

{$MODE Delphi}

uses
  Forms, Interfaces,
  parser1 in 'parser1.pas' {Form1},
  unit2 in 'unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
