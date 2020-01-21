unit focalLengthCounter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
//sqrt(sqr(24)+sqr(36))
//referenceDiagonal = 43.2666153056; //diagonal of 35mm full frame sensor
referenceDiagonal = sqrt(sqr(24)+sqr(36));

var sensormfacts : array [0..18] of real;
    sensorSizeComments : array [0..18] of string;

function diagonal(x, y: integer): real; //x and y are the sizes of sensor
function cropFactor(x, y: integer): real;
function focalLengthEquivalent(fl: integer; cr: real): integer;

implementation

function diagonal(x, y: integer): real; //x and y are the sizes of sensor
begin
  diagonal := Sqrt(sqr(x) + sqr(y));
  //diagonal := abs(y)* sqrt(1 + sqr(x/y));
end;

function cropFactor(x, y: integer): real;
var
    diag: real;
begin
  diag := diagonal(x, y);
  cropFactor := referenceDiagonal / diag;
end; //cropFactor

function focalLengthEquivalent(fl: integer; cr: real): integer;
begin
  focalLengthEquivalent := round(fl * cr);
end;

begin
  //https://en.wikipedia.org/wiki/Crop_factor
  //view-source:https://www.digified.net/focallength/
  //https://www.dpreview.com/forums/post/31310027
  sensormfacts[0] := 8.6; sensorSizeComments[0] := 'Digital Compact with 1/3.6" (5.00mm) sensor';
  sensormfacts[1] := 7.6; sensorSizeComments[1] := 'Digital Compact with 1/3.2" (5.68mm) sensor';
  sensormfacts[2] := 7.2; sensorSizeComments[2] := 'Digital Compact with 1/3" (6.00mm) sensor';
  sensormfacts[3] := 6.4; sensorSizeComments[3] := 'Digital Compact with 1/2.7" (6.72mm) sensor';
  sensormfacts[4] := 6.0; sensorSizeComments[4] := '1/2.5" (7.18mm) sensor (many superzoom and point-and-shoot cameras)';
  sensormfacts[5] := 5.6; sensorSizeComments[5] := '1/2.3" sensor (compacts and compact superzooms, earlier Pentax Q)';
  sensormfacts[6] := 5.4; sensorSizeComments[6] := 'Digital Compact with 1/2" (8.00mm) sensor';
  sensormfacts[7] := 4.8; sensorSizeComments[7] := '1/1.8" (8.93mm) sensor (high-end compacts like Canon Powershot G1 - G7/S90)';
  sensormfacts[8] := 4.5; sensorSizeComments[8] := '1/1.7" (9.50mm) sensor 1/1.7" (high-end compacts, later Pentax Q)';
  sensormfacts[9] := 3.9; sensorSizeComments[9] := '2/3" (11.00mm) sensor (Fujifilm X10, Fujifilm X20, Sony F828, Sony F717)';
  sensormfacts[10] := 2.7; sensorSizeComments[10] := '1" sensor (Nikon 1/CX / Sony RX100-series / Sony RX10 / Canon Powershot G7 X)';
  sensormfacts[11] := 2.0; sensorSizeComments[11] := '4/3" / Four Thirds (22.50mm) sensor (used by Olympus and Panasonic for DSLR and MILC respectively)';
  sensormfacts[12] := 1.7; sensorSizeComments[12] := 'Sigma Foveon X3 (prior to Merrill cameras)';
  sensormfacts[13] := 1.6; sensorSizeComments[13] := 'Canon APS-C (Canon 300D,350D,400D,10D,20D,30D)';
  sensormfacts[14] := 1.5; sensorSizeComments[14] := 'General APS-C (Sigma Foveon X3, Fujifilm X, Nikon DX, Pentax K, Ricoh GXR & GR, Samsung NX, Minolta/Sony α DT & E-Mount (NEX)';
  sensormfacts[15] := 1.3; sensorSizeComments[15] := 'APS-H (Leica M8, Canon 1D MkII)';
  sensormfacts[16] := 1.0; sensorSizeComments[16] := '35mm fullframe(Canon EF, Leica M9, Nikon FX, Pentax K-1, Sony α, FE-Mount, Sony RX1)';
  sensormfacts[17] := 0.79; sensorSizeComments[17] := 'Medium format (Hasselblad, Leaf, Phase One, Pentax 645D, Fujifilm GFX)';
  sensormfacts[18] := 0.64; sensorSizeComments[18] := 'Medium format (Hasselblad, Leaf, Phase One)';

end.

