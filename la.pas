unit LA;

interface

uses Math;

type
  TVec2 = Array [0..1] of Float;
  TVec3 = Array [0..2] of Float;
  TVec4 = Array [0..3] of Float;

  TUV = TVec2;
  TRGB = TVec3;
  TRGBA = TVec4;

function Lerp(A, B, T : Float) : Float;

function Vec2(X, Y : Float) : TVec2;
function Vec2S(X : Float) : TVec2;
function Vec2Add(A, B : TVec2) : TVec2;
function Vec2Sub(A, B : TVec2) : TVec2;
function Vec2Mul(A, B : TVec2) : TVec2;
function Vec2Div(A, B : TVec2) : TVec2;
function Vec2Max(A, B : TVec2) : TVec2;
function Vec2Min(A, B : TVec2) : TVec2;
function Vec2SqrLen(A : TVec2) : Float;
function Vec2Len(A : TVec2) : Float;
function Vec2Lerp(A, B, T : TVec2) : TVec2;
function Vec2Sqrt(A : TVec2) : TVec2;
function Vec2Pow(B, E : TVec2) : TVec2;

operator + (A, B : TVec2) Z : TVec2;
operator - (A, B : TVec2) Z : TVec2;
operator * (A, B : TVec2) Z : TVec2;
operator / (A, B : TVec2) Z : TVec2;

function Vec3(X, Y, Z : Float) : TVec3;
function Vec3S(X : Float) : TVec3;
function Vec3Add(A, B : TVec3) : TVec3;
function Vec3Sub(A, B : TVec3) : TVec3;
function Vec3Mul(A, B : TVec3) : TVec3;
function Vec3Div(A, B : TVec3) : TVec3;
function Vec3Max(A, B : TVec3) : TVec3;
function Vec3Min(A, B : TVec3) : TVec3;
function Vec3SqrLen(A : TVec3) : Float;
function Vec3Len(A : TVec3) : Float;
function Vec3Lerp(A, B, T : TVec3) : TVec3;
function Vec3Sqrt(A : TVec3) : TVec3;
function Vec3Pow(B, E : TVec3) : TVec3;

operator + (A, B : TVec3) Z : TVec3;
operator - (A, B : TVec3) Z : TVec3;
operator * (A, B : TVec3) Z : TVec3;
operator / (A, B : TVec3) Z : TVec3;

function Vec4(X, Y, Z, W : Float) : TVec4;
function Vec4S(X : Float) : TVec4;
function Vec4Add(A, B : TVec4) : TVec4;
function Vec4Sub(A, B : TVec4) : TVec4;
function Vec4Mul(A, B : TVec4) : TVec4;
function Vec4Div(A, B : TVec4) : TVec4;
function Vec4Max(A, B : TVec4) : TVec4;
function Vec4Min(A, B : TVec4) : TVec4;
function Vec4SqrLen(A : TVec4) : Float;
function Vec4Len(A : TVec4) : Float;
function Vec4Lerp(A, B, T : TVec4) : TVec4;
function Vec4Sqrt(A : TVec4) : TVec4;
function Vec4Pow(B, E : TVec4) : TVec4;

operator + (A, B : TVec4) Z : TVec4;
operator - (A, B : TVec4) Z : TVec4;
operator * (A, B : TVec4) Z : TVec4;
operator / (A, B : TVec4) Z : TVec4;

implementation

function Lerp(A, B, T : Float) : Float; begin Lerp := A + (B - A) * T end;

function Vec2(X, Y : Float) : TVec2;
begin
  Vec2[0] := X;
  Vec2[1] := Y;
end;

function Vec2S(X : Float) : TVec2; begin Vec2S := Vec2(X, X) end;

function Vec2Add(A, B : TVec2) : TVec2;
var
  I : UInt64;
begin
  for I := 0 to 1 do Vec2Add[I] := A[I] + B[I];
end;

function Vec2Sub(A, B : TVec2) : TVec2;
var
  I : UInt64;
begin
  for I := 0 to 1 do Vec2Sub[I] := A[I] - B[I];
