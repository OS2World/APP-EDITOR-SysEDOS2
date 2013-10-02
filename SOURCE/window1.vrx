/*:VRX         Main
*/
/*  Main
*/
Main:
/*  Process the arguments.
    Get the parent window.
*/
    parse source . calledAs .
    parent = ""
    argCount = arg()
    argOff = 0
    if( calledAs \= "COMMAND" )then do
        if argCount >= 1 then do
            parent = arg(1)
            argCount = argCount - 1
            argOff = 1
        end
    end; else do
        call VROptions 'ImplicitNames'
        call VROptions 'NoEchoQuit'
    end
    InitArgs.0 = argCount
    if( argCount > 0 )then do i = 1 to argCount
        InitArgs.i = arg( i + argOff )
    end
    drop calledAs argCount argOff

/*  Load the windows
*/
    call VRInit
    parse source . . spec
    _VREPrimaryWindowPath = ,
        VRParseFileName( spec, "dpn" ) || ".VRW"
    _VREPrimaryWindow = ,
        VRLoad( parent, _VREPrimaryWindowPath )
    drop parent spec
    if( _VREPrimaryWindow == "" )then do
        call VRMessage "", "Cannot load window:" VRError(), ,
            "Error!"
        _VREReturnValue = 32000
        signal _VRELeaveMain
    end

/*  Process events
*/
    call Init
    signal on halt
    do while( \ VRGet( _VREPrimaryWindow, "Shutdown" ) )
        _VREEvent = VREvent()
        interpret _VREEvent
    end
_VREHalt:
    _VREReturnValue = Fini()
    call VRDestroy _VREPrimaryWindow
_VRELeaveMain:
    call VRFini
exit _VREReturnValue

VRLoadSecondary:
    __vrlsWait = abbrev( 'WAIT', translate(arg(2)), 1 )
    if __vrlsWait then do
        call VRFlush
    end
    __vrlsHWnd = VRLoad( VRWindow(), VRWindowPath(), arg(1) )
    if __vrlsHWnd = '' then signal __vrlsDone
    if __vrlsWait \= 1 then signal __vrlsDone
    call VRSet __vrlsHWnd, 'WindowMode', 'Modal' 
    __vrlsTmp = __vrlsWindows.0
    if( DataType(__vrlsTmp) \= 'NUM' ) then do
        __vrlsTmp = 1
    end
    else do
        __vrlsTmp = __vrlsTmp + 1
    end
    __vrlsWindows.__vrlsTmp = VRWindow( __vrlsHWnd )
    __vrlsWindows.0 = __vrlsTmp
    do while( VRIsValidObject( VRWindow() ) = 1 )
        __vrlsEvent = VREvent()
        interpret __vrlsEvent
    end
    __vrlsTmp = __vrlsWindows.0
    __vrlsWindows.0 = __vrlsTmp - 1
    call VRWindow __vrlsWindows.__vrlsTmp 
    __vrlsHWnd = ''
__vrlsDone:
return __vrlsHWnd

/*:VRX         Fini
*/
Fini:
    window = VRWindow()
    call VRSet window, "Visible", 0
    drop window
return 0

/*:VRX         Halt
*/
Halt:
    signal _VREHalt
return

/*:VRX         Init
*/
Init:
    window = VRWindow()
    call VRMethod window, "CenterWindow"
    call VRSet window, "Visible", 1
    call VRMethod window, "Activate"
    drop window
return

/*:VRX         LB_1_DoubleClick
*/
LB_1_DoubleClick: 
    call PB_7_Click
return

