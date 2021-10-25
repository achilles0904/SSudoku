program SudokuConsoleApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  SudokuUnit in 'SudokuUnit.pas';

begin
  var TestBoard: SudokuBoard;
  TestBoard := SudokuBoard.create('050314060870009403643507192007805210410900000025061907790250840004096005030108670');

  Readln;
end.
