program VCLExample;
  {$WARN DUPLICATE_CTOR_DTOR OFF}
uses
  Vcl.Forms,
  VCLFormUnit in 'VCLFormUnit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
