object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'VCLExample'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object CastleControl1: TCastleControl
    Left = 232
    Top = 144
    Width = 100
    Height = 49
  end
  object Panel1: TPanel
    Left = 0
    Top = 392
    Width = 624
    Height = 49
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      624
      49)
    object Label1: TLabel
      Left = 24
      Top = 4
      Width = 60
      Height = 15
      Caption = 'Rotation : 0'
    end
    object RadioGroup1: TRadioGroup
      Left = 520
      Top = 0
      Width = 97
      Height = 41
      Anchors = [akTop, akRight]
      Caption = 'View Mode'
      Columns = 2
      TabOrder = 0
      OnClick = RadioGroup1Click
    end
    object TrackBar1: TTrackBar
      Left = 16
      Top = 16
      Width = 481
      Height = 32
      Max = 359
      TabOrder = 1
      OnChange = TrackBar1Change
    end
  end
end
