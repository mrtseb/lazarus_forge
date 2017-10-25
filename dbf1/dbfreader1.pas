unit dbfReader1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, dbf, sqldb, FileUtil, Forms, Controls,
  Graphics, Dialogs, DbCtrls, DBGrids, StdCtrls, ComCtrls, ExtCtrls, ValEdit,
 EditBtn, DBExtCtrls, RichMemo, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    chkNotions: TCheckBox;
    chkSocle: TCheckBox;
    ComboBox1: TComboBox;
    cmbClasse: TComboBox;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DateEdit1: TDateEdit;
    DBEdit1: TDBEdit;
    Dbf1: TDbf;
    Dbf2: TDbf;
    Dbf3: TDbf;
    Dbf4: TDbf;
    Dbf5: TDbf;
    Dbf6: TDbf;
    Dbf7: TDbf;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TRichMemo;
    Memo2: TMemo;
    Memo3: TRichMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    RadioGroup1: TRadioGroup;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ValueListEditor1: TValueListEditor;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure chkSocleClick(Sender: TObject);
    procedure cmbClasseChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Dbf6AfterScroll(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);

  private
    procedure AddColorStr(m:TRichmemo;s: string; const col: TColor = clBlack; const NewLine: boolean = true);
    procedure MajDb(socle:integer);
    procedure MajEvalDb(eleve:integer);
    procedure ShowComp;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

type
  TIntegerArray1to27 = Array[1..27] of Integer;
const
  INDICES: TIntegerArray1to27 = (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,26,27,28,29,30,31);



procedure Tform1.MajEvalDb(eleve:integer);
var i:integer;
begin
   dbf7.Filtered:=true;
     dbf7.Filter:='ID_ELEVE='+inttostr(eleve);
     dbf7.first;
     for i:=0 to self.TabSheet2.ComponentCount-1 do begin
       if (self.TabSheet2.Components[i] is TRadioGroup) then begin
         (self.TabSheet2.Components[i] as TRadioGroup).itemindex:=dbf7.FieldByName('COMP_'+inttostr(INDICES[i+1])).AsInteger;
       end;
     end;
  dbf7.Filtered:=false;

end;

procedure Tform1.AddColorStr(m:TRichmemo; s: string; const col: TColor = clBlack; const NewLine: boolean = true);
    begin
      with m do
      begin
        if NewLine then
        begin
          Lines.Add('');
          Lines.Delete(Lines.Count - 1); // avoid double line spacing
        end;

        SelStart  := Length(Text);
        SelText   := s;
        SelLength := Length(s);
        SetRangeColor(SelStart, SelLength, col);

        // deselect inserted string and position cursor at the end of the text
        SelStart  := Length(Text);
        SelText   := '';
      end;
    end;

procedure Tform1.ShowComp;
begin
    self.Memo3.Clear;
    dbf1.Filtered:=false;
    dbf1.First;
    while not dbf1.EOF do begin
        AddcolorStr(memo3,dbf1.FieldByName('REFERENCE').asString+' ',clRed,true);
        AddcolorStr(memo3,dbf1.FieldByName('ITEM').asString,clPurple,false);
        //AddcolorStr(memo3,'',clNone,true);
       dbf1.next;
    end;
end;


procedure TForm1.FormCreate(Sender: TObject);
var i,j,k:integer;
    trb:TradioGroup;
    oldRef:string;
