unit SudokuUnit;

interface

uses System.SysUtils;

type
  SudokuBoard = class
  private
    cell: array [0..9, 0..9] of char;
  public
    constructor create(i: string);
    destructor destroy;
  end;

type
  ESudokuFormat = Class(Exception);

implementation

{ SudokuBoard }

destructor SudokuBoard.destroy;
begin
  //Board destroyed
end;

constructor SudokuBoard.create(i: string);
begin
  if i.length <> 81 then raise ESudokuFormat.Create('Invalid Input');
  var c: Byte := 1;

  for var y := 0 to 8 do begin
    for var x := 0 to 8 do begin
      if (i[c] = '0') or (i[c] = '1') or (i[c] = '2') or (i[c] = '3') or (i[c] = '4') or (i[c] = '5') or (i[c] = '6') or (i[c] = '7') or (i[c] = '8') or (i[c] = '9') then begin
        cell[y][x] := i[c];
        Write(cell[y][x] + ' ');
        Inc(c);
      end else raise ESudokuFormat.Create('Invalid Input');
    end;
    Writeln;
  end;

end;

end.
