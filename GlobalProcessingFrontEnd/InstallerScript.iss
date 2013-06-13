; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "FLIMfit"
#define MyAppPublisher "Sean Warren"
#define RepositoryRoot "C:\Users\scw09\Documents\Repositories\FLIMGlobalProcessingDev"
#define MyAppCopyright "(c) Imperial College London"


; These options need to be set on the commandline, eg. > iscc \dMyAppVersion=4.2.8 \dMyAppSystem=64 "InstallerScript.iss"
;#define MyAppVersion "4.2.8"
;#define MyAppSystem 64 / 32

; Define Matlab compiler runtime download and required version
#define McrUrl32 "http://www.mathworks.co.uk/supportfiles/MCR_Runtime/R2013b/MCR_R2013b_win32_installer.exe"
#define McrUrl64 "http://www.mathworks.co.uk/supportfiles/MCR_Runtime/R2013b/MCR_R2013b_win64_installer.exe"
#define McrVersionRequired "8.1"

; Define Ghostscript download urls and required version
#define GhostscriptUrl32 "http://ghostscript.googlecode.com/files/gs871w32.exe"
#define GhostscriptUrl64 "http://ghostscript.googlecode.com/files/gs871w64.exe"
#define GhostscriptVersionRequired "8.71"

#include ReadReg(HKEY_LOCAL_MACHINE,'Software\Sherlock Software\InnoTools\Downloader','ScriptPath','')

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
#if MyAppSystem == "32"
#define MyAppArch "x86"
ArchitecturesAllowed=x86 x64
#else
#define MyAppArch "x64"
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
#endif

AppId={{5B6988D3-4B10-4DC8-AE28-E29DF8D99C39}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}\{#MyAppName} {#MyAppVersion}
DefaultGroupName={#MyAppName}
OutputDir={#RepositoryRoot}\FLIMfitStandalone\Installer
OutputBaseFilename=FLIMFit {#MyAppVersion} Setup {#MyAppArch}
SetupIconFile={#RepositoryRoot}\GlobalProcessingFrontEnd\DeployFiles\microscope.ico
Compression=lzma
SolidCompression=yes


ShowLanguageDialog=no
AppCopyright={#MyAppCopyright}
LicenseFile={#RepositoryRoot}\GlobalProcessingFrontEnd\LicenseFiles\GPL Licence.txt
AllowUNCPath=False
VersionInfoVersion={#MyAppVersion}
MinVersion=0,5.01sp3

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "{#RepositoryRoot}\FLIMfitStandalone\InstallerSupport\unzip.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "{#RepositoryRoot}\FLIMfitStandalone\InstallerSupport\vcredist_{#MyAppArch}.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "{#RepositoryRoot}\FLIMfitStandalone\FLIMfit_{#MyAppVersion}_PCWIN{#MyAppSystem}\Start_FLIMfit_{#MyAppSystem}.exe"; DestDir: "{app}"; Flags: ignoreversion {#MyAppSystem}bit
Source: "{#RepositoryRoot}\FLIMfitStandalone\FLIMfit_{#MyAppVersion}_PCWIN{#MyAppSystem}\FLIMGlobalAnalysis_{#MyAppSystem}.dll"; DestDir: "{app}"; Flags: ignoreversion {#MyAppSystem}bit
Source: "{#RepositoryRoot}\FLIMfitStandalone\FLIMfit_{#MyAppVersion}_PCWIN{#MyAppSystem}\FLIMfit_PCWIN{#MyAppSystem}.exe"; DestDir: "{app}"; Flags: ignoreversion {#MyAppSystem}bit

[Icons]
Name: "{group}\{#MyAppName} {#MyAppVersion}"; Filename: "{app}\Start_FLIMfit_{#MyAppSystem}.exe"
Name: "{commondesktop}\{#MyAppName} {#MyAppVersion}"; Filename: "{app}\Start_FLIMfit_{#MyAppSystem}.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName} {#MyAppVersion}"; Filename: "{app}\Start_FLIMfit_{#MyAppSystem}.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\Start_FLIMfit_{#MyAppSystem}.exe"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


[Messages]
WinVersionTooHighError=This will install [name/ver] on your computer.%n%nIt is recommended that you close all other applications before continuing.%n%nIf they are not already installed, it will also download and install the Matlab 2012b Compiler Runtime, Visual C++ Redistributable for Visual Studio 2012 Update 1 and Ghostscript 8.71 which are required to run [name]. An internet connection will be required.

[Code]
procedure InitializeWizard();
begin
 itd_init;
 //Start the download after the "Ready to install" screen is shown
 itd_downloadafter(wpReady);
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode : Integer;
begin
 if CurStep=ssPostInstall then begin //Lets install those files that were downloaded for us
  // Unzip and install Matlab MCR if downloaded
  Exec(expandconstant('{tmp}\unzip.exe'), expandconstant('{tmp}\MatlabMCR.zip'), expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
  Exec(expandconstant('{tmp}\bin\win{#MyAppSystem}\setup.exe'), '-mode automated', expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
  
  // Install Visual Studio Redist
  Exec(expandconstant('{tmp}\vcredist_x{#MyAppSystem}.exe'), '/passive /norestart', expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
  
  // Install Ghostscript if downloaded
  Exec(expandconstant('{tmp}\unzip.exe'), expandconstant('{tmp}\Ghostscript.exe'), expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
  Exec(expandconstant('{tmp}\setupgs.exe'), expandconstant('"{pf}\gs\gs8.71"'), expandconstant('{tmp}'), SW_SHOW, ewWaitUntilTerminated, ResultCode)
 end;
end;


function InitializeSetup(): Boolean;
var
  // Declare variables
  MatlabMcrInstalled : Boolean;
  GhostscriptInstalled : Boolean;
  url : String;
  
begin

  // Check if mcr is installed
  MatlabMcrInstalled := RegKeyExists(HKLM,'SOFTWARE\MathWorks\MATLAB Compiler Runtime\{#McrVersionRequired}');
  GhostscriptInstalled := RegKeyExists(HKLM,'SOFTWARE\GPL Ghostscript\{#GhostscriptVersionRequired}');

  if MatlabMcrInstalled = true then
      Log('Required MCR version already installed')
  else
   begin
      Log('Required MCR version not installed')
      if {#MyAppSystem} = 64 then
        url := '{#McrUrl64}'
      else
        url := '{#McrUrl32}';
      Log('Adding MCR Download: ' + url);
      itd_addfile(url,expandconstant('{tmp}\MatlabMCR.zip'));  
    end;  

  if GhostscriptInstalled = true then
      Log('Required Ghostscript version already installed')
  else
   begin
      Log('Required Ghostscript version not installed')
      if {#MyAppSystem} = 64 then
        url := '{#GhostscriptUrl64}'
      else
        url := '{#GhostscriptUrl32}';
      Log('Adding Ghostscript Download: ' + url);
      itd_addfile(url,expandconstant('{tmp}\Ghostscript.exe'));  
    end;    
    
  Result := true;
end;


