//---------------------------------------------------------------------------

#pragma hdrstop

#include "CastleAppUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)

__fastcall TCastleApp::TCastleApp(TComponent* Owner) : TCastleView(Owner)
{
}

__fastcall TCastleApp::~TCastleApp()
{
}

__fastcall void TCastleApp::Start()
{
	TCastleView::Start();
	LoadViewport();
	ActiveScene = LoadScene("castle-data:/KayKit/KayKit_Adventurers_1.0_FREE/Characters/gltf/Knight.glb");
	Viewport->Items->Add(ActiveScene);
}

__fastcall void TCastleApp::Stop()
{
	TCastleView::Stop();
};

__fastcall void TCastleApp::Resize()
{
	TCastleUserInterface::Resize();

	Viewport->Width = Container()->UnscaledWidth();
	Viewport->Height = Container()->UnscaledHeight();

	if (Camera->ProjectionType == ptOrthographic)
	{
		if (Viewport->Width > Viewport->Height)
		{
			Camera->Orthographic->Height = 2;
		}
		else
		{
			Camera->Orthographic->Width = 2;
		}
	}
};

__fastcall void TCastleApp::Update(const float SecondsPassed, bool &HandleInput)
{
	TCastleView::Update(SecondsPassed, HandleInput);
}

__fastcall void TCastleApp::LoadViewport()
{
	TVector3 ALightPos;
	ALightPos = Vector3(0,0,1);
	Viewport = new TCastleViewport(this);
	Viewport->FullSize = False;
	Viewport->Width = Container()->UnscaledWidth();
	Viewport->Height = Container()->UnscaledHeight();
	Viewport->Transparent = True;

	Camera = new TCastleCamera(Viewport);

	ViewFromRadius(2, Vector3(1, 1, 1));

	CameraLight = CreateDirectionalLight(ALightPos);

	Camera->Add(CameraLight);

	Viewport->Items->Add(Camera);
	Viewport->Camera = Camera;

	InsertFront(Viewport);

};

__fastcall TCastleDirectionalLight* TCastleApp::CreateDirectionalLight(TVector3 LightPos)
{
	TCastleDirectionalLight *Light = new TCastleDirectionalLight(this);
	Light->Direction = LightPos;
	Light->Color = Vector3(1, 1, 1);
	Light->Intensity = 1;

	return Light;
};

__fastcall void  TCastleApp::SwitchView3D(const bool Use3D)
{
  if(Use3D)
  {
	  Camera->ProjectionType = ptPerspective;
	  ViewFromRadius(2, Vector3(1, 1, 1));
  }
  else
  {
	  Viewport->Setup2D();
	  Camera->ProjectionType = ptOrthographic;
	  Camera->Orthographic->Origin = Castlevectors::Vector2(0.5, 0.5);
  }
  Resize();
};

__fastcall TCastleScene* TCastleApp::LoadScene(String filename)
{
	TCastleScene* NewScene = new TCastleScene(this);
	NewScene->Load(filename);
	NormalizeScene(NewScene);
	return NewScene;
}

__fastcall void TCastleApp::ViewFromRadius(const Single ARadius, const TVector3 ACamPos)
{
  TVector3 Spherical;

  Spherical = ACamPos;
  Spherical.Normalize();
  Spherical = Spherical * ARadius;
  Camera->Up = Vector3(0, 1, 0);
  Camera->Direction = Vector3(-ACamPos.X, -ACamPos.Y, -ACamPos.Z);
  Camera->Translation = Spherical;
};

__fastcall void TCastleApp::NormalizeScene(TCastleScene *Scene)
{
  Single BBMax;
  TBox3D Box;

  if(Scene->RootNode != nullptr)
  {
	Box = Scene->LocalBoundingBox();
	if(!Box.IsEmptyOrZero())
	{
		if(Box.MaxSize() > 0)
		{
			Scene->Center = Vector3(  Min(Box.Data[0].X, Box.Data[1].X) + (Box.SizeX() / 2),
									  Min(Box.Data[0].Y, Box.Data[1].Y) + (Box.SizeY() / 2),
									  Min(Box.Data[0].Z, Box.Data[1].Z) + (Box.SizeZ() / 2));
			Scene->Translation = Vector3(-Scene->Center.X, -Scene->Center.Y, -Scene->Center.Z);
			BBMax = 2 / Box.MaxSize();
			Scene->Scale = Vector3(BBMax, BBMax, BBMax);
		}
	}
  }
}

__fastcall void TCastleApp::SetRotation(const float ARotDeg)
{
  if(ActiveScene != nullptr)
  {
	  ActiveScene->Rotation = Vector4(0, 1, 0,  ARotDeg * M_PI / 180);
  }
};

