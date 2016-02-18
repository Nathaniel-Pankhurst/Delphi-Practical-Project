unit UnitTimetable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, jpeg, ExtCtrls;

type
  TFrmTimetable = class(TForm)
    StrGrdTimetable: TStringGrid;
    btnFillTable: TButton;
    btnSearchDate: TButton;
    btnSearchInstructor: TButton;
    ImgLogo: TImage;
    lblTimeTableTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFillTableClick(Sender: TObject);
    procedure btnSearchDateClick(Sender: TObject);
    procedure btnSearchInstructorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
Type LessonTime = Record
  LessonNumber : Integer;
  LessonDate : String[8];
  StartTime : String[5];
  Instructor : Integer;
  Student : Integer;
end;
var
  FrmTimetable: TFrmTimetable;
  LessonFile : file of LessonTime;
  TimeSlot : LessonTime;
implementation

{$R *.dfm}

procedure TFrmTimetable.btnFillTableClick(Sender: TObject);
Type
Lesson = Record
  LessonNumber : Integer;
  LessonDate : String[8];
  StartTime : String[5];
  Instructor : Integer;
  Student : Integer;
end;
Tutor = Record
 InstructorName : String[20];
 InstructorID : Integer;
 MobileNumber : String[11];
 EmailAddress : String[20];
end;

Var
  LessonFile : file of Lesson;
  TimeSlot : Lesson;
  InstructorFile : file of Tutor;
  Person : Tutor;
  i, iInstructor, SizeOfFile : Integer;
  sDate : String;
  Preexistant, Exists : Boolean;
begin
  Assignfile (InstructorFile, 'InstructorData.dat');
  reset(InstructorFile);
  preexistant := false;
  iInstructor := StrtoInt(InputBox('Instructor For Lessons', 'Please enter your Membership Number','00000000'));
  While Not EOF(InstructorFile) And (Exists = False) do
    begin
      with Person do
      if iInstructor = InstructorID then
        Exists := True
      Else
        ShowMessage('There are no records of an instructor with that Membership Number');
        CloseFile(InstructorFile);
    end;
  if Exists = True then
  begin
  sDate := InputBox('Appointment Date', 'Please enter the date of the lessons to create','00/00/00');
  i := 1;
  Assignfile (LessonFile, 'LessonData.dat');
  reset(Lessonfile);
  while not eof (lessonfile) do
  begin
   read(lessonFile,timeslot);
  With Timeslot Do
  if (sDate = LessonDate) and (Instructor = iInstructor) then
    preexistant := True;
  end;
  if Preexistant = False then
  while not (i > 7 ) {eof(Lessonfile)}do
     begin
      seek(Lessonfile, filesize(Lessonfile));
      SizeOfFile := filesize(Lessonfile);
      with timeslot do
        Begin
          LessonDate := sDate;
          case i of
            1: begin
                StartTime := '09:00';
                end;
            2: begin
                StartTime := '09:30';
                end;
            3: begin
                StartTime := '10:00';
                end;
            4: begin
                StartTime := '10:30';
                end;
            5: begin
                StartTime := '11:00';
                end;
            6: begin
                StartTime := '11:30';
                end;
            7: begin
                StartTime := '12:00';
                end;
          end; //case
          LessonNumber := i + SizeOfFile;
          Student := 00000000;
          i := i + 1;
         write(Lessonfile, Timeslot);
        End; //with
    end //while
  else
    ShowMessage('Sorry But there are already lessons on this date');
  end;
  CloseFile(LessonFile);
end;

procedure TFrmTimetable.btnSearchDateClick(Sender: TObject);
Type Lesson = Record
  LessonNumber : Integer;
  LessonDate : String[8];
  StartTime : String[5];
  Instructor : Integer;
  Student : Integer;
  end;
Var
  LessonFile : file of Lesson;
  TimeSlot : Lesson;
  sDate : String;
  i : integer;
begin
  Assignfile (LessonFile, 'LessonData.dat');
  reset(Lessonfile);
  sDate := InputBox('Lesson Date', 'Please enter the date of the lessons','00/00/00');
  while not eof (lessonfile) do
  begin
   read(lessonFile,timeslot);
  end;
  With Timeslot Do
  if (sDate = LessonDate)then
    Begin
          strgrdTimetable.Cells[i, 1] := LessonDate;
          strgrdTimetable.Cells[i, 0] := InttoStr(LessonNumber);
          strgrdTimetable.Cells[i, 2] := StartTime;
          strgrdTimetable.Cells[i, 3] := InttoStr(Instructor);
          strgrdTimetable.Cells[i, 4] := InttoStr(Student);
          i := i + 1
    End
  else
   ShowMessage('Sorry But there are are no lessons on this date');
  CloseFile(LessonFile);
end;

procedure TFrmTimetable.FormCreate(Sender: TObject);
var x,y,t : integer;
begin
   for x := 0 to 7 do begin
    if x = 0 then
      strgrdTimetable.Cells[x, 0] := 'Lesson Number'
    else
      strgrdTimeTable.Cells[x, 0] := InttoStr(x);
   end;
   for y := 1 to 4 do begin
      case y of
        1:strgrdTimetable.Cells[0, y] := 'Date of Lesson';
        2:strgrdTimetable.Cells[0, y] := 'Lesson Time';
        3:strgrdTimetable.Cells[0, y] := 'Instructor ID';
        4:strgrdTimetable.Cells[0, y] := 'Student ID';
      end;

   end;
end;



procedure TFrmTimetable.btnSearchInstructorClick(Sender: TObject);
Type Lesson = Record
  LessonNumber : Integer;
  LessonDate : String[8];
  StartTime : String[5];
  Instructor : Integer;
  Student : Integer;
  end;
Var
  LessonFile : file of Lesson;
  TimeSlot : Lesson;
  sDate : String;
  i,iInstructor : integer;
begin
  Assignfile (LessonFile, 'LessonData.dat');
  reset(Lessonfile);
  sDate := InputBox('Lesson Date', 'Please enter the date of the lessons','00/00/00');
  iInstructor := strtoint(InputBox('Lesson Instructor', 'Please  enter the Instructor ID', '00000000'));
  while not eof (lessonfile) do
  begin
   read(lessonFile,timeslot);
  end;
  With Timeslot Do
  if (sDate = LessonDate) and (iInstructor = Instructor)then
  Begin
        strgrdTimetable.Cells[i, 1] := LessonDate;
        strgrdTimetable.Cells[i, 0] := InttoStr(LessonNumber);
        strgrdTimetable.Cells[i, 2] := StartTime;
        strgrdTimetable.Cells[i, 3] := InttoStr(Instructor);
        strgrdTimetable.Cells[i, 4] := InttoStr(Student);
        i := i + 1
  End;
  CloseFile(LessonFile);
end;
end.
