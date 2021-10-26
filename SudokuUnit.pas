unit SudokuUnit;

interface

uses System.SysUtils;

type
  Cell = record
  private
    val: Char;
    ques: Boolean;
    solved: Boolean;
  end;

type
  SudokuBoard = class
  private
    cells: array [0..9, 0..9] of Cell;
    filled: Byte;
  public
    constructor create(i: string);
    destructor destroy;
    procedure solve();
  end;

type
  ESudokuFormat = Class(Exception);

implementation

{ SudokuBoard }

destructor SudokuBoard.destroy;
begin
  //Board destroyed
end;

procedure SudokuBoard.solve;
begin
  while filled <> 81 do begin
    for var y := 0 to 8 do begin
      for var x := 0 to 8 do begin
        if not(cells[y][x].ques) then begin
          if not(cells[y][x].solved) then begin

          end;
        end;
      end;
    end;
  end;
end;

constructor SudokuBoard.create(i: string);
begin
  if i.length <> 81 then raise ESudokuFormat.Create('Invalid Input');
  var c: Byte := 1;
  filled := 0;

  for var y := 0 to 8 do begin
    for var x := 0 to 8 do begin
      if (i[c] = '0') or (i[c] = '1') or (i[c] = '2') or (i[c] = '3') or (i[c] = '4') or (i[c] = '5') or (i[c] = '6') or (i[c] = '7') or (i[c] = '8') or (i[c] = '9') then begin
        cells[y][x].val := i[c];
        if i[c] = '0' then begin
          cells[y][x].ques := False;
          cells[y][x].solved := False;
        end else begin
          cells[y][x].ques := True;
          cells[y][x].solved := True;
          Inc(filled);
        end;
        Write(cells[y][x].val + ' ');
        Inc(c);
      end else raise ESudokuFormat.Create('Invalid Input');
    end;
    Writeln;
  end;
end;

end.