begin
  ForceDirectories('db');

  dbf1.TableName:='competences.dbf';
  dbf2.TableName:='socle.dbf';
  dbf3.TableName:='domaine_socle.dbf';
  dbf4.TableName:='notions.dbf';
  dbf5.TableName:='socle_comp.dbf';
  dbf6.TableName:='eleves_c4.dbf';
  dbf7.TableName:='eval_c4.dbf';

  for i:=0 to ComponentCount-1 do begin
       if (Components[i] is Tdbf) then begin
         (Components[i] as Tdbf).FilePath:='db' + DirectorySeparator;
         (Components[i] as Tdbf).Active:=true;
       end;
  end;
  self.ComboBox1.clear;

  while not dbf3.EOF do begin
      self.ComboBox1.Items.Add(dbf3.FieldByName('ITEM').asString);
      dbf3.next;
  end;
  self.ComboBox1.Items.Add('Tout le socle');
  self.ComboBox1.ItemIndex:=0;
  MajDb(0);
  dbf6.first;
  while not dbf6.EOF do begin
      if (self.cmbClasse.items.IndexOf(dbf6.FieldByName('CLASSE').asString) = -1) then self.cmbClasse.Items.Add(dbf6.FieldByName('CLASSE').asString);
      dbf6.next;
  end;

  self.cmbClasse.ItemIndex:=0;

  //creer l'espace d'eval
  dbf1.Filtered:=false;
  dbf1.first;
  j:=0;
  k:=1;
  while not dbf1.EOF do begin
      //self.Memo2.lines.Add(dbf1.FieldByName('REFERENCE').asString+' '+dbf1.FieldByName('ITEM').asString);
      trb:=TradioGroup.Create(self.TabSheet2);
      trb.Parent:=self.TabSheet2;
      trb.caption:=dbf1.FieldByName('REFERENCE').asString;
      if oldref='' then begin
        trb.left:=self.DBGrid1.Left+self.DBGrid1.Width+5;
        j:=j+1;
        trb.top:=100+70*j;
      end;

      if oldref<>'' then if (trb.caption[1]<>oldRef[1]) then begin
        trb.left:=self.DBGrid1.Left+self.DBGrid1.Width+5;
        j:=j+1;
        trb.top:=100+70*j;
        trb.left:=self.DBGrid1.Left+self.DBGrid1.Width+5;
        k:=1;
      end else begin
      trb.left:=self.DBGrid1.Left+self.DBGrid1.Width+5+k*117;
      trb.top:=100+70*j;
      k:=k+1;
      end;
      trb.Hint:=dbf1.FieldByName('ITEM').asString;
      trb.AutoSize:=true;
      trb.Brush.Color:=clblue;
      trb.columns:=4;
      trb.Items.Add('1');trb.Items.Add('2'); trb.Items.Add('3'); trb.Items.Add('4');
      trb.tag:=dbf1.FieldByName('ID').asInteger;
      //trb.ItemInex:=1;
      trb.ShowHint:=true;
      trb.name:='comp_'+dbf1.FieldByName('ID').asString;
      //trb.hint:=trb.name;
      oldref:=trb.caption;
      dbf1.next;
  end;



end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
var i:integer;
begin
   for i:=0 to self.TabSheet2.ComponentCount-1 do begin
       if (self.TabSheet2.Components[i] is TRadioGroup) then begin
         (self.TabSheet2.Components[i] as TRadioGroup).ItemIndex:=self.RadioGroup1.ItemIndex;
       end;
  end;
end;


procedure TForm1.MajDb(socle:integer);
var i,id_socle:integer;
begin

  memo1.Clear;
  dbf2.Filtered:=true;
  if trim(dbf3.FieldByName('id').AsString)<>'' then
  begin
     if (socle=7) then dbf2.Filtered:=false else dbf2.Filter:='dom_socle='+inttostr(socle);
  end;
  dbf2.First;
  while not dbf2.EOF do
  begin
    //dbf3.filtered:=true;
    //dbf3.filter:='ID='+dbf2.FieldByName('DOM_SOCLE').asString;
    //self.AddColorStr(memo1,' - '+dbf3.FieldByName('ITEM').asString,clPurple,true);

    if chkSocle.Checked then self.AddColorStr(memo1,'| '+dbf2.FieldByName('REFERENCE').asString+' '+dbf2.FieldByName('ITEM').asString+' ['+dbf2.FieldByName('ID').asString+']',clRed,true);

    id_socle:=dbf2.FieldByName('ID').asInteger;

    if (dbf5.Active and dbf4.active) then
    begin

       dbf5.Filtered:=true;
       dbf5.Filter:='id_socle='+inttostr(id_socle);




       dbf5.first;
       while not dbf5.EOF do
       begin
          //self.Memo1.Lines.Add(dbf5.FieldByName('ID_COMP').asString);
          dbf1.Filtered:=true;
          dbf1.filter:='id='+dbf5.FieldByName('ID_COMP').asString;
          self.AddColorStr(memo1,' - '+dbf1.FieldByName('REFERENCE').asString+' '+dbf1.FieldByName('ITEM').asString+' ['+dbf1.FieldByName('ID').asString+']',clBlue,true);


          dbf4.Filtered:=true;

          dbf4.filter:='id_comp='+dbf5.FieldByName('ID_COMP').asString;
          if (dbf4.ExactRecordCount >0 ) then
          begin
            dbf4.first;
            while not dbf4.EOF do begin
              if chkNotions.Checked then self.AddColorStr(memo1,' --- '+dbf4.FieldByName('REF').asString+' '+dbf4.FieldByName('ITEM').asString+' ['+dbf4.FieldByName('ID').asString+']',clGreen,true);


              dbf4.Next;
            end;
          end;
       dbf5.next;
       end;

  end;
  dbf2.Next;
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  self.PageControl1.ActivePage:=self.TabSheet1;
  dbf3.first;
  dbf7.First;
  MajEvalDb(dbf7.FieldByName('ID_ELEVE').AsInteger);
  self.DateEdit1.Date:=now;
  self.ShowComp;
