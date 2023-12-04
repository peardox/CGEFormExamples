unit FMXFormUnit;

interface

// {$define use2dview}

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, Fmx.CastleControl,
  FMX.StdCtrls,
  CastleAppUnit
  ;

type
  { TForm }
  TForm1 = class(TForm)
    CastleControl1: TCastleControl;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
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

{$R *.fmx}

uses Math, CastleProjection, CastleFilesUtils;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CastleControl1.Align := TAlignLayout.Client;
  CastleControl1.Parent := Self;
  CastleApp := TCastleApp.Create(CastleControl1);
  CastleControl1.Container.View := CastleApp;

  RadioButton1.Text := '2D';
  RadioButton2.Text := '3D';
  RadioButton1.GroupName := 'ViewMode';
  RadioButton2.GroupName := 'ViewMode';
  RadioButton2.IsChecked := True;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  CastleApp.SwitchView3D(False);
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  CastleApp.SwitchView3D(True);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  if Assigned(CastleApp.ActiveScene) then
    begin
      Label1.Text := 'Rotation : ' + IntToStr(floor(Trackbar1.Value));
      CastleApp.SetRotation(Trackbar1.Value);
    end;
end;

end.
