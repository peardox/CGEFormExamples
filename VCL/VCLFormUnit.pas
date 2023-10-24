unit VCLFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CastleControl,
  CastleViewport, CastleUIControls, CastleScene, CastleVectors, CastleTransform,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls
  ;

type
  { TCastleSceneHelper }
  TCastleSceneHelper = class helper for TCastleScene
    function Normalize: Boolean;
    { Fit the Scene in a 1x1x1 box }
  end;

  { TCastleCameraHelper }
  TCastleCameraHelper = class helper for TCastleCamera
    procedure ViewFromRadius(const ARadius: Single; const ACamPos: TVector3);
    { Position Camera ARadius from Origin pointing at Origin }
  end;

  { TCastleApp }
  TCastleApp = class(TCastleView)
    procedure Update(const SecondsPassed: Single; var HandleInput: Boolean); override; // TCastleUserInterface
    procedure Start; override; // TCastleView
    procedure Stop; override; // TCastleView
    procedure Resize; override; // TCastleUserInterface
  private
    ActiveScene: TCastleScene;
    Camera: TCastleCamera;
    CameraLight: TCastleDirectionalLight;
    Viewport: TCastleViewport;
    function CreateDirectionalLight(LightPos: TVector3): TCastleDirectionalLight;
    function LoadScene(filename: String): TCastleScene;
    procedure LoadViewport;
    procedure SwitchView3D(const Use3D: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

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

uses Math, CastleProjection, CastleFilesUtils;

function TCastleSceneHelper.Normalize: Boolean;
var
  BBMax: Single;
begin
  Result := False;
  if not(RootNode = nil) then
    begin
    if not LocalBoundingBox.IsEmptyOrZero then
      begin
        if LocalBoundingBox.MaxSize > 0 then
          begin
            Center := Vector3(Min(LocalBoundingBox.Data[0].X, LocalBoundingBox.Data[1].X) + (LocalBoundingBox.SizeX / 2),
                              Min(LocalBoundingBox.Data[0].Y, LocalBoundingBox.Data[1].Y) + (LocalBoundingBox.SizeY / 2),
                              Min(LocalBoundingBox.Data[0].Z, LocalBoundingBox.Data[1].Z) + (LocalBoundingBox.SizeZ / 2));
            Translation := -Center;

            BBMax := 1 / LocalBoundingBox.MaxSize;
            Scale := Vector3(BBMax,
                             BBMax,
                             BBMax);
            Result := True;
          end;
      end;
    end;
end;

constructor TCastleApp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCastleApp.Destroy;
begin
  inherited;
end;

procedure TCastleApp.Update(const SecondsPassed: Single; var HandleInput: Boolean);
begin
  inherited;
end;

procedure TCastleApp.Resize;
begin
  Viewport.Width := Container.Width;
  Viewport.Height := Container.Height;
  if Camera.ProjectionType = ptOrthographic then
    begin
      if Viewport.Width > Viewport.Height then
        Camera.Orthographic.Height := 1
      else
        Camera.Orthographic.Width := 1;
    end;
end;

procedure TCastleApp.Start;
var
 datadir: String;
begin
  inherited;
  // Kludgy castle-data finder
  if DirectoryExists('../../../data/') then
    datadir := '../../../data/'
  else if DirectoryExists('../../data/') then
    datadir := '../../data/'
  else if DirectoryExists('data/') then
    datadir := 'data/'
  else
    datadir := '';
  ApplicationDataOverride := datadir;

  LoadViewport;
  ActiveScene := LoadScene('castle-data:/knight.gltf');
  if Assigned(ActiveScene) then
    begin
      ActiveScene.Normalize;
      Viewport.Items.Add(ActiveScene);
    end;
end;

procedure TCastleApp.Stop;
begin
  inherited;
end;

function TCastleApp.CreateDirectionalLight(LightPos: TVector3): TCastleDirectionalLight;
var
  Light: TCastleDirectionalLight;
begin
  Light := TCastleDirectionalLight.Create(Self);

  Light.Direction := LightPos;
  Light.Color := Vector3(1, 1, 1);
  Light.Intensity := 1;

  Result := Light;
end;

procedure TCastleApp.LoadViewport;
begin
  Viewport := TCastleViewport.Create(Self);
  Viewport.FullSize := False;
  Viewport.Width := Container.Width;
  Viewport.Height := Container.Height;
  Viewport.Transparent := True;

  Camera := TCastleCamera.Create(Viewport);

  Camera.ViewFromRadius(2, Vector3(1, 1, 1));

  CameraLight := CreateDirectionalLight(Vector3(0,0,1));
  Camera.Add(CameraLight);

  Viewport.Items.Add(Camera);
  Viewport.Camera := Camera;

  InsertFront(Viewport);
end;

procedure TCastleApp.SwitchView3D(const Use3D: Boolean);
begin
  if Use3D then
    begin
      Camera.ProjectionType := ptPerspective;
      Camera.ViewFromRadius(2, Vector3(1, 1, 1));
    end
  else
    begin
      Viewport.Setup2D;
      Camera.ProjectionType := ptOrthographic;
      Camera.Orthographic.Width := 1;
      Camera.Orthographic.Origin := Vector2(0.5, 0.5);
    end;
  Resize;
end;

function TCastleApp.LoadScene(filename: String): TCastleScene;
begin
  Result := Nil;
  try
    Result := TCastleScene.Create(Self);
    Result.Load(filename);
  except
    on E : Exception do
      begin
        ShowMessage('Error in LoadScene : ' + E.ClassName + ' - ' + E.Message);
       end;
  end;
end;

procedure TCastleCameraHelper.ViewFromRadius(const ARadius: Single; const ACamPos: TVector3);
var
  Spherical: TVector3;
begin
  Spherical := ACamPos.Normalize;
  Spherical := Spherical * ARadius;
  Up := Vector3(0, 1, 0);
  Direction := -ACamPos;
  Translation  := Spherical;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CastleControl1 := TCastleControl.Create(Self);
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
      CastleApp.ActiveScene.Rotation := Vector4(0, 1, 0,  Trackbar1.Position * Pi / 180);
    end;
end;

end.