end;



procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  majDb(self.ComboBox1.ItemIndex);
end;

procedure TForm1.Dbf6AfterScroll(DataSet: TDataSet);
var i:integer;
begin
  self.DBGrid1.AutoAdjustColumns;
  self.Label1.caption:=Dataset.FieldByName('PRENOM').asString+' '+Dataset.FieldByName('NOM').asString+' '+Dataset.FieldByName('CLASSE').asString;
  self.DBEdit1.Text:=Dataset.FieldByName('ID').asString;
  if not dbf7.active then exit;
  //afficher les donnees dans le form
  MajEvalDb(Dataset.FieldByName('ID').asInteger);
  if self.DBEdit1.Text<> '' then self.Button4Click(self);
end;


procedure TForm1.chkSocleClick(Sender: TObject);
begin
  MajDb(self.ComboBox1.ItemIndex);
end;

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
begin
  memo2.clear;
   for i:=0 to self.TabSheet2.ComponentCount-1 do begin
       if (self.TabSheet2.Components[i] is TRadioGroup) then begin
         memo2.Lines.Add(inttostr((self.TabSheet2.Components[i] as TRadioGroup).ItemIndex));
       end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var i,j:integer;
begin
  if memo2.lines.Count=0 then exit;
   for i:=0 to self.TabSheet2.ComponentCount-1 do begin
       if (self.TabSheet2.Components[i] is TRadioGroup) then begin
         (self.TabSheet2.Components[i] as TRadioGroup).ItemIndex:=strtoint(memo2.lines[i])
       end;
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
var i:integer;
begin
  memo2.clear;
  self.RadioGroup1.ItemIndex:=-1;
  for i:=0 to self.TabSheet2.ComponentCount-1 do begin
       if (self.TabSheet2.Components[i] is TRadioGroup) then begin
       (self.TabSheet2.Components[i] as TRadioGroup).itemindex:=-1;
       end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);

var i:integer;

    compet:array[0..30] of string;
    mydate:string;
begin
   for i:=0 to self.TabSheet2.ComponentCount-1 do begin
       if (self.TabSheet2.Components[i] is TRadioGroup) then begin
       compet[i]:=inttostr((self.TabSheet2.Components[i] as TRadioGroup).itemindex);
       end;
  end;
   //TODO verifier si enregistrement deja présent ok
   //si present update sinon insert               ok

   if dbf7.Locate('ID_ELEVE',DBEdit1.Text,[loCaseInsensitive])then
   begin
     dbf7.Filtered:=true;
     dbf7.Filter:='ID_ELEVE='+DBEdit1.Text;
     dbf7.first;
     dbf7.edit;
     dbf7.FieldByName('DATE').AsDateTime:=self.DateEdit1.Date;
     for i:=0 to self.TabSheet2.ComponentCount-1 do begin
       if (self.TabSheet2.Components[i] is TRadioGroup) then begin
         dbf7.FieldByName('COMP_'+inttostr(INDICES[i+1])).AsInteger:=((self.TabSheet2.Components[i] as TRadioGroup).itemindex);
       end;
     end;

     dbf7.Post;
     dbf7.Filtered:=false;
   end
   else
   begin
   mydate := formatdatetime('dd/mm/yyyy', DateEdit1.date);
   dbf7.AppendRecord(['',DBEdit1.Text, mydate,
   compet[0],compet[1], compet[2],compet[3],compet[4],
   compet[5],compet[6], compet[7],compet[8],compet[9],
   compet[10],compet[11], compet[12],compet[13],compet[14],
   compet[15],compet[16], compet[17],compet[18],compet[19],
   compet[20],compet[21], compet[22],compet[23],compet[24],
   compet[25],compet[26]]);
  end;
end;

procedure TForm1.cmbClasseChange(Sender: TObject);
var s:string;
begin


  if self.cmbClasse.ItemIndex<> 0 then begin
    s:='classe='+QuotedStr(self.cmbClasse.Text);
    Dbf6.filter:=s;
    Dbf6.Filtered:=true;
    //form1.Caption:=s;
  end
  else self.Dbf6.filtered:=false;
  Dbf6.first;

end;


end.