/*:VRX         PB_10_Click
*/
PB_10_Click: 
  sOld = VRGet( "EF_13", "Value" )
  nPosLastBS = lastpos('\',sOld )
  sInitial = substr(sOld,1,nPosLastBS )||'*.exe'
  sFile = VRFileDialog( VRWindow(), "Choose editor", "Open", sInitial, "", ,  )
  bExists = VRFileExists( sFile )
  if bExists==1 then
    ok = VRSet( "EF_13", "Value", sFile )
return

/*:VRX         PB_11_Click
*/
PB_11_Click: 
  sOld = VRGet( "EF_7", "Value" )
  nPosLastBS = lastpos('\',sOld )
  sInitial = substr(sOld,1,nPosLastBS )||'*.*'
  sFile = VRFileDialog( VRWindow(), "Choose file", "Open", sInitial, "", ,  )
  bExists = VRFileExists( sFile )
  if bExists==1 then
    ok = VRSet( "EF_7", "Value", sFile )
return

/*:VRX         PB_12_Click
*/
PB_12_Click: 
  sOld = VRGet( "EF_8", "Value" )
  nPosLastBS = lastpos('\',sOld )
  sInitial = substr(sOld,1,nPosLastBS )||'*.*'
  sFile = VRFileDialog( VRWindow(), "Choose file", "Open", sInitial, "", ,  )
  bExists = VRFileExists( sFile )
  if bExists==1 then
    ok = VRSet( "EF_8", "Value", sFile )
return

/*:VRX         PB_13_Click
*/
PB_13_Click: 
  sOld = VRGet( "EF_9", "Value" )
  nPosLastBS = lastpos('\',sOld )
  sInitial = substr(sOld,1,nPosLastBS )||'*.*'
  sFile = VRFileDialog( VRWindow(), "Choose file", "Open", sInitial, "", ,  )
  bExists = VRFileExists( sFile )
  if bExists==1 then
    ok = VRSet( "EF_9", "Value", sFile )
return

/*:VRX         PB_14_Click
*/
PB_14_Click: 
  sOld = VRGet( "EF_10", "Value" )
  nPosLastBS = lastpos('\',sOld )
  sInitial = substr(sOld,1,nPosLastBS )||'*.*'
  sFile = VRFileDialog( VRWindow(), "Choose file", "Open", sInitial, "", ,  )
  bExists = VRFileExists( sFile )
  if bExists==1 then
    ok = VRSet( "EF_10", "Value", sFile )
return

/*:VRX         PB_15_Click
*/
PB_15_Click: 
  sOld = VRGet( "EF_11", "Value" )
  nPosLastBS = lastpos('\',sOld )
  sInitial = substr(sOld,1,nPosLastBS )||'*.'
  sFile = VRFileDialog( VRWindow(), "Choose file", "Open", sInitial, "", ,  )
  bExists = VRFileExists( sFile )
  if bExists==1 then
    ok = VRSet( "EF_11", "Value", sFile )
return

/*:VRX         PB_16_Click
*/
PB_16_Click: 
  sOld = VRGet( "EF_12", "Value" )
  nPosLastBS = lastpos('\',sOld )
  sInitial = substr(sOld,1,nPosLastBS )||'*.*'
  sFile = VRFileDialog( VRWindow(), "Choose file", "Open", sInitial, "", ,  )
  bExists = VRFileExists( sFile )
  if bExists==1 then
    ok = VRSet( "EF_12", "Value", sFile )
return

/*:VRX         PB_17_Click
*/
PB_17_Click: 
  sOld = VRGet( "EF_14", "Value" )
  nPosLastBS = lastpos('\',sOld )
  sInitial = substr(sOld,1,nPosLastBS )
  sFile = DirDialg( VRWindow(), "Choose path", sInitial )
  bExists = VRFileExists( sFile )
  if bExists==1 then
    ok = VRSet( "EF_14", "Value", sFile||"*.INI" )
return

/*:VRX         PB_18_Click
*/
PB_18_Click: 
    Editor= VRGet( "EF_13", "Value" ) 
    Eintrag1= VRGet( "EF_7", "Value" )
    Eintrag2= VRGet( "EF_8", "Value" )
    Eintrag3= VRGet( "EF_9", "Value" )
    Eintrag4= VRGet( "EF_10", "Value" )
    Eintrag5= VRGet( "EF_11", "Value" )
    Eintrag6= VRGet( "EF_12", "Value" )
    DateiListe= VRGet( "EF_14", "Value" )
    ok= VRSet( "EF_1", "Value", Eintrag1 )
    ok= VRSet( "EF_2", "Value", Eintrag2 )
    ok= VRSet( "EF_3", "Value", Eintrag3 )
    ok= VRSet( "EF_4", "Value", Eintrag4 )
    ok= VRSet( "EF_5", "Value", Eintrag5 )
    ok= VRSet( "EF_6", "Value", Eintrag6 )
    call List_Set
    ok= VRSetIni("SYSED", "Editor", Editor, AktDir"\SYSEDOS2.INI" )
    ok= VRSetIni("SYSED", "Eintrag1", Eintrag1, AktDir"\SYSEDOS2.INI" )
    ok= VRSetIni("SYSED", "Eintrag2", Eintrag2, AktDir"\SYSEDOS2.INI" )
    ok= VRSetIni("SYSED", "Eintrag3", Eintrag3, AktDir"\SYSEDOS2.INI" )
    ok= VRSetIni("SYSED", "Eintrag4", Eintrag4, AktDir"\SYSEDOS2.INI" )
    ok= VRSetIni("SYSED", "Eintrag5", Eintrag5, AktDir"\SYSEDOS2.INI" )
    ok= VRSetIni("SYSED", "Eintrag6", Eintrag6, AktDir"\SYSEDOS2.INI" )
    ok=VRSetIni("SYSED", "Liste", DateiListe, AktDir"\SYSEDOS2.INI" )
    call SETUP_Fini
return

/*:VRX         PB_19_Click
*/
PB_19_Click: 
  call SETUP_Fini
return

/*:VRX         PB_1_Click
*/
PB_1_Click: 
value = VRGet( "EF_1", "Value" )
'start 'Editor value
return
/*:VRX         PB_20_Click
*/
PB_20_Click: 
    ok= VRLoadSecondary( "SETUP" )
    ok= VRMethod( "SETUP", "Activate" ) 
return
/*:VRX         PB_2_Click
*/
PB_2_Click: 
value = VRGet( "EF_2", "Value" )
'start 'Editor value
return

/*:VRX         PB_3_Click
*/
PB_3_Click: 
value = VRGet( "EF_3", "Value" )
'start 'Editor value
return

/*:VRX         PB_4_Click
*/
PB_4_Click: 
value = VRGet( "EF_4", "Value" )
'start 'Editor value
return

/*:VRX         PB_5_Click
*/
PB_5_Click: 
value = VRGet( "EF_5", "Value" )
'start 'Editor value
return

/*:VRX         PB_6_Click
*/
PB_6_Click: 
value = VRGet( "EF_6", "Value" )
'start 'Editor value
return

/*:VRX         PB_7_Click
*/
PB_7_Click: 
ok = VRMethod( "LB_1", "GetSelectedList", selects. )
if selects.0 = 0 then do
   return
end
value = VRMethod( "LB_1", "GetString", selects.1 )
'start 'Editor value
return
/*:VRX         PB_8_Click
*/
PB_8_Click: 
'start /Win 'WinOS2"\Regedit.exe /V"
return
/*:VRX         PB_9_Click
*/
PB_9_Click: 
'start regedit2.exe'
return
/*:VRX         Quit
*/
Quit:
    window = VRWindow()
    call VRSet window, "Shutdown", 1
    drop window
return

/*:VRX         SETUP_Close
*/
SETUP_Close:
  buttons.0 = 2
  buttons.1 = "Yes"
  buttons.2 = "No"
  id = VRMessage( VRWindow(), "Quit without saving ?", "Question", "Query", "buttons.", 2, 2 )
  if id = 1 then call SETUP_Fini
return
/*:VRX         SETUP_Create
*/
SETUP_Create: 
    call SETUP_Init
    ok= VRSet( "EF_13", "Value", Editor )
    ok= VRSet( "EF_7", "Value", Eintrag1 )
    ok= VRSet( "EF_8", "Value", Eintrag2 )
    ok= VRSet( "EF_9", "Value", Eintrag3 )
    ok= VRSet( "EF_10", "Value", Eintrag4 )
    ok= VRSet( "EF_11", "Value", Eintrag5 )
    ok= VRSet( "EF_12", "Value", Eintrag6 )
    ok= VRSet( "EF_14", "Value", DateiListe )
return

/*:VRX         SETUP_Fini
*/
SETUP_Fini: 
    window = VRInfo( "Window" )
    call VRDestroy window
    drop window
return
/*:VRX         SETUP_Init
*/
SETUP_Init: 
    window = VRInfo( "Object" )
    if( \VRIsChildOf( window, "Notebook" ) ) then do
        call VRMethod window, "CenterWindow"
        call VRSet window, "Visible", 1
        call VRMethod window, "Activate"
    end
    drop window
return

/*:VRX         Window1_Close
*/
Window1_Close:
    call Quit
return

/*:VRX         Window1_Create
*/
Window1_Create:
    call rxfuncadd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
    call SysLoadFuncs
    AktDir=VRCurrDir( VRCurrDrive() )
    if Right(AktDir,1,1)=='\' then AktDir=Left(AktDir,Length(AktDir)-1);
    WinOS2Ini=VRGetIni( "PM_INSTALL", "WINOS2_LOCATION" )
    WinOS2=substr(WinOS2Ini,1,length(WinOS2Ini)-1)
    OS2=substr(WinOS2Ini,1,2)
    ok= SysFileTree( AktDir"\SYSEDOS2.INI", Gefunden, 'FO' )
    if Gefunden.0 = 0 then do
        ok=VRSetIni("SYSED", "Editor", OS2"\OS2\E.EXE", AktDir"\SYSEDOS2.INI" )
        ok=VRSetIni("SYSED", "Eintrag1", OS2"\CONFIG.SYS", AktDir"\SYSEDOS2.INI" )
        ok=VRSetIni("SYSED", "Eintrag2", OS2"\AUTOEXEC.BAT", AktDir"\SYSEDOS2.INI" )
        ok=VRSetIni("SYSED", "Eintrag3", WinOS2"\SYSTEM.INI", AktDir"\SYSEDOS2.INI" )
        ok=VRSetIni("SYSED", "Eintrag4", WinOS2"\WIN.INI", AktDir"\SYSEDOS2.INI" )
        ok=VRSetIni("SYSED", "Eintrag5", OS2"\IBMLAN\IBMLAN.INI", AktDir"\SYSEDOS2.INI" )
        ok=VRSetIni("SYSED", "Eintrag6", OS2"\IBMCOM\PROTOCOL.INI", AktDir"\SYSEDOS2.INI" )
        ok=VRSetIni("SYSED", "Liste", WinOS2"\*.INI", AktDir"\SYSEDOS2.INI" )
    end
    Editor= VRGetIni( "SYSED", "Editor", AktDir"\SYSEDOS2.INI" )
    Eintrag1= VRGetIni( "SYSED", "Eintrag1", AktDir"\SYSEDOS2.INI" )
    Eintrag2= VRGetIni( "SYSED", "Eintrag2", AktDir"\SYSEDOS2.INI" )
    Eintrag3= VRGetIni( "SYSED", "Eintrag3", AktDir"\SYSEDOS2.INI" )
    Eintrag4= VRGetIni( "SYSED", "Eintrag4", AktDir"\SYSEDOS2.INI" )
    Eintrag5= VRGetIni( "SYSED", "Eintrag5", AktDir"\SYSEDOS2.INI" )
    Eintrag6= VRGetIni( "SYSED", "Eintrag6", AktDir"\SYSEDOS2.INI" )
    DateiListe= VRGetIni( "SYSED", "Liste", AktDir"\SYSEDOS2.INI" )
    ok= VRSet( "EF_1", "Value", Eintrag1 )
    ok= VRSet( "EF_2", "Value", Eintrag2 )
    ok= VRSet( "EF_3", "Value", Eintrag3 )
    ok= VRSet( "EF_4", "Value", Eintrag4 )
    ok= VRSet( "EF_5", "Value", Eintrag5 )
    ok= VRSet( "EF_6", "Value", Eintrag6 )
    call List_Set
return

List_Set:
    ok=SysFileTree( DateiListe, Gefunden, 'FO' )
    ok = VRMethod( "LB_1", "Clear" )
    ok= VRMethod( "LB_1", "AddStringList", "Gefunden." )
return
