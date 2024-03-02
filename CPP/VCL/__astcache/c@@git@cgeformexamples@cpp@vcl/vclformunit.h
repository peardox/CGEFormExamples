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
#include <Vcl.ComCtrls.hpp>
#include <System.Math.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TCastleControl *CastleControl1;
	TPanel *Panel1;
	TRadioGroup *RadioGroup1;
	TTrackBar *TrackBar1;
	TLabel *Label1;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall RadioGroup1Click(TObject *Sender);
	void __fastcall TrackBar1Change(TObject *Sender);
private:	// User declarations
	TCastleApp *CastleApp;
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
