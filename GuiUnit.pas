unit GuiUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, Vcl.Grids, Vcl.ColorGrd,
  SudokuUnit;

type
  TForm1 = class(TForm)
    Image1: TImage;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  var value: string := '';
  var Board: SudokuBoard;
  for var i := 0 to 8 do begin
    for var j := 0 to 8 do begin
      if StringGrid1.Cells[i, j].IsEmpty then Value := value + '0'
      else value := value + StringGrid1.Cells[i, j];
    end;
  end;
  Board := SudokuBoard.Create(value);
  Board.Solve;
  var c: Byte := 1;
  for var i := 0 to 8 do begin
    for var j := 0 to 8 do begin
      StringGrid1.Cells[i, j] := Board.print[c];
      Inc(c);
    end;
  end;
  Board.Destroy;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  for var i := 0 to 8 do begin
    for var j := 0 to 8 do begin
      StringGrid1.Cells[i, j] := '';
    end;
  end;
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  with StringGrid1.Canvas do
  begin
    Font.Color := clBlue;
    Font.Style := [fsBold];
    TextRect(Rect, Rect.Left + 18 , Rect.Top + 10 ,StringGrid1.Cells[ACol, ARow]);
  end;
end;

procedure TForm1.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
begin
  with Sender as TStringGrid do begin
    if (length(value) > 1) then begin
      Cells[ACol,ARow] := copy(value,1,length (value)-1);
      EditorMode := true;
    end
    else if not((Cells[Acol, ARow] = '1') or (Cells[Acol, ARow] = '2') or (Cells[Acol, ARow] = '3') or (Cells[Acol, ARow] = '4') or (Cells[Acol, ARow] = '5') or (Cells[Acol, ARow] = '6') or (Cells[Acol, ARow] = '7') or (Cells[Acol, ARow] = '8') or (Cells[Acol, ARow] = '9')) then
      Cells[ACol,ARow] := '';
  end;
end;

end.
