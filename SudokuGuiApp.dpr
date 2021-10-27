program SudokuGuiApp;

uses
  Vcl.Forms,
  GuiUnit in 'GuiUnit.pas' {Form1},
  SudokuUnit in 'SudokuUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
