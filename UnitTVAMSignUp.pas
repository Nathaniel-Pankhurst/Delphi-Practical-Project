unit UnitTVAMSignUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TFrmRegister = class(TForm)
    ImgLogo: TImage;
    LblRegisterTtl: TLabel;
    BtnNewStudent: TButton;
    btnExistingStudent: TButton;
    lblStudMemb: TLabel;
    lblStudName: TLabel;
    lblStudTag: TLabel;
    edtStudMemb: TEdit;
    edtStudName: TEdit;
    edtStudTag: TEdit;
    lblStudDet: TLabel;
    btnCheckSlots: TButton;
    procedure BtnNewStudentClick(Sender: TObject);
    procedure btnExistingStudentClick(Sender: TObject);
    procedure btnCheckSlotsClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;
Type Lesson = Record
  LessonNumber : Integer;
  StartTime : String[5];
  LessonDate : String[8];
  Instructor : Integer;
  Student : Integer;
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
  FrmRegister: TFrmRegister;
  StudentFile : file of Student;
  LessonFile : file of Lesson;
  Identity : Student;
  TimeSlot : Lesson;

implementation

uses UnitNewStudent;

{$R *.dfm}

procedure TFrmRegister.btnCheckSlotsClick(Sender: TObject);
Type LessonTime = Record
  LessonNumber : Integer;
  LessonDate : String[8];
  StartTime : String[5];
  Instructor : Integer;
  Student : Integer;
end;
Var
  LessonFile : file of LessonTime;
  TimeSlot : LessonTime;
  SlotFound : Boolean;
  LessonSearch, DateSearch : String;
  Str, dt : String;
begin
  if EdtStudMemb.Text <> '' then
  begin
    SlotFound := False;
    Assignfile (LessonFile, 'LessonData.dat');
    reset (LessonFile);
    str := '09:00';
    dt := '00/00/00';
    DateSearch := InputBox('Desired Lesson Date', 'Please enter the date on which you would like to have your lesson:', dt);
    ShowMessage('Lessons occur at thirty minute intervals between 9 am and Noon');
    LessonSearch := InputBox('Desired Lesson Time', 'Please enter the timeslot in which you would like to have your lesson:', str);
  while not eof (LessonFile) and not SlotFound do
  begin
    read(lessonFile,timeslot);
    with TimeSlot do
    begin
         if (StartTime = LessonSearch) and (LessonDate = DateSearch) then
         begin
              SlotFound := True;
              if Student = 00000000 then
                Begin
                  ShowMessage('This slot is free, we look forward to seeing you at the time of the lesson.');
                  Student := StrtoInt(edtStudMemb.Text);
                End
              else ShowMessage('We are sorry, but this time slot is currently occupied, please try again with a different time slot.');
         end;
    end;
  end;
  if not SlotFound then
    ShowMessage('We are sorry, but this time slot is unavilable, please try again with a different time slot.');
  closefile(LessonFile);
  end
else
  ShowMessage('You have yet to declare your student details, please refer to either the existing student or new student sections of this page to declare your details before signing up for a lesson.');
end;

procedure TFrmRegister.btnExistingStudentClick(Sender: TObject);
Type Student = Record
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
var
  StudentSearch : Integer;
  StudentFile : file of Student;
  Identity : Student;
  Found : Boolean;
  s : String;
begin
  Found := False;
  Assignfile (StudentFile, 'StudentData.dat');
  reset (StudentFile);
  s := '00000000';
  StudentSearch := StrtoInt(InputBox('Identity Input', 'Please enter your membership number:', s));
  while not eof (StudentFile) and not found do
    begin
    read(StudentFile,Identity);
    with Identity do
    begin
         if MembershipNumber = StudentSearch then
         begin
              Found := true;
              edtStudMemb.Text := InttoStr(MembershipNumber);
              edtStudName.Text := Name;
              edtStudTag.Text := TagName;
         end;
    end;
  end;
  if not found then
    ShowMessage('There is no record of that membership number.');
  closefile(StudentFile);
end;


procedure TFrmRegister.BtnNewStudentClick(Sender: TObject);
begin
  FrmNewStudent.ShowModal;
end;


end.