end;

function Vec2Mul(A, B : TVec2) : TVec2;
var
  I : UInt64;
begin
  for I := 0 to 1 do Vec2Mul[I] := A[I] * B[I];
end;

function Vec2Div(A, B : TVec2) : TVec2;
var
  I : UInt64;
begin
  for I := 0 to 1 do Vec2Div[I] := A[I] / B[I];
end;

function Vec2Max(A, B : TVec2) : TVec2;
var
  I : UInt64;
begin
  for I := 0 to 1 do if A[I] < B[I]
  then Vec2Max[I] := B[I] else Vec2Max[I] := A[I];
end;

function Vec2Min(A, B : TVec2) : TVec2;
var
  I : UInt64;
begin
  for I := 0 to 1 do if A[I] > B[I]
  then Vec2Min[I] := B[I] else Vec2Min[I] := A[I];
end;

function Vec2SqrLen(A : TVec2) : Float;
var
  I : UInt64;
begin
  Vec2SqrLen := 0;
  for I := 0 to 1 do Vec2SqrLen := Vec2SqrLen + A[I] * A[I];
end;

function Vec2Len(A : TVec2) : Float; begin Vec2Len := Sqrt(Vec2SqrLen(A)); end;

function Vec2Lerp(A, B, T : TVec2) : TVec2;
var
  I : UInt64;
begin
  for I := 0 to 1 do Vec2Lerp[I] := Lerp(A[I], B[I], T[I]);
end;

function Vec2Sqrt(A : TVec2) : TVec2;
var
  I : UInt64;
begin
  for I := 0 to 1 do Vec2Sqrt[I] := Sqrt(A[I]);
end;

function Vec2Pow(B, E : TVec2) : TVec2;
var
  I : UInt64;
begin
  for I := 0 to 1 do Vec2Pow[I] := Power(B[I], E[I]);
end;

operator + (A, B : TVec2) Z : TVec2; begin Z := Vec2Add(A, B); end;
operator - (A, B : TVec2) Z : TVec2; begin Z := Vec2Sub(A, B); end;
operator * (A, B : TVec2) Z : TVec2; begin Z := Vec2Mul(A, B); end;
operator / (A, B : TVec2) Z : TVec2; begin Z := Vec2Div(A, B); end;

function Vec3(X, Y, Z : Float) : TVec3;
begin
  Vec3[0] := X;
  Vec3[1] := Z;
  Vec3[2] := Y;
end;

function Vec3S(X : Float) : TVec3; begin Vec3S := Vec3(X, X, X) end;

function Vec3Add(A, B : TVec3) : TVec3;
var
  I : UInt64;
begin
  for I := 0 to 2 do Vec3Add[I] := A[I] + B[I];
end;

function Vec3Sub(A, B : TVec3) : TVec3;
var
  I : UInt64;
begin
  for I := 0 to 2 do Vec3Sub[I] := A[I] - B[I];
end;

function Vec3Mul(A, B : TVec3) : TVec3;
var
  I : UInt64;
begin
  for I := 0 to 2 do Vec3Mul[I] := A[I] * B[I];
end;

function Vec3Div(A, B : TVec3) : TVec3;
var
  I : UInt64;
begin
  for I := 0 to 2 do Vec3Div[I] := A[I] / B[I];
end;

function Vec3Max(A, B : TVec3) : TVec3;
var
  I : UInt64;
begin
  for I := 0 to 2 do if A[I] < B[I]
  then Vec3Max[I] := B[I] else Vec3Max[I] := A[I];
end;

function Vec3Min(A, B : TVec3) : TVec3;
var
  I : UInt64;
begin
  for I := 0 to 2 do if A[I] > B[I]
  then Vec3Min[I] := B[I] else Vec3Min[I] := A[I];
end;

function Vec3SqrLen(A : TVec3) : Float;
var
  I : UInt64;
begin
  Vec3SqrLen := 0;
  for I := 0 to 2 do Vec3SqrLen := Vec3SqrLen + A[I] * A[I];
end;

