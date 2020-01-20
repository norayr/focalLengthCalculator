unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    calculateButton: TButton;
    lensEquivalent: TEdit;
    lensFocalLengthEquivalentLabel: TLabel;
    lensMultiplicationFactor: TEdit;
    lensMultiplicationFactorLabel: TLabel;
    sensorSizesComboBox: TComboBox;
    focalLength: TEdit;
    focalLengthLabel: TLabel;
    sensorSizeLabel: TLabel;
    procedure FormCreate(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation
  uses focalLengthCounter;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
    j : integer;
begin
  focalLengthLabel.Caption:= 'focal length (mm):';
  focalLength.Text:= '';

  sensorSizeLabel.Caption:= 'sensor size:';
  sensorSizesComboBox.Text:= 'choose sensor';
  for j := low(focalLengthCounter.sensorSizeComments) to high(focalLengthCounter.sensorSizeComments) do begin
    sensorSizesComboBox.Items.Add(focalLengthCounter.sensorSizeComments[j]);
  end;

  lensMultiplicationFactorLabel.Caption := 'lens multiplication factor:';
  lensMultiplicationFactor.Text:= '';
  lensMultiplicationFactor.ReadOnly:= true;

  lensFocalLengthEquivalentLabel.Caption:= 'lens equivalent:';
  lensEquivalent.Text:= '';
  lensEquivalent.ReadOnly:= true;

  calculateButton.Caption:= 'calculate!';
end;

end.

