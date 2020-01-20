unit stringHelpers;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

function StringListFromStrings(const Strings: array of string): TStringList;

implementation

function StringListFromStrings(const Strings: array of string): TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := low(Strings) to high(Strings) do
    Result.Add(Strings[i]);
end;

end.

