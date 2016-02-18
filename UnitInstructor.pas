unit UnitInstructor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TFrmInstructor = class(TForm)
    ImgLogo: TImage;
    LblInstID: TLabel;
    LblInstName: TLabel;
    lblMobNumb: TLabel;
    lblEmail: TLabel;
    edtInstName: TEdit;
    edtInstID: TEdit;
    edtInstMobNumb: TEdit;
    edtInstEmail: TEdit;
    LblInstTitle: TLabel;
    btnNewInstructor: TButton;
    btnExistingInstructor: TButton;
    procedure btnNewInstructorClick(Sender: TObject);
    procedure btnExistingInstructorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
type Tutor = Record
 InstructorName : String[20];
 InstructorID : Integer;
 MobileNumber : String[11];
 EmailAddress : String[20];
End;

var
  InstructorFile : File of Tutor;
  FrmInstructor: TFrmInstructor;

implementation

{$R *.dfm}

procedure TFrmInstructor.btnExistingInstructorClick(Sender: TObject);
type Tutor = Record
 InstructorName : String[20];
 InstructorID : Integer;
 MobileNumber : String[11];
 EmailAddress : String[20];
      end;
var
  InstructorSearch : Integer;
  InstructorFile : file of Tutor;
  Person : Tutor;
  PersonFound : Boolean;
  s : String;
begin
  PersonFound := False;
  Assignfile (InstructorFile, 'InstructorData.dat');
  reset (InstructorFile);
  s := '00000000';
  InstructorSearch := StrtoInt(InputBox('Identity Input', 'Please enter your membership number:', s));
  while not eof (InstructorFile) and not PersonFound do
    begin
    read(InstructorFile,Person);
    with Person do
    begin
         if InstructorID = InstructorSearch then
         begin
              PersonFound := true;
              edtInstID.Text := InttoStr(InstructorID);
              edtInstMobNumb.Text := MobileNumber;
              edtInstName.Text := InstructorName;
              edtInstEmail.Text := EmailAddress;
         end;
    end;
  end;
  if not PersonFound then
    ShowMessage('There is no record of an Instructor with that ID.');
  closefile(InstructorFile);
end;

procedure TFrmInstructor.btnNewInstructorClick(Sender: TObject);
Type  Tutor = Record
 InstructorName : String[20];
 InstructorID : Integer;
 MobileNumber : String[11];
 EmailAddress : String[20];
      end;
Var
  InstructorFile : file of Tutor;
  Person : Tutor;
  PersonFound,Continue : Boolean;

begin
  Assignfile (InstructorFile, 'InstructorData.dat');
  reset (InstructorFile);
  Continue := True;
  PersonFound := False;
 if (edtInstMobNumb.Text = '') or (edtInstID.Text = '') or (edtInstEmail.Text = '') or (edtInstName.Text = '') then
    Begin
    ShowMessage('One or more fields have been left empty, please complete the form before submitting');
    Continue := False;
    End;
 if Continue = True then
  if (Length(edtInstID.Text) <> 8) or (Length(edtInstMobNumb.Text) <> 11) then
    Begin
    ShowMessage('One or more fields contain data that is invalid, please revise your entry');
    Continue := False;
    End;
 if Continue = True then

 while not eof (InstructorFile) and not PersonFound do
  begin
    read(InstructorFile,Person);
    with Person do
    begin
         if InstructorID = strtoint(edtInstID.text) then
         begin
              PersonFound := True;
              Continue := False;
              ShowMessage('We are sorry, but there already seems to be records of you in the database, try the existing member section of the sign-up page.');
         end;
    end;
  end;
      seek(InstructorFile, filesize(InstructorFile));
if Continue = True then
  Begin
    with Person do Begin
    InstructorID := StrtoInt(edtInstID.Text);
    MobileNumber := edtInstMobNumb.Text;
    InstructorName := edtInstName.Text;
    EmailAddress := edtInstEmail.Text;
    End;
    write(InstructorFile, Person);
    ShowMessage('Welcome to the team');
    CloseFile(InstructorFile);
 end
Else
  CloseFile(InstructorFile);
end;


end.
