object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
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
    Left = 256
    Top = 104
    Width = 100
    Height = 100
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
      Left = 4
      Top = 4
      Width = 60
      Height = 15
      Caption = 'Rotation : 0'
    end
    object RadioGroup1: TRadioGroup
      Left = 520
      Top = 0
      Width = 96
      Height = 41
      Anchors = [akTop, akRight]
      Caption = 'View Mode'
      TabOrder = 0
      OnClick = RadioGroup1Click
    end
    object TrackBar1: TTrackBar
      Left = 0
      Top = 16
      Width = 505
      Height = 37
      Max = 359
      TabOrder = 1
      OnChange = TrackBar1Change
    end
  end
end
