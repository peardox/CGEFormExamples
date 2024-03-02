//---------------------------------------------------------------------------

#include <fmx.h>
#pragma hdrstop

#include "FMXFormUnit.h"
#include <System.SysUtils.hpp>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Fmx.CastleControl"
#pragma resource "*.fmx"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
	CastleControl1->Parent = this;
	CastleApp = new TCastleApp(CastleControl1);
	CastleControl1->Container->View = CastleApp;

	RadioButton1->Text = "2D";
	RadioButton2->Text = "3D";
	RadioButton1->GroupName = "ViewMode";
	RadioButton2->GroupName = "ViewMode";
	RadioButton2->IsChecked = True;

}
//---------------------------------------------------------------------------

void __fastcall TForm1::RadioButton1Click(TObject *Sender)
{
   CastleApp->SwitchView3D(False);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::RadioButton2Click(TObject *Sender)
{
   CastleApp->SwitchView3D(True);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TrackBar1Change(TObject *Sender)
{
  Label1->Text = "Rotation : " + FormatFloat("###",TrackBar1->Value);
  CastleApp->SetRotation(TrackBar1->Value);
}
//---------------------------------------------------------------------------

