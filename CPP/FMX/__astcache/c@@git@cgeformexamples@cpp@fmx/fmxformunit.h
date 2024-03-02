//---------------------------------------------------------------------------

#ifndef FMXFormUnitH
#define FMXFormUnitH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include "Fmx.CastleControl.hpp"
#include <FMX.Controls.Presentation.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Types.hpp>
#include "CastleAppUnit.h"
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TCastleControl *CastleControl1;
	TPanel *Panel1;
	TLabel *Label1;
	TTrackBar *TrackBar1;
	TLabel *Label2;
	TRadioButton *RadioButton1;
	TRadioButton *RadioButton2;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall RadioButton1Click(TObject *Sender);
	void __fastcall RadioButton2Click(TObject *Sender);
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
