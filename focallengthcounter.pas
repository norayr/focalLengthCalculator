unit focalLengthCounter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

var sensormfacts : array [1..14] of real;
    sensorSizeComments : array [1..14] of string;
implementation

begin

  sensormfacts[1] := 8.6; sensorSizeComments[1] := 'Digital Compact with 1/3.6" (5.00mm) sensor';
  sensormfacts[2] := 7.6; sensorSizeComments[2] := 'Digital Compact with 1/3.2" (5.68mm) sensor';
  sensormfacts[3] := 7.2; sensorSizeComments[3] := 'Digital Compact with 1/3" (6.00mm) sensor';
  sensormfacts[4] := 6.4; sensorSizeComments[4] := 'Digital Compact with 1/2.7" (6.72mm) sensor';
  sensormfacts[5] := 6.0; sensorSizeComments[5] := 'Digital Compact with 1/2.5" (7.18mm) sensor';
  sensormfacts[6] := 5.7; sensorSizeComments[6] := 'Digital Compact with 1/2.3" sensor';
  sensormfacts[7] := 5.4; sensorSizeComments[7] := 'Digital Compact with 1/2" (8.00mm) sensor';
  sensormfacts[8] := 4.8; sensorSizeComments[8] := 'Digital Compact with 1/1.8" (8.93mm) sensor';
  sensormfacts[9] := 4.5; sensorSizeComments[9] := 'Digital Compact with 1/1.7" (9.50mm) sensor';
  sensormfacts[10] := 4.0; sensorSizeComments[10] := 'Digital Compact with 2/3" (11.00mm) sensor';
  sensormfacts[11] := 2.0; sensorSizeComments[11] := 'Digital Compact with 4/3" (22.50mm) sensor';
  sensormfacts[12] := 1.6; sensorSizeComments[12] := 'Digital SLR with 1.6 cropfactor (Canon 300D,350D,400D,10D,20D,30D)';
  sensormfacts[13] := 1.5; sensorSizeComments[13] := 'Digital SLR with 1.5 cropfactor (Nikon, Fuji)';
  sensormfacts[14] := 1.3; sensorSizeComments[14] := 'Digital SLR with 1.3 cropfactor (Canon 1D MkII)';


end.

