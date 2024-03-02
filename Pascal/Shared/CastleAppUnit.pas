unit CastleAppUnit;

interface

uses  System.SysUtils, System.Classes, System.Types, CastleViewport, CastleUIControls, CastleScene, CastleVectors, CastleTransform;

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
    Camera: TCastleCamera;
    CameraLight: TCastleDirectionalLight;
    Viewport: TCastleViewport;
    function CreateDirectionalLight(LightPos: TVector3): TCastleDirectionalLight;
    function LoadScene(filename: String): TCastleScene;
    procedure LoadViewport;
  public
    ActiveScene: TCastleScene;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SwitchView3D(const Use3D: Boolean);
    procedure SetRotation(const ARotDeg: Single);
  end;


implementation

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
  Viewport.Width := Container.UnscaledWidth;
  Viewport.Height := Container.UnscaledHeight;
  if Camera.ProjectionType = ptOrthographic then
    begin
      if Viewport.Width > Viewport.Height then
        Camera.Orthographic.Height := 1
      else
        Camera.Orthographic.Width := 1;
    end;
end;

procedure TCastleApp.SetRotation(const ARotDeg: Single);
begin
   ActiveScene.Rotation := Vector4(0, 1, 0,  ARotDeg * Pi / 180);
end;

procedure TCastleApp.Start;
var
 datadir: String;
begin
  inherited;
  LoadViewport;
  ActiveScene := LoadScene('castle-data:/KayKit/KayKit_Adventurers_1.0_FREE/Characters/gltf/Knight.glb');

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
  Viewport.Width := Container.UnscaledWidth;
  Viewport.Height := Container.UnscaledHeight;
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
        Raise Exception.Create('Error in LoadScene : ' + E.ClassName + ' - ' + E.Message);
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


end.
