//---------------------------------------------------------------------------

#ifndef CastleAppUnitH
#define CastleAppUnitH
//---------------------------------------------------------------------------
#include "CastleUIControls.hpp"
#include "CastleScene.hpp"
#include "CastleViewport.hpp"
#include "CastleVectors.hpp"
#include "CastleBoxes.hpp"
#include "CastleTransform.hpp"
#include <System.Math.hpp>
//---------------------------------------------------------------------------
class TCastleApp : public TCastleView
{
private:	// User declarations
	TCastleCamera *Camera;
	TCastleDirectionalLight *CameraLight;
	TCastleViewport *Viewport;
	__fastcall void LoadViewport();
	__fastcall void ViewFromRadius(const Single ARadius, const TVector3 ACamPos);
	__fastcall TCastleDirectionalLight* CreateDirectionalLight(TVector3 LightPos);
	__fastcall TCastleScene* LoadScene(String filename);
	__fastcall void NormalizeScene(TCastleScene *Scene);
public:		// User declarations
	TCastleScene *ActiveScene;
	__fastcall TCastleApp(TComponent* Owner);
	__fastcall virtual ~TCastleApp();
	__fastcall void SwitchView3D(const bool Use3D);
	__fastcall void SetRotation(const float ARotDeg);
	virtual __fastcall void Start();
	virtual __fastcall void Stop();
	virtual __fastcall void Resize();
	virtual __fastcall void Update(const float SecondsPassed, bool &HandleInput);
};
//---------------------------------------------------------------------------
// extern PACKAGE TCastleControl *CastleControl1;
//---------------------------------------------------------------------------

#endif
