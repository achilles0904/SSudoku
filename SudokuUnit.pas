unit SudokuUnit;

interface

uses System.SysUtils;

type
  Cell = packed record
  private
    val: Char;
    ques: Boolean;
    solved: Boolean;
  public
    function IncVal: Boolean; inline;
  end;

type
  SudokuBoard = class
  private
    cells: array [0..9, 0..9] of Cell;
  public
    constructor Create(i: string);
    destructor Destroy;
    procedure Solve;
    function CheckConstraint(y, x: Byte): Boolean; inline;
    function Print: string;
  end;

type
  ESudokuFormat = Class(Exception);

implementation

{ SudokuBoard }

destructor SudokuBoard.Destroy;
begin
  //Board destroyed
end;

function SudokuBoard.Print: string;
begin
  Result := '';
  for var y := 0 to 8 do begin
    for var x := 0 to 8 do begin
      Result := Result + cells[y][x].val;
    end;
  end;
end;

procedure SudokuBoard.Solve;
var
  x, y: ShortInt;
  back: Boolean;
begin
  x := 0;
  y := 0;
  back := False;
  while y <= 8 do begin
    if not(back) then x := 0;
    while x <= 8 do begin
      back := False;
      if not(cells[y][x].ques) then begin
        if not(cells[y][x].solved) then begin
          while cells[y][x].IncVal do begin
            if CheckConstraint(y, x) then begin
              cells[y][x].solved := True;
              break;
            end;
          end;
          //Back tracking
          if cells[y][x].val = '0' then begin
            cells[y][x].solved := False;
            repeat
              Dec(x);
              if x < 0 then begin
                Dec(y);
                if y < 0 then raise ESudokuFormat.Create('Unsolvable');
                x := 8;
              end;
              back := True;
            until (not(cells[y][x].ques));
            if back then begin
              cells[y][x].solved := False;
              break;
            end;
          end;
        end;
      end;
      if not(back) then Inc(x);
    end;
    if not(back) then Inc(y);
  end;
end;

function SudokuBoard.CheckConstraint(y, x: Byte): Boolean;
begin
  //Check row
  for var i := 0 to 8 do begin
    for var j := i to 8 do begin
      if (i <> j) then begin
        if (cells[y][j].val = cells[y][i].val) and (cells[y][j].val <> '0') then begin
          Result := False;
          Exit;
        end;
      end;
    end;
  end;

  //Check column
    for var i := 0 to 8 do begin
    for var j := i to 8 do begin
      if (i <> j) then begin
        if (cells[j][x].val = cells[i][x].val) and (cells[j][x].val <> '0') then begin
          Result := False;
          Exit;
        end;
      end;
    end;
  end;

  //Check 3x3
  var bx, by: Byte;
  while ((x + 1) mod 3 <> 0) do Inc(x);
  bx := x;
  while ((y + 1) mod 3 <> 0) do Inc(y);
  by := y;
  for var j := (by - 2) to by do begin
    for var i := (bx - 2) to bx do begin
      for var l := j to by do begin
        for var k := (bx - 2) to bx do begin
          if not((i = k) and (j = l)) then begin
            if (cells[j][i].val = cells[l][k].val) and (cells[j][i].val <> '0') then begin
              Result := False;
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;

  Result := True;
end;

constructor SudokuBoard.Create(i: string);
begin
  if i.length <> 81 then raise ESudokuFormat.Create('Invalid Input');
  var c: Byte := 1;

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
        end;
        Inc(c);
      end else raise ESudokuFormat.Create('Invalid Input');
    end;
  end;
end;

{ Cell }

function Cell.IncVal: Boolean;
begin
  if val = '9' then begin
    Result := False;
    val := '0';
    Exit;
  end;
  val := Char(Ord(val) + 1);
  Result := True;
end;

end.
