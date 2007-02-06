; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Dtella@Purdue"
!define PRODUCT_VERSION "0.8.0"
!define PRODUCT_PUBLISHER "Dtella Labs"
!define PRODUCT_WEB_SITE "http://www.dtella.org/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\dtella.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\dtella.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "dtella-purdue-${PRODUCT_VERSION}.exe"
InstallDir "$PROGRAMFILES\Dtella@Purdue"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "dtella.exe"
  CreateDirectory "$SMPROGRAMS\Dtella@Purdue"
  CreateShortCut "$SMPROGRAMS\Dtella@Purdue\Dtella (Run in Background).lnk" "$INSTDIR\dtella.exe"
  CreateShortCut "$SMPROGRAMS\Dtella@Purdue\Kill Dtella.lnk" "$INSTDIR\dtella.exe" "--terminate"
  File "msvcr71.dll"
  File "readme.txt"
  File "dtella-purdue-${PRODUCT_VERSION}.tar.bz2"
SectionEnd

Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\Dtella@Purdue\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\dtella.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\dtella.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\readme.txt"
  Delete "$INSTDIR\msvcr71.dll"
  Delete "$INSTDIR\dtella.exe"
  Delete "$INSTDIR\dtella-purdue-*.tar.bz2"

  Delete "$SMPROGRAMS\Dtella@Purdue\Uninstall.lnk"
  Delete "$SMPROGRAMS\Dtella@Purdue\Dtella (Run in Background).lnk"
  Delete "$SMPROGRAMS\Dtella@Purdue\Kill Dtella.lnk"
  
  Delete "$PROFILE\.dtella\dtella.state"

  RMDir "$SMPROGRAMS\Dtella@Purdue"
  RMDir "$INSTDIR"
  RmDir "$PROFILE\.dtella"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  ;SetAutoClose true
SectionEnd