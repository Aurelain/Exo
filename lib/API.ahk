;########################################################################
;############################   A P I   #################################
;########################################################################
; This section migrates AHK Commands, Functions and Variables that need special attention.
; Keywords not present here are migrated directly (dynamicaly) in "bridge()".
; The bulk of API functions consists of dumb Command->Function conversions.
; Whenever an API function deviates more than trivially from the AHK documentations,
; extensive comments are provided.


/**
 * Implementation: Normalization.
 */
_BlockInput(Mode){
	BlockInput %Mode%
}


/**
 * Implementation: Normalization.
 */
_Click(Item1="",Item2="",Item3="",Item4="",Item5="",Item6="",Item7=""){
	Click %Item1%,%Item2%,%Item3%,%Item4%,%Item5%,%Item6%,%Item7%
}


/**
 * Implementation: Identical.
 * "Clipboard" and "ErrorLevel" are the only built-in variables that allow write access.
 * Because "bridge()" only handles reading variables, these 2 had to be customized.
 */
_Clipboard(Value="__Undefined"){ ; an alternative would have been using variadic parameters, but that fails the MaxParams test
	if (Value == "__Undefined") {
		inject(Clipboard)
	} else {
		Clipboard := Value
	}
}


/**
 * Implementation: Normalization.
 */
_ClipWait(SecondsToWait="",AnyKindOfData=""){
	ClipWait %SecondsToWait%,%AnyKindOfData%
}


/**
 * Implementation: Normalization.
 */
