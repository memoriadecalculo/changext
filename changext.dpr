program changext;

{$APPTYPE CONSOLE}

uses
  SysUtils,

  uListagem in 'uListagem.pas' {frmListagem},
  Classes;

var Arquivo,NovoArquivo: string;
    Contador: integer;

label FIM;

procedure Ajuda;
begin
 Writeln;
 Writeln('Author:    LogX ECDESA (logx@ecdesa.com).');
 Writeln('changext:  It changes files extension "EXT1" to "EXT2" in the directory "DIR".');
 Writeln('Parameters:');
 Writeln('           DIR:  Required. Directory to change extensions.');
 Writeln('           EXT1: Required. Extension to substitute.');
 Writeln('           EXT2: Required. New extension.');
 Writeln('Returns:');
 Writeln('           0: Operation successfully completed.');
 Writeln('           1: Parameters wrong.');
 Writeln('           2: Directory doesn''t exist.');
 Writeln('           3: One or more files couldn''t be changed.');
 ExitCode:=1;
end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
ExitCode:=0;
if (ParamCount <> 3)or(ParamStr(1)='/?') then Ajuda;
if ExitCode <> 0 then Exit;

Writeln(DateTimeToStr(Now())+' - Initializing changext...');
Contador:=0;
Write(DateTimeToStr(Now())+' - Checking directory "'+ParamStr(1)+'"...');
if DirectoryExists(ParamStr(1))
 then
  begin
   Writeln('OK.');
  end
 else
  begin
   Writeln('NOT EXIST!!!');
   ExitCode:=2;
   GOTO FIM;
  end;
try
 try
  frmListagem:=TfrmListagem.Create(nil);
  Writeln(DateTimeToStr(Now())+' - Listing files "'+ParamStr(2)+'" in directory "'+ParamStr(1)+'"...');
  frmListagem.ListDir.Mask:='*'+ParamStr(2);
  frmListagem.ListDir.Directory:=ParamStr(1);
  Writeln(DateTimeToStr(Now())+' - '+IntToStr(frmListagem.ListDir.Items.Count)+' files found.');
  for Arquivo in frmListagem.ListDir.Items do
   begin
    NovoArquivo:=ChangeFileExt(Arquivo,ParamStr(3));
    Write(DateTimeToStr(Now())+' - Changing "'+Arquivo+'" to "'+NovoArquivo+'"...');
    if RenameFile(Arquivo,NovoArquivo)
     then
      begin
       Writeln('OK.');
       Inc(Contador);
      end
     else
      begin
       Writeln('NOT OK!!!');
       ExitCode:=3;
      end;
   end;
 except
  Writeln(DateTimeToStr(Now())+' - FATAL ERROR!');
 end;
finally
 FreeAndNil(frmListagem);
 Writeln(DateTimeToStr(Now())+' - '+IntToStr(Contador)+' files changed.');
end;

FIM:
Writeln(DateTimeToStr(Now())+' - changext finished.');
end.
