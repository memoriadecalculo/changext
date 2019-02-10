unit uListagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl;

type
  TfrmListagem = class(TForm)
    ListDir: TFileListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListagem: TfrmListagem;

implementation

{$R *.dfm}

end.
