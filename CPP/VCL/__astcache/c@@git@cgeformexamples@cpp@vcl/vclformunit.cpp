//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "VCLFormUnit.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Vcl.CastleControl"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
  CastleControl1->Align = alClient;
  CastleControl1->Parent = this;
  CastleApp = new TCastleApp(CastleControl1);
  CastleControl1->Container->View = CastleApp;

  RadioGroup1->Items->Add("2D");
  RadioGroup1->Items->Add("3D");
  RadioGroup1->ItemIndex = 1;
  RadioGroup1->Columns = 2;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::RadioGroup1Click(TObject *Sender)
{
  if(RadioGroup1->ItemIndex == 0)
  {
	CastleApp->SwitchView3D(False);
  }
  else
  {
	CastleApp->SwitchView3D(True);
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TrackBar1Change(TObject *Sender)
{
  Label1->Caption = "Rotation : " + IntToStr(TrackBar1->Position);
  CastleApp->SetRotation(TrackBar1->Position);
}
//---------------------------------------------------------------------------

