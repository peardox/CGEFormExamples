//---------------------------------------------------------------------------

#ifndef VCLFormUnitH
#define VCLFormUnitH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include "Vcl.CastleControl.hpp"
#include <Vcl.ExtCtrls.hpp>
#include "CastleAppUnit.h"
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TCastleControl *CastleControl1;
	TPanel *Panel1;
private:	// User declarations
	TCastleApp *CastleApp;
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
