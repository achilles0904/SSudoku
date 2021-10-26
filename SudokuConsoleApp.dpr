program SudokuConsoleApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  SudokuUnit in 'SudokuUnit.pas';

begin
  var TestBoard: SudokuBoard;
  TestBoard := SudokuBoard.Create('050314060870009403643507192007805210410900000025061907790250840004096005030108670');
  for var i := 0 to 8 do begin
    for var j := 0 to 8 do begin
      Writeln(TestBoard.CheckConstraint(i, j));
    end;
  end;

  Readln;
end.
