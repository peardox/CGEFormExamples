unit VCLFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CastleControl,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  CastleAppUnit
  ;

type
  { TForm }
  TForm1 = class(TForm)
    CastleControl1: TCastleControl;
    Panel1: TPanel;
    RadioGroup1: TRadioGroup;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
    CastleApp: TCastleApp;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  CastleControl1.Align := TAlign.alClient;
  CastleControl1.Parent := Self;
  CastleApp := TCastleApp.Create(CastleControl1);
  CastleControl1.Container.View := CastleApp;

  RadioGroup1.Items.Add('2D');
  RadioGroup1.Items.Add('3D');
  RadioGroup1.ItemIndex := 1;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
    CastleApp.SwitchView3D(False)
  else
    CastleApp.SwitchView3D(True);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  if Assigned(CastleApp.ActiveScene) then
    begin
      Label1.Caption := 'Rotation : ' + IntToStr(Trackbar1.Position);
      CastleApp.SetRotation(Trackbar1.Position);
    end;
end;

end.