function Vec3Len(A : TVec3) : Float; begin Vec3Len := Sqrt(Vec3SqrLen(A)); end;

function Vec3Lerp(A, B, T : TVec3) : TVec3;
var
  I : UInt64;
begin
  for I := 0 to 2 do Vec3Lerp[I] := Lerp(A[I], B[I], T[I]);
end;

function Vec3Sqrt(A : TVec3) : TVec3;
var
  I : UInt64;
begin
  for I := 0 to 2 do Vec3Sqrt[I] := Sqrt(A[I]);
end;

function Vec3Pow(B, E : TVec3) : TVec3;
var
  I : UInt64;
begin
  for I := 0 to 2 do Vec3Pow[I] := Power(B[I], E[I]);
end;

operator + (A, B : TVec3) Z : TVec3; begin Z := Vec3Add(A, B); end;
operator - (A, B : TVec3) Z : TVec3; begin Z := Vec3Sub(A, B); end;
operator * (A, B : TVec3) Z : TVec3; begin Z := Vec3Mul(A, B); end;
operator / (A, B : TVec3) Z : TVec3; begin Z := Vec3Div(A, B); end;

function Vec4(X, Y, Z, W : Float) : TVec4;
begin
  Vec4[0] := X;
  Vec4[1] := Y;
  Vec4[2] := Z;
  Vec4[3] := W;
end;

function Vec4S(X : Float) : TVec4; begin Vec4S := Vec4(X, X, X, X) end;

function Vec4Add(A, B : TVec4) : TVec4;
var
  I : UInt64;
begin
  for I := 0 to 3 do Vec4Add[I] := A[I] + B[I];
end;

function Vec4Sub(A, B : TVec4) : TVec4;
var
  I : UInt64;
begin
  for I := 0 to 3 do Vec4Sub[I] := A[I] - B[I];
end;

function Vec4Mul(A, B : TVec4) : TVec4;
var
  I : UInt64;
begin
  for I := 0 to 3 do Vec4Mul[I] := A[I] * B[I];
end;

function Vec4Div(A, B : TVec4) : TVec4;
var
  I : UInt64;
begin
  for I := 0 to 3 do Vec4Div[I] := A[I] / B[I];
end;

function Vec4Max(A, B : TVec4) : TVec4;
var
  I : UInt64;
begin
  for I := 0 to 3 do if A[I] < B[I]
  then Vec4Max[I] := B[I] else Vec4Max[I] := A[I];
end;

function Vec4Min(A, B : TVec4) : TVec4;
var
  I : UInt64;
begin
  for I := 0 to 3 do if A[I] > B[I]
  then Vec4Min[I] := B[I] else Vec4Min[I] := A[I];
end;

function Vec4SqrLen(A : TVec4) : Float;
var
  I : UInt64;
begin
  Vec4SqrLen := 0;
  for I := 0 to 3 do Vec4SqrLen := Vec4SqrLen + A[I] * A[I];
end;

function Vec4Len(A : TVec4) : Float; begin Vec4Len := Sqrt(Vec4SqrLen(A)); end;

function Vec4Lerp(A, B, T : TVec4) : TVec4;
var
  I : UInt64;
begin
  for I := 0 to 3 do Vec4Lerp[I] := Lerp(A[I], B[I], T[I]);
end;

function Vec4Sqrt(A : TVec4) : TVec4;
var
  I : UInt64;
begin
  for I := 0 to 3 do Vec4Sqrt[I] := Sqrt(A[I]);
end;

function Vec4Pow(B, E : TVec4) : TVec4;
var
  I : UInt64;
begin
  for I := 0 to 3 do Vec4Pow[I] := Power(B[I], E[I]);
end;

operator + (A, B : TVec4) Z : TVec4; begin Z := Vec4Add(A, B); end;
operator - (A, B : TVec4) Z : TVec4; begin Z := Vec4Sub(A, B); end;
operator * (A, B : TVec4) Z : TVec4; begin Z := Vec4Mul(A, B); end;
operator / (A, B : TVec4) Z : TVec4; begin Z := Vec4Div(A, B); end;

end.
