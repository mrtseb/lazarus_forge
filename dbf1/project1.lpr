{$MODE OBJFPC}{$H+}
Program project1;
{ We need the following units be in the USES clause: }
uses db, dbf, dbf_Common, sysUtils,classes;

{ The Dbf is put there e.g. when you drop a TDbf component on a form...   }
{ but you will need db for the DataSet object and Dbf_Common              }
{ for things such as the field type definitions                           }
{ Finally, use SysUtils for ForceDirectories.                             }
var
  MyDbf: TDbf;
  f:textfile;
  s:string;
  t:Tstringlist;
  i:integer;

  procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;

begin
  MyDbf := TDbf.Create(nil);
  try
    t:=Tstringlist.create;
    ForceDirectories('db');
    MyDbf.FilePath := 'db' + DirectorySeparator;
    { we want to use Visual dBase VII compatible tables }
    MyDbf.TableLevel := 7;
    MyDbf.Exclusive := True;
    MyDbf.TableName := 'eval_c4.dbf';
    With MyDbf.FieldDefs do begin
      Add('Id', ftAutoInc, 0, True);
      Add('id_eleve', ftInteger, 5, True);
      Add('date',ftDate,10,true);
      Add('comp_1', ftInteger, 2, True);
      Add('comp_2', ftInteger, 2, True);
      Add('comp_3', ftInteger, 2, True);
      Add('comp_4', ftInteger, 2, True);
      Add('comp_5', ftInteger, 2, True);
      Add('comp_6', ftInteger, 2, True);
      Add('comp_7', ftInteger, 2, True);
      Add('comp_8', ftInteger, 2, True);
      Add('comp_9', ftInteger, 2, True);
      Add('comp_10', ftInteger, 2, True);
      Add('comp_11', ftInteger, 2, True);
      Add('comp_12', ftInteger, 2, True);
      Add('comp_13', ftInteger, 2, True);
      Add('comp_14', ftInteger, 2, True);
      Add('comp_15', ftInteger, 2, True);
      Add('comp_16', ftInteger, 2, True);
      Add('comp_17', ftInteger, 2, True);
      Add('comp_18', ftInteger, 2, True);
      Add('comp_19', ftInteger, 2, True);
      Add('comp_20', ftInteger, 2, True);
      Add('comp_21', ftInteger, 2, True);
      Add('comp_26', ftInteger, 2, True);
      Add('comp_27', ftInteger, 2, True);
      Add('comp_28', ftInteger, 2, True);
      Add('comp_29', ftInteger, 2, True);
      Add('comp_30', ftInteger, 2, True);
      Add('comp_31', ftInteger, 2, True);
    End;
    MyDbf.CreateTable;
    MyDbf.Open;
    MyDbf.AddIndex('evalc4Id', 'Id', [ixPrimary, ixUnique]);


    MyDbf.Close;
  finally
    MyDbf.Free;
    t.free;
  end;
end.
