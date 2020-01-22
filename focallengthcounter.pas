unit focalLengthCounter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
const
  //sqrt(sqr(24)+sqr(36))
  //referenceDiagonal = 43.2666153056; //diagonal of 35mm full frame sensor
  referenceDiagonal = sqrt(sqr(24)+sqr(36));




function diagonal(x, y: real): real; //x and y are the sizes of sensor
function cropFactor(x, y: real): real;
function focalLengthEquivalent(fl: real; cr: real): integer;

implementation

function diagonal(x, y: real): real; //x and y are the sizes of sensor
begin
  diagonal := Sqrt(sqr(x) + sqr(y));
  //diagonal := abs(y)* sqrt(1 + sqr(x/y));
end;

function cropFactor(x, y: real): real;
var
    diag: real;
begin
  diag := diagonal(x, y);
  cropFactor := referenceDiagonal / diag;
end; //cropFactor

function focalLengthEquivalent(fl: real; cr: real): integer;
begin
  focalLengthEquivalent := round(fl * cr);
end;



begin

end.

