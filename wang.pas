program Wang;

uses
  LA,
  Math,
  SysUtils;

const
  TILE_WIDTH_PX   = 64;
  TILE_HEIGHT_PX  = 64;
  ATLAS_WIDTH_TL  = 4;
  ATLAS_HEIGHT_TL = 4;
  ATLAS_WIDTH_PX  = TILE_WIDTH_PX * ATLAS_WIDTH_TL;
  ATLAS_HEIGHT_PX = TILE_HEIGHT_PX * ATLAS_HEIGHT_TL;

type
  TRGBA32 = UInt32;
  TBLTR = Byte;
  TFragShader = function (BLTR : TBLTR; UV : TUV) : TRGB;

function RGBA32(R, G, B : Float) : TRGBA32;
begin
  RGBA32 := (Trunc(B * 255.0) shl 16) or
            (Trunc(G * 255.0) shl 8) or
            Trunc(R * 255.0) or
            $FF000000;
end;

function Stripes(BLTR : TBLTR; UV : TUV) : TRGB;
var
  N : Float = 20.0;
  V : TVec3;
begin
  V := Vec3(Sin(UV[0] * N),
             Sin((UV[0] + UV[1]) * N),
             Cos(UV[1] * N));
  Stripes := V + Vec3S(1.0) * Vec3S(0.5);
end;

function Japan(BLTR : TBLTR; UV : TUV) : TRGB;
var
  A : 0..1;
  R : Float = 0.25;
begin
  A := Ord(Vec2SqrLen(Vec2S(0.5) - UV) > R*R);
  Japan := Vec3(1.0, A, A);
end;

function Wang(BLTR : TBLTR; UV : TUV) : TRGB;
var
  R : Float = 0.50;
  Colors : Array [0..1] of TRGB = (
    (1.0, 0.0, 0.0),
    (0.0, 1.0, 1.0)
    { (1.0, 1.0, 0.0), }
    { (0.0, 0.0, 1.0)  }
    { (0.0, 1.0, 0.0), }
    { (1.0, 0.0, 1.0)  }
    { (0.0, 0.0, 0.0), }
    { (1.0, 1.0, 1.0)  }
  );
  Sides : Array [0..3] of TVec2 = (
    (1.0, 0.5),
    (0.5, 0.0),
    (0.0, 0.5),
    (0.5, 1.0)
  );
  I : UInt64;
  T : Float;
begin
  Wang := Vec3S(0.0);
  for I := 0 to 3 do
  begin
    T := 1.0 - Min(Vec2Len(Sides[I] - UV) / R, 1.0);
    Wang := Vec3Lerp(Wang, Colors[BLTR and 1], Vec3S(T));
    BLTR := BLTR shr 1;
  end;
  Wang := Vec3Pow(Wang, Vec3S(1.0 / 2.2));
end;

procedure GenerateTile32(var Pixels : Array of TRGBA32; Width, Height, Stride : UInt64; BLTR : TBLTR; Shader : TFragShader);
var
  X, Y : UInt64;
  U, V : Float;
  P : TRGB;
begin
  for Y := 0 to Height - 1 do
    for X := 0 to Width - 1 do
    begin
      U := X / Width;
      V := Y / Height;
      P := Shader(BLTR, Vec2(U, V));
      Pixels[Y * Stride + X] := RGBA32(P[0], P[1], P[2]);
    end;
end;

var
  Tile : Array of TRGBA32;
  Atlas : Array of TRGBA32;
  X, Y, I : UInt64;
  BLTR : TBLTR;
  PPMFIle : File of Byte;
  Header : String;
  Bytes : Array [0..2] of Byte;
begin
  SetLength(Tile, TILE_WIDTH_PX*TILE_HEIGHT_PX);
  SetLength(Atlas, ATLAS_WIDTH_PX*ATLAS_HEIGHT_PX);

  for BLTR := 0 to 15 do
  begin
    Y := Trunc((BLTR div ATLAS_WIDTH_TL)*TILE_WIDTH_PX);
    X := Trunc((BLTR mod ATLAS_WIDTH_TL)*TILE_WIDTH_PX);

    WriteLn('[INFO] Generating seed ' + IntToStr(BLTR));

    GenerateTile32(
      Atlas[Y*ATLAS_WIDTH_PX + X],
      TILE_WIDTH_PX, TILE_HEIGHT_PX, ATLAS_WIDTH_PX,
      BLTR, @Wang
    );
  end;

  Assign(PPMFIle, 'wang.ppm');
  ReWrite(PPMFIle);

  Header := 'P6' + #10 + IntToStr(ATLAS_WIDTH_PX) + ' ' + IntToStr(ATLAS_HEIGHT_PX) + #10 + '255' + #10;
  BlockWrite(PPMFIle, Header[1], Length(Header));

  for I := 0 to ATLAS_WIDTH_PX*ATLAS_HEIGHT_PX - 1 do
  begin
    Bytes[0] := Atlas[I] and $ff;
    Bytes[1] := (Atlas[I] shr 8) and $ff;
    Bytes[2] := (Atlas[I] shr 16) and $ff;
    BlockWrite(PPMFIle, Bytes, 3);
  end;

  Close(PPMFIle);
end.
