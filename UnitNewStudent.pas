unit UnitNewStudent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TFrmNewStudent = class(TForm)
    ImgLogo: TImage;
    EdtName: TEdit;
    EdtTagName: TEdit;
    EdtAge: TEdit;
    EdtExp: TEdit;
    EdtRegNumb: TEdit;
    EdtMembNumb: TEdit;
    LblEntryMemb: TLabel;
    LblEntryReg: TLabel;
    LblEntryExp: TLabel;
    LblEntryAge: TLabel;
    LblEntryName: TLabel;
    LblEntryTag: TLabel;
    rgrpSex: TRadioGroup;
    btnSubmit: TButton;
    btnAbort: TButton;
    LblTitleNewStudent: TLabel;
    procedure btnSubmitClick(Sender: TObject);
    procedure btnAbortClick(Sender: TObject);

  private
    { Private declarations }
  public
  end;
type Student = Record
  MembershipNumber : Integer;
  Name : String[25];
  TagName : String[25];
  Age : Integer;
  Experience : Integer;
  RegistrationNumber : String[7];
  Gender : String[6];
  NumberofReturnVisits : Integer;
  NumberOfBikesRecorded : Integer;
End;

var
  FrmNewStudent: TFrmNewStudent;
  StudentFile : file of Student;
  Identity : Student;

implementation

uses UnitTVAMSignUp;

{$R *.dfm}

procedure TFrmNewStudent.btnAbortClick(Sender: TObject);
begin
Close;
end;

procedure TFrmNewStudent.btnSubmitClick(Sender: TObject);

Type  Student = Record
      MembershipNumber : Integer;
      Name : String[25];
      TagName : String[25];
      Age : Integer;
      Experience : Integer;
      RegistrationNumber : String[7];
      Gender : String[6];
      NumberofReturnVisits : Integer;
      NumberOfBikesRecorded : Integer;
      end;
Var
  StudentFile : file of Student;
  Identity : Student;
  PersonFound,Continue : Boolean;

begin
  Assignfile (StudentFile, 'StudentData.dat');
  reset (StudentFile);
  Continue := True;
  PersonFound := False;
 if (edtAge.Text = '') or (edtMembNumb.Text = '') or (edtExp.Text = '') or (edtName.Text = '') or (edtRegNumb.Text = '') or (edtTagName.Text = '') or ((rgrpSex.itemIndex <> 1) and (rgrpSex.ItemIndex <> 0)) then
    Begin
    ShowMessage('One or more fields have been left empty, please complete the form before submitting');
    Continue := False;
    End;
 if Continue = True then
  if (StrtoInt(edtAge.Text) < 16) or (StrtoInt(edtExp.Text) > (StrtoInt(edtAge.Text) - 16)) or (Length(edtMembNumb.Text) <> 8) then
    Begin
    ShowMessage('One or more fields contain data that is invalid, please revise your entry');
    Continue := False;
    End;
 if Continue = True then

 while not eof (StudentFile) and not PersonFound do
  begin
    read(StudentFile,identity);
    with identity do
    begin
         if MembershipNumber = strtoint(edtmembnumb.text) then
         begin
              PersonFound := True;
              Continue := False;
              ShowMessage('We are sorry, but there already seems to be records of you in the database, try the existing member section of the sign-up page.');
         end;
    end;
  end;
      seek(Studentfile, filesize(Studentfile));
if Continue = True then
  Begin
    with Identity do Begin
      Name := edtName.Text;
      TagName := edtTagName.Text;
      Age := StrtoInt(edtAge.Text);
      MembershipNumber := StrtoInt(edtMembNumb.Text);
      Experience := StrtoInt(edtExp.Text);
      case rgrpSex.ItemIndex of
        0: Gender := 'Male';
        1: Gender := 'Female';
      end;
      RegistrationNumber :=  edtRegNumb.Text;
      NumberOfReturnVisits := 0;
      NumberOfBikesRecorded := 1;
    End;
    FrmRegister.edtStudMemb.Text := edtMembNumb.Text;
    FrmRegister.edtStudName.Text := edtName.text;
    FrmRegister.edtStudTag.Text := edtTagName.text;
    write(Studentfile, identity);
    CloseFile(StudentFile);
    FrmNewStudent.Close;
 end
Else
  CloseFile(StudentFile);
end;



end.
