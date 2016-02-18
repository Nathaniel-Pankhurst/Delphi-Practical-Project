unit UnitTVAMSlowRiding;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TFrmHomePage = class(TForm)
    ImgLogo: TImage;
    LblHmPgTtl1: TLabel;
    LblHmPgTtl2: TLabel;
    LblHmPgBnnr: TLabel;
    TmrBnnr: TTimer;
    BtnRegister: TButton;
    btnTimetable: TButton;
    btnInstructors: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TmrBnnrTimer(Sender: TObject);
    procedure BtnRegisterClick(Sender: TObject);
    procedure btnTimetableClick(Sender: TObject);
    procedure btnInstructorsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
Type Lesson = Record
  LessonNumber : Integer;
  LessonDate : String[8];
  StartTime : String[5];
  Instructor : Integer;
  Student : Integer;
end;
var
  FrmHomePage: TFrmHomePage;
  LessonFile : file of Lesson;
  TimeSlot : Lesson;
  PswdTmTbl, PswdIns, spass : String;
implementation

uses UnitTVAMSignUp, UnitTimetable, UnitInstructor;

{$R *.dfm}



procedure TFrmHomePage.FormCreate(Sender: TObject);
Type LessonTime = Record
  LessonDate : String[8];
  LessonNumber : Integer;
  StartTime : String[5];
  Instructor : Integer;
  Student : Integer;
end;
begin
  TmrBnnr.Enabled := True;
  PswdTmTbl := 'SlowRider';
  PswdIns := 'ThamesValley';


end;

procedure TFrmHomePage.TmrBnnrTimer(Sender: TObject);
begin
   if LblHmPgBnnr.Color = clBlack then
      Begin
        LblHmPgBnnr.Color := clGreen;
        LblHmPgBnnr.Font.Color := clBlack;
      End
   else if LblHmPgBnnr.Color = clGreen then
      begin
        LblHmPgBnnr.Color := clBlack;
        LblHmPgBnnr.Font.Color := clWhite;
      end;
end;

procedure TFrmHomePage.btnInstructorsClick(Sender: TObject);
begin
spass := '';
spass := InputBox('Password', 'Access to this part of the program is restricted to instructors, please enter the password for access:', '');
if spass = pswdIns then
  FrmInstructor.showmodal;
end;

procedure TFrmHomePage.BtnRegisterClick(Sender: TObject);
begin
  FrmRegister.ShowModal;
end;

procedure TFrmHomePage.btnTimetableClick(Sender: TObject);
begin
  spass := '';
  spass := InputBox('Password', 'Access to this part of the program is restricted to instructors, please enter the password for access:', '');
  if spass = pswdTmTbl then
    frmTimeTable.Show{Modal};
end;
end.