_Control(Cmd,Value="",Control="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	Control %Cmd%,%Value%,%Control%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_ControlClick(ControlorPos="",WinTitle="",WinText="",WhichButton="",ClickCount="",Options="",ExcludeTitle="",ExcludeText=""){
	ControlClick %ControlorPos%,%WinTitle%,%WinText%,%WhichButton%,%ClickCount%,%Options%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_ControlFocus(Control="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	ControlFocus %Control%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Special.
 * "ControlGetPos" is special because it outputs 4 variables.
 * The migrated function returns instead an Object with 4 properties: X, Y, Width and Height.
 */
_ControlGetPos(Control="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	ControlGetPos X,Y,Width,Height,%Control%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
	return {X:X, Y:Y, Width:Width, Height:Height}
}


/**
 * Implementation: Normalization.
 */
_ControlGet(Cmd,Value="",Control="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	ControlGet OutputVar,%Cmd%,%Value%,%Control%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_ControlGetFocus(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	ControlGetFocus OutputVar,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_ControlGetText(Control="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	ControlGetText OutputVar,%Control%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_ControlMove(Control,X,Y,Width,Height,WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	ControlMove %Control%,%X%,%Y%,%Width%,%Height%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_ControlSend(Control="",Keys="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	ControlSend %Control%,%Keys%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_ControlSendRaw(Control="",Keys="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	ControlSendRaw %Control%,%Keys%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_ControlSetText(Control="",NewText="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	ControlSetText %Control%,%NewText%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_CoordMode(Target,Mode=""){
	global threadDefaults
	threadDefaults["CoordMode"] := [Target,Mode]
	CoordMode %Target%,%Mode%
}


/**
 * Implementation: Normalization.
 */
_Critical(Value=""){
	global threadDefaults
	threadDefaults["Critical"] := [Value]
	Critical %Value%
}


/**
 * Implementation: Normalization.
 */
_DetectHiddenText(OnOff){
	global threadDefaults
	threadDefaults["DetectHiddenText"] := [OnOff]
	DetectHiddenText %OnOff%
}


/**
 * Implementation: Normalization.
 */
_DetectHiddenWindows(OnOff){
	global threadDefaults
	threadDefaults["DetectHiddenWindows"] := [OnOff]
	DetectHiddenWindows %OnOff%
}


/**
 * Implementation: Normalization.
 */
_Drive(Subcommand,Drive="",Value=""){
	Drive %Subcommand%,%Drive%,%Value%
}


/**
 * Implementation: Normalization.
 */
_DriveGet(Cmd,Value=""){
	DriveGet OutputVar,%Cmd%,%Value%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_DriveSpaceFree(Path){
	DriveSpaceFree OutputVar,%Path%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_EnvGet(EnvVarName){
	EnvGet OutputVar,%EnvVarName%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_EnvSet(EnvVar,Value){
	EnvSet %EnvVar%,%Value%
}


/**
 * Implementation: Normalization.
 */
_EnvUpdate(){
	EnvUpdate 
}


/**
 * Implementation: Identical.
 * "Clipboard" and "ErrorLevel" are the only built-in variables that allow write access.
 * Because "bridge()" only handles reading variables, these 2 had to be customized.
 */
_ErrorLevel(Value="__Undefined"){ ; an alternative would have been using variadic parameters, but that fails the MaxParams test
	global errLevel
	if (Value == "__Undefined") {
		inject(errLevel, "Number")
	} else {
		errLevel := Value
	}
}


/**
 * Implementation: Normalization.
 */
_ExitApp(ExitCode=""){
	ExitApp %ExitCode%
}


/**
 * Implementation: Normalization.
 */
_FileAppend(Text="",Filename="",Encoding=""){
	FileAppend %Text%,%Filename%,%Encoding%
}


/**
 * Implementation: Normalization.
 */
_FileCopy(SourcePattern,DestPattern,Flag=""){
	FileCopy %SourcePattern%,%DestPattern%,%Flag%
}


/**
 * Implementation: Normalization.
 */
_FileCopyDir(Source,Dest,Flag=""){
	FileCopyDir %Source%,%Dest%,%Flag%
}


/**
 * Implementation: Normalization.
 */
_FileCreateDir(DirName){
	FileCreateDir %DirName%
}


/**
 * Implementation: Normalization.
 */
_FileCreateShortcut(Target,LinkFile,WorkingDir="",Args="",Description="",IconFile="",ShortcutKey="",IconNumber="",RunState=""){
	FileCreateShortcut %Target%,%LinkFile%,%WorkingDir%,%Args%,%Description%,%IconFile%,%ShortcutKey%,%IconNumber%,%RunState%
}


/**
 * Implementation: Normalization.
 */
_FileDelete(FilePattern){
	FileDelete %FilePattern%
}


/**
 * Implementation: Normalization.
 */
_FileEncoding(Encoding=""){
	FileEncoding %Encoding%
}


/**
 * Implementation: Normalization.
 */
_FileGetAttrib(Filename=""){
	FileGetAttrib OutputVar,%Filename%
	inject(OutputVar)
}


/**
 * Implementation: Special.
 * "FileGetShortcut" is special because it outputs 7 variables.
 * The migrated function returns instead an Object with 7 properties: Target, Dir, Args, Description, Icon, IconNum, RunState.
 */
_FileGetShortcut(LinkFile, Target="", Dir="", Args="", Description="", Icon="", IconNum="", RunState=""){
	FileGetShortcut, %LinkFile%, %Target%, %Dir%, %Args%, %Description%, %Icon%, %IconNum%, %RunState%
	return {Target:Target, Dir:Dir, Args:Args, Description:Description, Icon:Icon, IconNum:IconNum, RunState:RunState}
}


/**
 * Implementation: Normalization.
 */
_FileGetSize(Filename="",Units=""){
	FileGetSize OutputVar,%Filename%,%Units%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_FileGetTime(Filename="",WhichTime=""){
	FileGetTime OutputVar,%Filename%,%WhichTime%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_FileGetVersion(Filename=""){
	FileGetVersion OutputVar,%Filename%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_FileMove(SourcePattern,DestPattern,Flag=""){
	FileMove %SourcePattern%,%DestPattern%,%Flag%
}


/**
 * Implementation: Normalization.
 */
_FileMoveDir(Source,Dest,Flag=""){
	FileMoveDir %Source%,%Dest%,%Flag%
}


/**
 * Implementation: Normalization.
 */
_FileRead(Filename){
	FileRead OutputVar,%Filename%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_FileReadLine(Filename,LineNum){
	FileReadLine OutputVar,%Filename%,%LineNum%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_FileRecycle(FilePattern){
	FileRecycle %FilePattern%
}


/**
 * Implementation: Normalization.
 */
_FileRecycleEmpty(DriveLetter=""){
	FileRecycleEmpty %DriveLetter%
}


/**
 * Implementation: Normalization.
 */
_FileRemoveDir(DirName,Recurse=""){
	FileRemoveDir %DirName%,%Recurse%
}


/**
 * Implementation: Normalization.
 */
_FileSelectFile(Options="",RootDirOFilename="",Prompt="",Filter=""){
	FileSelectFile OutputVar,%Options%,%RootDirOFilename%,%Prompt%,%Filter%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_FileSelectFolder(StartingFolder="",Options="",Prompt=""){
	FileSelectFolder OutputVar,%StartingFolder%,%Options%,%Prompt%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_FileSetAttrib(Attributes,FilePattern="",OperateOnFolders="",Recurse=""){
	FileSetAttrib %Attributes%,%FilePattern%,%OperateOnFolders%,%Recurse%
}


/**
 * Implementation: Normalization.
 */
_FileSetTime(YYYYMMDDHH24MISS="",FilePattern="",WhichTime="",OperateOnFolders="",Recurse=""){
	FileSetTime %YYYYMMDDHH24MISS%,%FilePattern%,%WhichTime%,%OperateOnFolders%,%Recurse%
}


/**
 * Implementation: Normalization.
 */
_FormatTime(YYYYMMDDHH24MISS="",Format=""){
	FormatTime OutputVar,%YYYYMMDDHH24MISS%,%Format%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 * Since this keyword is shared by both a built-in Command and a built-in Function,
 * the migration occludes the Command and uses the Function.
 */
_GetKeyState(KeyName,Mode=""){
	result := GetKeyState(KeyName, Mode)
	inject(result)
}


/**
 * Implementation: Normalization.
 */
_GroupActivate(GroupName,R=""){
	GroupActivate %GroupName%,%R%
}


/**
 * Implementation: Normalization.
 */
_GroupAdd(GroupName,WinTitle="",WinText="",Label="",ExcludeTitle="",ExcludeText=""){
	GroupAdd %GroupName%,%WinTitle%,%WinText%,%Label%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_GroupClose(GroupName,Flag=""){
	GroupClose %GroupName%,%Flag%
}


/**
 * Implementation: Normalization.
 */
_GroupDeactivate(GroupName,R=""){
	GroupDeactivate %GroupName%,%R%
}


/**
 * Implementation: Normalization.
 */
_Gui(Subcommand,Param2="",Param3="",Param4=""){
	Gui %Subcommand%,%Param2%,%Param3%,%Param4%
}

/**
 * Implementation: Special.
 * "GuiClose" is special because it's a built-in label.
 * In JS, it becomes a function that registers a closure.
 */
_GuiClose(Closure=""){
	global closureGuiClose := Closure
}


/**
 * Implementation: Normalization.
 */
_GuiControl(Subcommand,ControlID,Param3=""){
	GuiControl %Subcommand%,%ControlID%,%Param3%
}


/**
 * Implementation: Normalization.
 */
_GuiControlGet(Subcommand="",ControlID="",Param4=""){
	GuiControlGet OutputVar,%Subcommand%,%ControlID%,%Param4%
	inject(OutputVar)
}


/**
 * Implementation: Special.
 * "Hotkey" is special because it uses labels.
 * The migrated function uses closures instead of labels.
 * TODO: Add support for AltTab.
 */
_Hotkey(KeyName, Closure="", Options=""){
	if (KeyName == "") {
		end("Invalid KeyName!")
	}
	global hotkeysMap ; our storage
	StringLower, Closure, Closure	; uniformity, to allow case insesitivity
	operation := ""
	if (Closure == "on" || RegExMatch(Options, "i)\bOn\b")) {
		operation := "on"
	} else if (Closure == "off" || RegExMatch(Options, "i)\bOff\b")) {
		operation := "off"
	} else if (Closure == "toggle") {
		operation := "toggle"
	}
	if (operation) {
		if (!hotkeysMap.HasKey(KeyName)) {
			end("Nonexistent hotkey!")
		} else {
			Hotkey %KeyName%, %operation%, %Options%
		}
	} else {
		if (Closure!="") {
			hotkeysMap[KeyName] := Closure
			Hotkey %KeyName%, LabelHotkey, %Options%
		} else {
			Hotkey %KeyName%,, %Options%
		}
	}
}


/**
 * Implementation: Special.
 * "ImageSearch" is special because it outputs 2 variables.
 * The migrated function returns instead an Object with 2 properties: X, Y.
 */
_ImageSearch(X1,Y1,X2,Y2,ImageFile){
	ImageSearch X,Y,%X1%,%Y1%,%X2%,%Y2%,%ImageFile%
	return {X:X, Y:Y}
}


/**
 * Implementation: Normalization.
 */
_IniDelete(Filename,Section,Key=""){
	IniDelete %Filename%,%Section%,%Key%
}


/**
 * Implementation: Normalization.
 */
_IniRead(Filename,Section="",Key="",Default=""){
	IniRead OutputVar,%Filename%,%Section%,%Key%,%Default%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_IniWrite(Value,Filename,Section,Key=""){
	IniWrite %Value%,%Filename%,%Section%,%Key%
}


/**
 * Implementation: Normalization.
 */
_Input(Options="",EndKeys="",MatchList=""){
	Input OutputVar,%Options%,%EndKeys%,%MatchList%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_InputBox(Title="",Prompt="",HIDE="",Width="",Height="",X="",Y="",FontBlank="",Timeout="",Default=""){
	InputBox OutputVar,%Title%,%Prompt%,%HIDE%,%Width%,%Height%,%X%,%Y%,,%Timeout%,%Default%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_KeyHistory(){
	KeyHistory 
}


/**
 * Implementation: Normalization.
 */
_KeyWait(KeyName,Options=""){
	KeyWait %KeyName%,%Options%
}


/**
 * Implementation: Normalization.
 */
_ListHotkeys(){
	ListHotkeys 
}


/**
 * Implementation: Special.
 * Because an AHK Loop intermingled with JS would be nonsensical, the migration solution was to
 * output the whole Loop results as an Array of Objects. Here's how the 5 types of Loop migrated:
 * 		1) [Normal-Loop](http://ahkscript.org/docs/commands/Loop.htm): N/A (not needed)
 * 		2) [File-Loop](http://ahkscript.org/docs/commands/LoopFile.htm):
 *			Syntax: Loop(FilePattern, [IncludeFolders, Recurse])
 *			Each Object has the same properties as the special variables available inside a File-Loop:
 *			Name,Ext,FullPath,LongPath,ShortPath,Dir,TimeModified,TimeCreated,TimeAccessed,Attrib,Size,SizeKB,SizeMB
 *		3) [Parse-Loop](http://ahkscript.org/docs/commands/LoopParse.htm): N/A (superseded by StrSplit)
 *		4) [Read-Loop](http://ahkscript.org/docs/commands/LoopReadFile.htm):
 *			Syntax: Loop("Read", InputFile)
 *			The output array contains each respective A_LoopReadLine as String.
 *			The OutputFile feature cannot be implemented.
 *		5) [Registry-Loop](http://ahkscript.org/docs/commands/LoopReg.htm):
 *			Syntax: Loop("HKLM|HKYU|...", [Key, IncludeSubkeys, Recurse])
 *			Each Object has the same properties as the special variables available inside a Registry-Loop:
 *			Name,Type,Key,SubKey,TimeModified
 */
_Loop(Param1,Param2="",Param3="",Param4=""){
	output := []
	if (RegExMatch(Param1, "i)^parse$")) {
		end("The Parse-Loop has been superseded by StrSplit().")
	} else if (RegExMatch(Param1, "i)^read$")) {
		Loop, %Param1%, %Param2%
		{
			output[A_Index] := A_LoopReadLine
		}
	} else {
		global regNames
		if (regNames.HasKey(Param1)) {
			Loop, %Param1%, %Param2%, %Param3%, %Param4%
			{
				obj := {}
				obj["Name"] := A_LoopRegName
				obj["Type"] := A_LoopRegType
				obj["Key"] := A_LoopRegKey
				obj["SubKey"] := A_LoopRegSubKey
				obj["TimeModified"] := A_LoopRegTimeModified
				output[A_Index] := obj
			}
		} else {
			Loop, %Param1%, %Param2%, %Param3%
			{
				obj := {}
				obj["Name"] := A_LoopFileName
				obj["Ext"] := A_LoopFileExt
				obj["FullPath"] := A_LoopFileFullPath
				obj["LongPath"] := A_LoopFileLongPath
				obj["ShortPath"] := A_LoopFileShortPath
				obj["Dir"] := A_LoopFileDir
				obj["TimeModified"] := A_LoopFileTimeModified
				obj["TimeCreated"] := A_LoopFileTimeCreated
				obj["TimeAccessed"] := A_LoopFileTimeAccessed
				obj["Attrib"] := A_LoopFileAttrib
				obj["Size"] := A_LoopFileSize
				obj["SizeKB"] := A_LoopFileSizeKB
				obj["SizeMB"] := A_LoopFileSizeMB
				output[A_Index] := obj
			}
		}
	}
	inject(output)
}


/**
 * Implementation: Special.
 * "LV_GetText" is special because it outputs 2 variables (a return value and a ByRef).
 * The migrated function has two modes:
 * 		1) the default mode (Advanced=0) is to return the retrieved text. Note that this behavior differs from the one in AHK.
 *		2) the advanced mode (Advanced non-empty) returns an object with 2 properties: Text, Success.
 */
_LV_GetText(RowNumber,ColumnNumber=1,Advanced=0){
	if (Advanced) {
		LV_GetText(OutputVar, RowNumber, ColumnNumber)
		inject(OutputVar)
	} else {
		success := LV_GetText(OutputVar, RowNumber, ColumnNumber)
		inject({Text:OutputVar, Success:success})
	}
}


/**
 * Implementation: Normalization.
 */
_Menu(MenuName,Cmd,P3="",P4="",P5=""){
	Menu %MenuName%,%Cmd%,%P3%,%P4%,%P5%
}


/**
 * Implementation: Normalization.
 */
_MouseClick(WhichButton="",X="",Y="",ClickCount="",Speed="",State="",R=""){
	MouseClick %WhichButton%,%X%,%Y%,%ClickCount%,%Speed%,%State%,%R%
}


/**
 * Implementation: Normalization.
 */
_MouseClickDrag(WhichButton,X1,Y1,X2,Y2,Speed="",R=""){
	MouseClickDrag %WhichButton%,%X1%,%Y1%,%X2%,%Y2%,%Speed%,%R%
}


/**
 * Implementation: Special.
 * "MouseGetPos" is special because it outputs 4 variables.
 * The migrated function returns instead an Object with 4 properties: X, Y, Win, Control.
 */
_MouseGetPos(Flag=""){
	MouseGetPos X, Y, Win, Control, %Flag%
	inject({X:X, Y:Y, Win:Win, Control:Control})
}


/**
 * Implementation: Normalization.
 */
_MouseMove(X,Y,Speed="",R=""){
	MouseMove %X%,%Y%,%Speed%,%R%
}


/**
 * Implementation: Normalization.
 * Besides command->function conversion, MsgBox needed extra attention because
 * the commas separating the parameters are interperted as string.
 * Also, the case for no-parameters had to be intercepted.
 */
_MsgBox(Param1="__Undefined", Title="__Undefined", Text="", Timeout=""){
	if (Param1 == "__Undefined") {
		MsgBox
	} else if (Title == "__Undefined") {
		MsgBox, %Param1%
	} else {
		MsgBox % Param1,%Title%,%Text%,%Timeout%
	}
}


/**
 * Implementation: Special.
 * "OnClipboardChange" is special because it's a built-in label.
 * In JS, it becomes a function that registers a closure.
 */
_OnClipboardChange(Closure=""){
	global closureOnClipboardChange := Closure
}


/**
 * Implementation: Special.
 * "OnExit" is special because it uses labels.
 * The migrated function uses instead closures.
 */
_OnExit(Closure=""){
	global closureOnExit := Closure
	OnExit, LabelOnExit
}


/**
 * Implementation: Special.
 * "OnMessage" is special because it function names.uses closures instead of function names.
 * In JS, there are several changes:
 *		- the function name became a closure
 * 		- the return values have been completely stripped out (it now returns undefined).
 * 		- the second parameter is now mandatory. To turn off monitoring, use the empty string.
 */
_OnMessage(MsgNumber, Closure, MaxThreads=1){
	global mapOnMessageClosures
	if (Closure == "") {
		mapOnMessageClosures.Remove(MsgNumber)
		OnMessage(MsgNumber, "", MaxThreads)
	} else {
		mapOnMessageClosures[MsgNumber] := Closure
		OnMessage(MsgNumber, "OnMessageClosure", MaxThreads)
	}
}


/**
 * Implementation: Normalization.
 */
_OutputDebug(Text){
	OutputDebug %Text%
}


/**
 * Implementation: Special.
 * Because the command-line parameters syntax (1, 2, 3, etc.) is nonsensical in JS, an alternative has been provided
 * through the "Parameters" global array.
 */
_Parameters(){
	inject(getArgs())
}


/**
 * Implementation: Normalization.
 */
_Pause(State="",OperateOnUnderlyingThread=""){
	Pause %State%,%OperateOnUnderlyingThread%
}


/**
 * Implementation: Normalization.
 */
_PixelGetColor(X,Y,Flags=""){
	PixelGetColor OutputVar,%X%,%Y%,%Flags%
	inject(OutputVar)
}


/**
 * Implementation: Special.
 * "PixelSearch" is special because it outputs 2 variables.
 * The migrated function returns instead an Object with 2 properties: X, Y.
 */
_PixelSearch(X1,Y1,X2,Y2,ColorID,Variation="",Flags=""){
	PixelSearch X,Y,%X1%,%Y1%,%X2%,%Y2%,%ColorID%,%Variation%,%Flags%
	inject({X:X, Y:Y})
}


/**
 * Implementation: Normalization.
 */
_PostMessage(Msg,wParam="",lParam="",Control="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	PostMessage %Msg%,%wParam%,%lParam%,%Control%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_Process(Cmd,PIDorName,Param3=""){
	Process %Cmd%,%PIDorName%,%Param3%
}


/**
 * Implementation: Normalization.
 */
_Progress(ProgressParam1,SubText="",MainText="",WinTitle="",FontName=""){
	Progress %ProgressParam1%,%SubText%,%MainText%,%WinTitle%,%FontName%
}


/**
 * "Random" is special because it accepts two modes:
 * 		1) Normal mode (with Min & Max as parameters). This is the default mode.
 *		2) Re-seeding mode (with NewSeed as parameter)
 * For the JS migration, the NewSeed mode can be activated by providing a third parameter (NewSeed),
 * in which case the first two parameters are disregarded.
 */
_Random(Min="",Max="",NewSeed=""){
	If (NewSeed) {
		Random,,%NewSeed%
	} else {
		Random OutputVar,%Min%,%Max%
		inject(OutputVar,"Number")
	}
}


/**
 * Implementation: Normalization.
 */
_RegDelete(RootKey,SubKey,ValueName=""){
	RegDelete %RootKey%,%SubKey%,%ValueName%
}


/**
 * Implementation: Special.
 * Because RegExMatch performs two roles, we cannot migrate it to JS 100% unchanged. The two roles are:
 *		1) returns found position
 *		2) fills a ByRef variable
 * Therefore, in order not lose the second functionality, we introduce an extra flag called "Advanced",
 * which clarifies what role the JS function should fulfill.
 * If "Advanced=0" (default), RegExMatch behaves as before, returning the found position.
 * Otherwise, it will return a Match object (http://ahkscript.org/docs/commands/RegExMatch.htm#MatchObject), no matter
 * what the matching mode is (default, P or O).
 */
_RegExMatch(Haystack, NeedleRegEx, StartingPosition=1, Advanced=0){
	if (Advanced) {
		RegExMatch(NeedleRegEx, "^\W+\)", flags)
		if (!flags) {
			NeedleRegEx := "O)" . NeedleRegEx
		} else {
			if (!InStr(flags, "O", true)) {
				NeedleRegEx := "O" . NeedleRegEx
			}
		}
		RegExMatch(Haystack, NeedleRegEx, Match, StartingPosition)
		output := {}
		output.Pos := []
		output.Len := []
		output.Value := []
		output.Name := []
		output.Count := Match.Count()
		output.Mark := Match.Mark()
		len := Match.Count() + 1
		Loop, %len%
		{
			index := A_Index
			output.Pos[index] := Match.Pos(index)
			output.Len[index] := Match.Len(index)
			output.Value[index] := Match.Value(index)
			output.Name[index] := Match.Name(index)
			output[index] := Match[index]
		}
		inject(output)
	} else {
		FoundPos := RegExMatch(Haystack, NeedleRegEx, "", StartingPosition)
		inject(FoundPos, "Number")
	}
}


/**
 * Implementation: Special.
 * "RegExReplace" is special because it performs 2 roles:
 *		1) returns the replaced string. This mode is default (Advanced=0)
 *		2) fills the Count ByRef variable. This mode is triggered by non-empty values of Advanced. In this case,
 *		an Object will be returned, with 2 properties: Text, Count.
 */
_RegExReplace(Haystack, NeedleRegEx, Replacement="", Limit=-1, StartingPosition=1, Advanced=0){
	Text := RegExReplace(Haystack, NeedleRegEx, Replacement, Count, Limit, StartingPosition)
	if (Advanced) {
		inject({Text:Text, Count:Count})
	} else {
		inject(Text)
	}
}


/**
 * Implementation: Normalization.
 */
_RegRead(RootKey,SubKey,ValueName=""){
	RegRead OutputVar,%RootKey%,%SubKey%,%ValueName%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_RegWrite(ValueType,RootKey,SubKey,ValueName="",Value=""){
	RegWrite %ValueType%,%RootKey%,%SubKey%,%ValueName%,%Value%
}


/**
 * Implementation: Normalization.
 */
_Reload(){
	Reload 
}


/**
 * Implementation: Normalization.
 */
_Run(Target, WorkingDir="", Flags=""){
	Run %Target%, %WorkingDir%, %Flags%, OutputVarPID
	inject(OutputVarPID)
}


/**
 * Implementation: Normalization.
 */
_RunAs(User="",Password="",Domain=""){
	RunAs %User%,%Password%,%Domain%
}


/**
 * Implementation: Special.
 * "RunWait" is special because it sets a process ID which can be read by another thread.
 * For JS, we cannot implement this feature and therefore don't return any PID (as opposed to "Run")
 */
_RunWait(Target,WorkingDir="",Flags=""){
	RunWait %Target%, %WorkingDir%, %Flags%
}


/**
 * Implementation: Normalization.
 */
_Send(Keys){
	Send %Keys%
}


/**
 * Implementation: Normalization.
 */
_SendEvent(Keys){
	SendEvent %Keys%
}


/**
 * Implementation: Normalization.
 */
_SendInput(Keys){
	SendInput %Keys%
}


/**
 * Implementation: Normalization.
 */
_SendLevel(Level){
	SendLevel %Level%
}


/**
 * Implementation: Normalization.
 */
_SendMessage(Msg,wParam="",lParam="",Control="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText="",Timeout=""){
	SendMessage %Msg%,%wParam%,%lParam%,%Control%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%,%Timeout%
}


/**
 * Implementation: Normalization.
 */
_SendMode(Mode){
	global threadDefaults
	threadDefaults["SendMode"] := [Mode]
	SendMode %Mode%
}


/**
 * Implementation: Normalization.
 */
_SendPlay(Keys){
	SendPlay %Keys%
}


/**
 * Implementation: Normalization.
 */
_SendRaw(Keys){
	SendRaw %Keys%
}


/**
 * Implementation: Normalization.
 */
_SetBatchLines(IntervalOrLineCount){
	global threadDefaults
	threadDefaults["SetBatchLines"] := [IntervalOrLineCount]
	SetBatchLines %IntervalOrLineCount%
}


/**
 * Implementation: Normalization.
 */
_SetCapslockState(State=""){
	SetCapslockState %State%
}


/**
 * Implementation: Normalization.
 */
_SetControlDelay(Delay){
	global threadDefaults
	threadDefaults["SetControlDelay"] := [Delay]
	SetControlDelay %Delay%
}


/**
 * Implementation: Normalization.
 */
_SetDefaultMouseSpeed(Speed){
	global threadDefaults
	threadDefaults["SetDefaultMouseSpeed"] := [Speed]
	SetDefaultMouseSpeed %Speed%
}


/**
 * Implementation: Normalization.
 */
_SetFormat(NumberType,Format){
	global threadDefaults
	threadDefaults["SetFormat"] := [NumberType,Format]
	SetFormat %NumberType%,%Format%
}


/**
 * Implementation: Normalization.
 */
_SetKeyDelay(Delay="",PressDuration="",Play=""){
	global threadDefaults
	threadDefaults["SetKeyDelay"] := [Delay,PressDuration,Play]
	SetKeyDelay %Delay%,%PressDuration%,%Play%
}


/**
 * Implementation: Normalization.
 */
_SetMouseDelay(Delay,Play=""){
	global threadDefaults
	threadDefaults["SetMouseDelay"] := [Delay,Play]
	SetMouseDelay %Delay%,%Play%
}


/**
 * Implementation: Normalization.
 */
_SetNumLockState(State=""){
	SetNumLockState %State%
}


/**
 * Implementation: Normalization.
 */
_SetRegView(RegView){
	SetRegView %RegView%
}


/**
 * Implementation: Normalization.
 */
_SetScrollLockState(State=""){
	SetScrollLockState %State%
}


/**
 * Implementation: Normalization.
 */
_SetStoreCapslockMode(OnOrOff){
	global threadDefaults
	threadDefaults["SetStoreCapslockMode"] := [OnOrOff]
	SetStoreCapslockMode %OnOrOff%
}


/**
 * Implementation: Normalization.
 */
_SetTimer(Closure="",Period="",Priority=""){
	SetTimer %Closure%,%Period%,%Priority%
}


/**
 * Implementation: Normalization.
 */
_SetTitleMatchMode(Flag){
	global threadDefaults
	threadDefaults["SetTitleMatchMode"] := [Flag]
	SetTitleMatchMode %Flag%
}


/**
 * Implementation: Normalization.
 */
_SetWinDelay(Delay){
	global threadDefaults
	threadDefaults["SetWinDelay"] := [Delay]
	SetWinDelay %Delay%
}


/**
 * Implementation: Normalization.
 */
_SetWorkingDir(DirName){
	SetWorkingDir %DirName%
}


/**
 * Implementation: Normalization.
 */
_Shutdown(Code){
	Shutdown %Code%
}


/**
 * Implementation: Normalization.
 */
_Sleep(DelayInMilliseconds){
	Sleep %DelayInMilliseconds%
}


/**
 * Implementation: Special.
 * "Sort" is special because it modifies a ByRef variable.
 * For JS, we made it a return value.
 * Also, we cannot implement the "F MyFunction" flag.
 */
_Sort(VarName,Options=""){
	Sort VarName, %Options%
	inject(VarName)
}


/**
 * Implementation: Normalization.
 */
_SoundBeep(Frequency="",Duration=""){
	SoundBeep %Frequency%,%Duration%
}


/**
 * Implementation: Special.
 * "SoundGet" is special because it has multiple return types (Number or String).
 */
_SoundGet(ComponentType="",ControlType="",DeviceNumber=""){
	SoundGet OutputVar, %ComponentType%, %ControlType%, %DeviceNumber%
	stringControlTypes := {ONOFF:1, MUTE:1, MONO:1, LOUDNESS:1, STEREOENH:1, BASSBOOST:1}
	if (stringControlTypes.HasKey(ControlType) || OutputVar == "") {
		inject(OutputVar)
	} else {
		inject(OutputVar, "Number")
	}
}


/**
 * Implementation: Normalization.
 */
_SoundGetWaveVolume(DeviceNumber=""){
	SoundGetWaveVolume OutputVar,%DeviceNumber%
	inject(OutputVar,"Number")
}


/**
 * Implementation: Normalization.
 */
_SoundPlay(Filename,Wait=""){
	SoundPlay %Filename%,%Wait%
}


/**
 * Implementation: Normalization.
 */
_SoundSet(NewSetting,ComponentType="",ControlType="",DeviceNumber=""){
	SoundSet %NewSetting%,%ComponentType%,%ControlType%,%DeviceNumber%
}


/**
 * Implementation: Normalization.
 */
_SoundSetWaveVolume(Percent,DeviceNumber=""){
	SoundSetWaveVolume %Percent%,%DeviceNumber%
}


/**
 * Implementation: Normalization.
 */
_SplashImage(Param1,Options="",SubText="",MainText="",WinTitle="",FontName=""){
	SplashImage %Param1%,%Options%,%SubText%,%MainText%,%WinTitle%,%FontName%
}


/**
 * Implementation: Normalization.
 */
_SplashTextOff(){
	SplashTextOff 
}


/**
 * Implementation: Normalization.
 */
_SplashTextOn(Width="",Height="",Title="",Text=""){
	SplashTextOn %Width%,%Height%,%Title%,%Text%
}


/**
 * Implementation: Special.
 * "SplitPath" is special because it outputs 5 variables.
 * The migrated function returns instead an Object with 5 properties: FileName, Dir, Extension, NameNoExt, Drive
 */
_SplitPath(InputVar){
	SplitPath InputVar, FileName, Dir, Extension, NameNoExt, Drive
	inject({FileName:FileName, Dir:Dir, Extension:Extension, NameNoExt:NameNoExt, Drive:Drive})
}


/**
 * Implementation: Normalization.
 */
_StatusBarGetText(Part="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	StatusBarGetText OutputVar,%Part%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StatusBarWait(BarText="",Seconds="",Part#="",WinTitle="",WinText="",Interval="",ExcludeTitle="",ExcludeText=""){
	StatusBarWait %BarText%,%Seconds%,%Part#%,%WinTitle%,%WinText%,%Interval%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_StringCaseSense(Flag){
	global threadDefaults
	threadDefaults["StringCaseSense"] := [Flag]
	StringCaseSense %Flag%
}


/**
 * Implementation: Normalization.
 */
_StringGetPos(InputVar,SearchText,LRFlag="",Offset=""){
	StringGetPos OutputVar,InputVar, %SearchText%,%LRFlag%,%Offset%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StringLeft(InputVar,Count){
	StringLeft OutputVar,InputVar,%Count%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StringLen(InputVar){
	StringLen OutputVar,InputVar
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StringLower(InputVar,T=""){
	StringLower OutputVar,InputVar,%T%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StringMid(InputVar,StartChar,Count="",L=""){
	StringMid OutputVar,InputVar,%StartChar%,%Count%,%L%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StringReplace(InputVar,SearchText,ReplaceText="",ReplaceAll=""){
	StringReplace OutputVar,InputVar,%SearchText%,%ReplaceText%,%ReplaceAll%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StringRight(InputVar,Count){
	StringRight OutputVar,InputVar,%Count%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StringTrimLeft(InputVar,Count){
	StringTrimLeft OutputVar,InputVar,%Count%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StringTrimRight(InputVar,Count){
	StringTrimRight OutputVar,InputVar,%Count%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_StringUpper(InputVar,T=""){
	StringUpper OutputVar,InputVar,%T%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_Suspend(Mode=""){
	Suspend %Mode%
}


/**
 * Implementation: Special.
 * "SysGet" is special because it has multiple return types (Number|String|Object).
 * If Subcommand="Monitor", the output will be an Object with 4 properties: Left, Top, Right, Bottom.
 * If Subcommand="MonitorName", the output will be String.
 * Otherwise, the output will be Number.
 */
_SysGet(Subcommand,Param2=""){
	SysGet v, %Subcommand%, %Param2%
	if (Subcommand == "Monitor") {
		inject({Left:vLeft, Top:vTop, Right:vRight, Bottom:vBottom})
	} else {
		inject(v)
	}
}


/**
 * Implementation: Normalization.
 */
_Thread(Subcommand,Param2="",Param3=""){
	global threadDefaults
	threadDefaults["Thread"] := [Subcommand,Param2,Param3]
	Thread %Subcommand%,%Param2%,%Param3%
}


/**
 * Implementation: Normalization.
 */
_ToolTip(Text="",X="",Y="",WhichToolTip=""){
	ToolTip %Text%,%X%,%Y%,%WhichToolTip%
}


/**
 * Implementation: Normalization.
 */
_Transform(Cmd,Value1,Value2=""){
	Transform OutputVar, %Cmd%, %Value1%, %Value2%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_TrayTip(Title="",Text="",Seconds="",Options=""){
	TrayTip %Title%,%Text%,%Seconds%,%Options%
}

/**
 * Implementation: Special.
 * "TV_GetText" is special because it outputs 2 variables (a return value and a ByRef)
 * The migrated function has two modes:
 * 		1) the default mode (Advanced=0) is to return the retrieved text. Note that this behavior differs from the one in AHK.
 *		2) the advanced mode (Advanced non-empty) returns an object with 2 properties: Text, Success.
 */
_TV_GetText(ItemID, Advanced=0){
	if (Advanced) {
		TV_GetText(OutputVar, ItemID)
		inject(OutputVar)
	} else {
		Success := LV_GetText(OutputVar, ItemID)
		inject({Text:OutputVar, Success:Success})
	}
}


/**
 * Implementation: Normalization.
 */
_UrlDownloadToFile(URL,Filename){
	UrlDownloadToFile %URL%,%Filename%
}


/**
 * Implementation: Normalization.
 */
_WinActivate(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinActivate %WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinActivateBottom(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinActivateBottom %WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinClose(WinTitle="",WinText="",SecondsToWait="",ExcludeTitle="",ExcludeText=""){
	WinClose %WinTitle%,%WinText%,%SecondsToWait%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinGet(Cmd="",WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinGet OutputVar,%Cmd%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
	inject(OutputVar)
}


/**
 * Implementation: Special.
 * "WinGetActiveStats" is special because it outputs 5 variables.
 * The migrated function returns instead an Object with 5 properties: X, Y, Width, Height, Title.
 */
_WinGetActiveStats(){
	WinGetActiveStats Title,Width,Height,X,Y
	inject({Title:Title, Width:Width, Height:Height, X:X, Y:Y})
}


/**
 * Implementation: Normalization.
 */
_WinGetActiveTitle(){
	WinGetActiveTitle OutputVar
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_WinGetClass(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinGetClass OutputVar,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
	inject(OutputVar)
}


/**
 * Implementation: Special.
 * "WinGetPos" is special because it outputs 4 variables.
 * The migrated function returns instead an Object with 4 properties: X, Y, Width, Height.
 */
_WinGetPos(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinGetPos X, Y, Width, Height, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	inject({Width:Width, Height:Height, X:X, Y:Y})
}


/**
 * Implementation: Normalization.
 */
_WinGetText(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinGetText OutputVar,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_WinGetTitle(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinGetTitle OutputVar,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
	inject(OutputVar)
}


/**
 * Implementation: Normalization.
 */
_WinHide(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinHide %WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinKill(WinTitle="",WinText="",SecondsToWait="",ExcludeTitle="",ExcludeText=""){
	WinKill %WinTitle%,%WinText%,%SecondsToWait%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinMaximize(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinMaximize %WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinMenuSelectItem(WinTitle,WinText,Menu,SubMenu1="",SubMenu2="",SubMenu3="",SubMenu4="",SubMenu5="",SubMenu6="",ExcludeTitle="",ExcludeText=""){
	WinMenuSelectItem %WinTitle%,%WinText%,%Menu%,%SubMenu1%,%SubMenu2%,%SubMenu3%,%SubMenu4%,%SubMenu5%,%SubMenu6%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinMinimize(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinMinimize %WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinMinimizeAll(){
	WinMinimizeAll 
}


/**
 * Implementation: Normalization.
 */
_WinMinimizeAllUndo(){
	WinMinimizeAllUndo 
}


/**
 * Implementation: Normalization.
 */
_WinMove(Param1,Param2,X="",Y="",Width="",Height="",ExcludeTitle="",ExcludeText=""){
	WinMove %Param1%,%Param2%,%X%,%Y%,%Width%,%Height%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinRestore(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinRestore %WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinSet(Attribute,Value,WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinSet %Attribute%,%Value%,%WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinSetTitle(Param1,WinText,NewTitle,ExcludeTitle="",ExcludeText=""){
	WinSetTitle %Param1%,%WinText%,%NewTitle%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinShow(WinTitle="",WinText="",ExcludeTitle="",ExcludeText=""){
	WinShow %WinTitle%,%WinText%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinWait(WinTitle="",WinText="",Seconds="",ExcludeTitle="",ExcludeText=""){
	WinWait %WinTitle%,%WinText%,%Seconds%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinWaitActive(WinTitle="",WinText="",Seconds="",ExcludeTitle="",ExcludeText=""){
	WinWaitActive %WinTitle%,%WinText%,%Seconds%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinWaitClose(WinTitle="",WinText="",Seconds="",ExcludeTitle="",ExcludeText=""){
	WinWaitClose %WinTitle%,%WinText%,%Seconds%,%ExcludeTitle%,%ExcludeText%
}


/**
 * Implementation: Normalization.
 */
_WinWaitNotActive(WinTitle="",WinText="",Seconds="",ExcludeTitle="",ExcludeText=""){
	WinWaitNotActive %WinTitle%,%WinText%,%Seconds%,%ExcludeTitle%,%ExcludeText%
}