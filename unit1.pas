unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    calculateButton: TButton;
    customSensorDimensionsCheckBox: TCheckBox;
    FOVDiagonalEdit: TEdit;
    FOVVerticalEdit: TEdit;
    FOVHorizontalEdit: TEdit;
    focalLengthMMLabel: TLabel;
    FOVLabel: TLabel;
    FOVHorizontalLabel: TLabel;
    FOVVerticalLabel: TLabel;
    FOVDiagonalLabel: TLabel;
    sensorXLabel: TLabel;
    sensorYLabel: TLabel;
    sensorXEdit: TEdit;
    sensorYEdit: TEdit;
    lensEquivalent: TEdit;
    lensFocalLengthEquivalentLabel: TLabel;
    lensMultiplicationFactor: TEdit;
    lensMultiplicationFactorLabel: TLabel;
    sensorSizesComboBox: TComboBox;
    focalLength: TEdit;
    focalLengthLabel: TLabel;
    sensorSizeLabel: TLabel;
    procedure calculateButtonClick(Sender: TObject);
    procedure customSensorDimensionsCheckBoxChange(Sender: TObject);
    procedure focalLengthKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure sensorSizesComboBoxChange(Sender: TObject);
    procedure sensorSizesComboBoxSelect(Sender: TObject);
    procedure sensorXEditKeyPress(Sender: TObject; var Key: char);
    procedure sensorYEditKeyPress(Sender: TObject; var Key: char);
    procedure calculate;
  private

  public

  end;

var
  Form1: TForm1;

implementation
  uses focalLengthCounter, sensorsdb;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
    j : integer;
    sns : sensorsdb.pSensor;
begin
  Form1.Caption:= 'focal length calculator';

  focalLengthLabel.Caption:= 'focal length:';
  focalLength.Text:= '';
  focalLengthMMLabel.Caption:= 'mm';

  sensorSizeLabel.Caption:= 'sensor size:';
  sensorSizesComboBox.Text:= 'choose sensor';
  sensorsdb.initialize;
  for j := 0 to sensorsdb.sensors.Count - 1 do begin
      sns := sensorsdb.pSensor(sensorsdb.sensors[j]);
      sensorSizesComboBox.Items.Add(sns^.desc);
  end;

  lensMultiplicationFactorLabel.Caption := 'lens multiplication factor:';
  lensMultiplicationFactor.Text:= '';
  lensMultiplicationFactor.ReadOnly:= true;

  lensFocalLengthEquivalentLabel.Caption:= 'lens equivalent:';
  lensEquivalent.Text:= '';
  lensEquivalent.ReadOnly:= true;

  calculateButton.Caption:= 'calculate!';

  customSensorDimensionsCheckBox.Caption := 'enter custom sensor sizes';
  customSensorDimensionsCheckBox.Checked := false;

  sensorXLabel.Caption := 'mm';
  sensorYLabel.Caption := 'mm';
  sensorXEdit.Text := '';
  sensorYEdit.Text := '';

  sensorXEdit.Enabled:= false;
  sensorYEdit.Enabled:= false;
  sensorSizesComboBox.Enabled:= true;

  FOVLabel.Caption:= 'FOV:';
  FOVHorizontalLabel.Caption:= 'horizontal:';
  FOVHorizontalEdit.Text:= '';
  FOVHorizontalEdit.ReadOnly:= true;
  FOVVerticalLabel.Caption:= 'vertical:';
  FOVVerticalEdit.Text:= '';
  FOVVerticalEdit.ReadOnly:= true;
  FOVDiagonalLabel.Caption:= 'diagonal:';
  FOVDiagonalEdit.Text:= '';
  FOVDiagonalEdit.ReadOnly:= true;



end;

procedure TForm1.sensorXEditKeyPress(Sender: TObject; var Key: char);
begin
   if not (Key in [#8, '0'..'9']) then begin
     //ShowMessage('Invalid key');
     // Discard the key
     Key := #0;
   end; //if
end;

procedure TForm1.sensorYEditKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in [#8, '0'..'9']) then begin
    //ShowMessage('Invalid key');
    // Discard the key
    Key := #0;
    end; //if
end;

procedure TForm1.customSensorDimensionsCheckBoxChange(Sender: TObject);
begin
  if customSensorDimensionsCheckBox.Checked then begin
    sensorXEdit.Enabled:= true;
    sensorYEdit.Enabled:= true;
    sensorSizesComboBox.Enabled:= false;
  end
 else
  begin
    sensorXEdit.Enabled:= false;
    sensorYEdit.Enabled:= false;
    sensorSizesComboBox.Enabled:= true;
  end;
end;

procedure TForm1.calculate;
var
    cf: real;
    sns: sensorsdb.pSensor;
begin
  if focalLength.GetTextLen > 0 then begin
    if customSensorDimensionsCheckBox.Checked then begin
      if (sensorXEdit.GetTextLen > 0) and (sensorYEdit.GetTextLen > 0) then begin
         cf := focalLengthCounter.cropFactor(StrToInt(sensorXEdit.Text), StrToInt(sensorYEdit.Text));
         lensMultiplicationFactor.Text:= FloatToStr(cf);
         lensEquivalent.Text:= IntToStr(focalLengthCounter.focalLengthEquivalent(StrToInt(focalLength.Text), cf));

      end
     else
      begin
        Dialogs.ShowMessage ('enter sensor sizes!');
      end
    end
   else
    begin
      //Dialogs.ShowMessage(IntToStr(sensorSizesComboBox.ItemIndex));
      if sensorSizesComboBox.ItemIndex = -1 then begin
       Dialogs.ShowMessage('choose sensor size!');
       end
      else
       begin
         sns := sensorsdb.pSensor(sensorsdb.sensors[sensorSizesComboBox.ItemIndex]);
         lensMultiplicationFactor.Text:= FloatToStr(sns^.mfact);
         lensEquivalent.Text:= IntToStr(focalLengthCounter.focalLengthEquivalent(StrToInt(focalLength.Text), sns^.mfact));
       end;
    end;
  end
 else
  begin
    Dialogs.ShowMessage ('focal length emty!');
  end;

end; //tform1.calculate

procedure TForm1.calculateButtonClick(Sender: TObject);
begin
  calculate;
end;

procedure TForm1.sensorSizesComboBoxChange(Sender: TObject);
begin
  calculate;
end;

procedure TForm1.sensorSizesComboBoxSelect(Sender: TObject);
begin

end;

procedure TForm1.focalLengthKeyPress(Sender: TObject; var Key: char);
begin
     if not (Key in [#8, '0'..'9']) then begin
       //ShowMessage('Invalid key');
       // Discard the key
       Key := #0;
     end; //if
end;

end.

