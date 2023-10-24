program FMXExample;
  {$WARN DUPLICATE_CTOR_DTOR OFF}
uses
  System.StartUpCopy,
  FMX.Forms,
  FMXFormUnit in 'FMXFormUnit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
