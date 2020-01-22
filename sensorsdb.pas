unit sensorsdb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
    pSensor = ^TSensor;

    TSensor = record
      width, height: real; //in mm
      desc: string;
      mfact : real;
      diag: real
     end;

var
    sensors : TList;

procedure initialize;

implementation
uses csvdocument in 'csvdocument/csvdocument.pas', Dialogs;

const
  sensorsFile = 'sensors.csv'; //table taken from https://en.wikipedia.org/wiki/Image_sensor_format

procedure initialize;
var
    Parser: TCSVParser;
    FileStream: TFileStream;
    sensor : pSensor;
begin
  //https://en.wikipedia.org/wiki/Crop_factor
  //view-source:https://www.digified.net/focallength/
  //https://www.dpreview.com/forums/post/31310027
  //table taken from https://en.wikipedia.org/wiki/Image_sensor_format

  //i use simple array of record to make the code more portable, including more portable to other languages
  if not(FileExists(sensorsFile)) then begin
    Dialogs.ShowMessage('cannot find ' + sensorsFile + ' file.');
    exit;
  end;
  Parser := TCSVParser.Create;
  FileStream := TFileStream.Create(sensorsFile, fmOpenRead+fmShareDenyWrite);
  sensors := TList.Create;
  try
    Parser.Delimiter:=',';
    Parser.SetSource(FileStream);
    Parser.ResetParser;
    //skip the header
    //Parser.CurrentRow := 1;
    Parser.ParseNextCell; Parser.ParseNextCell; Parser.ParseNextCell; Parser.ParseNextCell;
    Parser.ParseNextCell; Parser.ParseNextCell; Parser.ParseNextCell; Parser.ParseNextCell;

    while Parser.ParseNextCell do
    begin
      new(sensor);
      sensor^.desc := Parser.CurrentCellText;               Parser.ParseNextCell;
      sensor^.diag := StrToFloat(Parser.CurrentCellText);   Parser.ParseNextCell;
      sensor^.width := StrToFloat(Parser.CurrentCellText);  Parser.ParseNextCell;
      sensor^.height := StrToFloat(Parser.CurrentCellText); Parser.ParseNextCell;
      Parser.ParseNextCell; Parser.ParseNextCell; Parser.ParseNextCell;
      sensor^.mfact := StrToFloat(Parser.CurrentCellText);
      sensors.Add(sensor);
    end;
  finally
    Parser.Free;
    FileStream.Free;
  end;
end; //initialize


end.

