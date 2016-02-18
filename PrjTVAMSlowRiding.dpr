program PrjTVAMSlowRiding;

uses
  Forms,
  UnitTVAMSlowRiding in 'UnitTVAMSlowRiding.pas' {FrmHomePage},
  UnitTVAMSignUp in 'UnitTVAMSignUp.pas' {FrmRegister},
  UnitNewStudent in 'UnitNewStudent.pas' {FrmNewStudent},
  UnitTimetable in 'UnitTimetable.pas' {FrmTimetable},
  UnitInstructor in 'UnitInstructor.pas' {FrmInstructor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'TVAM Slow Riding Station';
  Application.CreateForm(TFrmHomePage, FrmHomePage);
  Application.CreateForm(TFrmRegister, FrmRegister);
  Application.CreateForm(TFrmNewStudent, FrmNewStudent);
  Application.CreateForm(TFrmTimetable, FrmTimetable);
  Application.CreateForm(TFrmInstructor, FrmInstructor);
  Application.Run;
end.
