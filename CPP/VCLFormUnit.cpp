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
  CastleControl1->Align = alClient;
  CastleControl1->Parent = this;
  CastleApp = new TCastleApp(CastleControl1);
  CastleControl1->Container->View = CastleApp;
}
//---------------------------------------------------------------------------

