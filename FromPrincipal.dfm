object FrmMaps: TFrmMaps
  Left = 0
  Top = 0
  Caption = 'FrmMaps'
  ClientHeight = 542
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 709
    Height = 501
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 409
    ControlData = {
      4C00000047490000C83300000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 501
    Width = 709
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 312
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Abrir'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
