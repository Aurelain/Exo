# Exo: JavaScript unleashed!
Imagine the power of AHK (File/OS/Keyboard/Mouse/GUI Management) in the hands of JavaScript.
Imagine the ecosystem of JavaScript libraries (jQuery, CreateJS, etc.) in the hands of AHK.

*Exo* makes this happen!

## Description
*Exo* exposes most built-in commands/functions/variables of AHK to JavaScript, allowing you to practically write AHK inside JS (with JS syntax).

There are several advantages to using JS, rather than AhkScript:
  1. A lot of people are already familiar with JS, so there's no need to learn the peculiarities of the AhkScript-syntax.
  2. Gain access to a huge repository of libraries written in JS.
  3. You can use JS-specific constructs (eval, anonymous functions, prototype, etc.).
  4. You get to code in your favorite JS editor (IDE).
... and more.

It does all this by embedding a browser (Internet Explorer) and hooking into it with ComObject. It then bridges the JS global functions to their AHK counterpart.

## Goals
While migrating the keywords, the following goals were set:
- try to port 100% of the functionality (89% achieved)
- try as much as possible to conform with the AHK documentation
- provide useful typing (i.e. we shouldn't return String types everywhere only because it's easy)

## Usage
Launch *Exo* with a ".js" file argument (either through drag-and-drop, or from the command-line).
```
> Exo.ahk "demo.js"
```
Sample code:
```JavaScript
alert(A_Now);
FileAppend('Hello, World!', 'hello.txt')
var list = Loop('*.txt');
for (var i = 0; i < list.length; i++) {
	var fileProperties = list[i];
	MsgBox(fileProperties.LongPath);
}
Sleep(1000);
ExitApp();
```


## About
- Authors: **Aurelain** (aurelain@gmail.com), with major contributions from **Lexikos**
- License: [WTFPL](http://www.wtfpl.net/)
- Version: 0.96
- Minimum requirements:
  - **AutoHotkey v1.1.17.01**
  - Internet Explorer 8
  - Windows XP


## Migration Guide
This section lists all relevant AHK keywords (Commands, Function, Directives and Variables) and illustrates their counterpart in JS. In most cases, there is no significant change and everything is intuitive.

The breakdown for the following 470 keywords:
- 0) 13% were disregarded because they provided duplicate functionality
- 1) 37% were directly migrated (AHK Functions became JS Functions, AHK Variables became JS Variables)
- 2) 33% were migrated through subtle conversion (AHK Commands became JS Functions)
- 3) 6% were migrated through minor adjustment (AHK multiple-OutputVars became JS return Objects)
- 4) 7% could not be migrated, but there are alternatives or future prospects of being implemented.
- 5) 4% will never be migrated (mainly Directives and some very specific AHK Commands)

Keywords that were **not migrated (categories 0, 4 and 5)** are marked bold.

AHK Keyword | JS Implementation | JS Type
:----------|:---------------|:-------
[1, 2, 3, etc.](http://ahkscript.org/docs/Variables.htm#CommandLine)|Replacement: "A_Args"|Array
[A_AhkPath](http://ahkscript.org/docs/Variables.htm#AhkPath)|Identical|String
[A_AhkVersion](http://ahkscript.org/docs/Variables.htm#AhkVersion)|Identical|String
[A_AppData](http://ahkscript.org/docs/Variables.htm#AppData)|Identical|String
[A_AppDataCommon](http://ahkscript.org/docs/Variables.htm#AppDataCommon)|Identical|String
**[A_AutoTrim](http://ahkscript.org/docs/Variables.htm#AutoTrim )**|**Not needed (AHK specific)**|**N/A**
[A_BatchLines](http://ahkscript.org/docs/Variables.htm#BatchLines)|Identical|String
[A_CaretX](http://ahkscript.org/docs/Variables.htm#Caret)|Identical|String
[A_CaretY](http://ahkscript.org/docs/Variables.htm#Caret)|Identical|String
[A_ComputerName](http://ahkscript.org/docs/Variables.htm#ComputerName)|Identical|String
[A_ControlDelay](http://ahkscript.org/docs/Variables.htm#ControlDelay)|Identical|Number
[A_Cursor](http://ahkscript.org/docs/Variables.htm#Cursor)|Identical|String
[A_DD](http://ahkscript.org/docs/Variables.htm#DD)|Identical|String
[A_DDD](http://ahkscript.org/docs/Variables.htm#DDD)|Identical|String
[A_DDDD](http://ahkscript.org/docs/Variables.htm#DDDD)|Identical|String
[A_DefaultMouseSpeed](http://ahkscript.org/docs/Variables.htm#DefaultMouseSpeed)|Identical|Number
[A_Desktop](http://ahkscript.org/docs/Variables.htm#Desktop)|Identical|String
[A_DesktopCommon](http://ahkscript.org/docs/Variables.htm#DesktopCommon)|Identical|String
[A_DetectHiddenText](http://ahkscript.org/docs/Variables.htm#DetectHiddenText)|Identical|String
[A_DetectHiddenWindows](http://ahkscript.org/docs/Variables.htm#DetectHiddenWindows)|Identical|String
**[A_EndChar](http://ahkscript.org/docs/Variables.htm#EndChar )**|**Cannot use yet**|**N/A**
[A_EventInfo](http://ahkscript.org/docs/Variables.htm#EventInfo)|Identical|String
[A_ExitReason](http://ahkscript.org/docs/Variables.htm#ExitReason)|Identical|String
[A_FileEncoding](http://ahkscript.org/docs/Variables.htm#FileEncoding)|Identical|String
[A_FormatFloat](http://ahkscript.org/docs/Variables.htm#FormatFloat)|Identical|String
[A_FormatInteger](http://ahkscript.org/docs/Variables.htm#FormatInteger)|Identical|String
[A_Gui](http://ahkscript.org/docs/Variables.htm#Gui )|Identical|String
[A_GuiControl](http://ahkscript.org/docs/Variables.htm#GuiControl )|Identical|String
[A_GuiControlEvent](http://ahkscript.org/docs/Variables.htm#GuiControlEvent )|Identical|String
[A_GuiEvent](http://ahkscript.org/docs/Variables.htm#GuiEvent)|Identical|String
[A_GuiHeight](http://ahkscript.org/docs/Variables.htm#GuiWidth)|Identical|Number
[A_GuiWidth](http://ahkscript.org/docs/Variables.htm#GuiWidth)|Identical|Number
[A_GuiX](http://ahkscript.org/docs/Variables.htm#GuiX)|Identical|Number
[A_GuiY](http://ahkscript.org/docs/Variables.htm#GuiY )|Identical|Number
[A_Hour](http://ahkscript.org/docs/Variables.htm#Hour)|Identical|String
[A_IconFile](http://ahkscript.org/docs/Variables.htm#IconFile)|Identical|String
[A_IconHidden](http://ahkscript.org/docs/Variables.htm#IconHidden)|Identical|Number
[A_IconNumber](http://ahkscript.org/docs/Variables.htm#IconNumber)|Identical|String
[A_IconTip](http://ahkscript.org/docs/Variables.htm#IconTip)|Identical|String
**[A_Index](http://ahkscript.org/docs/Variables.htm#Index)**|**Not needed (AHK specific)**|**N/A**
[A_IPAddress1](http://ahkscript.org/docs/Variables.htm#IPAddress)|Identical|String
[A_IPAddress2](http://ahkscript.org/docs/Variables.htm#IPAddress2)|Identical|String
[A_IPAddress3](http://ahkscript.org/docs/Variables.htm#IPAddress)|Identical|String
[A_IPAddress4](http://ahkscript.org/docs/Variables.htm#IPAddress)|Identical|String
[A_Is64bitOS](http://ahkscript.org/docs/Variables.htm#Is64bitOS)|Identical|Number
[A_IsAdmin](http://ahkscript.org/docs/Variables.htm#IsAdmin)|Identical|Number
[A_IsCompiled](http://ahkscript.org/docs/Variables.htm#IsCompiled)|Identical|String
[A_IsCritical](http://ahkscript.org/docs/Variables.htm#IsCritical)|Identical|Number
[A_IsPaused](http://ahkscript.org/docs/Variables.htm#IsPaused)|Identical|Number
[A_IsSuspended](http://ahkscript.org/docs/Variables.htm#IsSuspended)|Identical|Number
[A_IsUnicode](http://ahkscript.org/docs/Variables.htm#IsUnicode)|Identical|String
[A_KeyDelay](http://ahkscript.org/docs/Variables.htm#KeyDelay)|Identical|Number
[A_Language](http://ahkscript.org/docs/Variables.htm#Language)|Identical|String
[A_LastError](http://ahkscript.org/docs/Variables.htm#LastError)|Identical|String
**[A_LineFile](http://ahkscript.org/docs/Variables.htm#LineFile )**|**Cannot use yet**|**N/A**
**[A_LineNumber](http://ahkscript.org/docs/Variables.htm#LineNumber )**|**Cannot use yet**|**N/A**
**[A_LoopField](http://ahkscript.org/docs/commands/LoopParse.htm#LoopField)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileAttrib](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileDir](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileExt](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileFullPath](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileLongPath](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileName](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileShortName](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileShortPath](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileSize](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileSizeKB](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileSizeMB](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileTimeAccessed](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileTimeCreated](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopFileTimeModified](http://ahkscript.org/docs/commands/LoopFile.htm#Special_Variables_Available_Inside_a_File-Loop)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopReadLine](http://ahkscript.org/docs/commands/LoopReadFile.htm#LoopReadLine)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopRegKey](http://ahkscript.org/docs/commands/LoopReg.htm#Remarks)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopRegName](http://ahkscript.org/docs/commands/LoopReg.htm#Remarks)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopRegSubKey](http://ahkscript.org/docs/commands/LoopReg.htm#Remarks)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopRegTimeModified](http://ahkscript.org/docs/commands/LoopReg.htm#Remarks)**|**Not needed as such (Returned by "Loop()").**|**N/A**
**[A_LoopRegType](http://ahkscript.org/docs/commands/LoopReg.htm#Remarks)**|**Not needed as such (Returned by "Loop()").**|**N/A**
[A_MDay](http://ahkscript.org/docs/Variables.htm#DD)|Identical|String
[A_Min](http://ahkscript.org/docs/Variables.htm#Min)|Identical|String
[A_MM](http://ahkscript.org/docs/Variables.htm#MM)|Identical|String
[A_MMM](http://ahkscript.org/docs/Variables.htm#MMM)|Identical|String
[A_MMMM](http://ahkscript.org/docs/Variables.htm#MMMM)|Identical|String
[A_Mon](http://ahkscript.org/docs/Variables.htm#MM)|Identical|String
[A_MouseDelay](http://ahkscript.org/docs/Variables.htm#MouseDelay)|Identical|Number
[A_MSec](http://ahkscript.org/docs/Variables.htm#MSec)|Identical|String
[A_MyDocuments](http://ahkscript.org/docs/Variables.htm#MyDocuments)|Identical|String
[A_Now](http://ahkscript.org/docs/Variables.htm#Now)|Identical|String
[A_NowUTC](http://ahkscript.org/docs/Variables.htm#NowUTC)|Identical|String
[A_NumBatchLines](http://ahkscript.org/docs/Variables.htm#BatchLines)|Identical|String
[A_OSType](http://ahkscript.org/docs/Variables.htm#OSType)|Identical|String
[A_OSVersion](http://ahkscript.org/docs/Variables.htm#OSVersion)|Identical|String
[A_PriorHotkey](http://ahkscript.org/docs/Variables.htm#PriorHotkey)|Identical|String
[A_PriorKey](http://ahkscript.org/docs/Variables.htm#PriorKey)|Identical|String
[A_ProgramFiles](http://ahkscript.org/docs/Variables.htm#ProgramFiles)|Identical|String
[A_Programs](http://ahkscript.org/docs/Variables.htm#Programs)|Identical|String
[A_ProgramsCommon](http://ahkscript.org/docs/Variables.htm#ProgramsCommon)|Identical|String
[A_PtrSize](http://ahkscript.org/docs/Variables.htm#PtrSize)|Identical|Number
[A_RegView](http://ahkscript.org/docs/Variables.htm#RegView)|Identical|String
[A_ScreenDPI](http://ahkscript.org/docs/Variables.htm#ScreenDPI)|Identical|Number
[A_ScreenHeight](http://ahkscript.org/docs/Variables.htm#Screen)|Identical|Number
[A_ScreenWidth](http://ahkscript.org/docs/Variables.htm#Screen)|Identical|Number
[A_ScriptDir](http://ahkscript.org/docs/Variables.htm#ScriptDir)|Identical|String
[A_ScriptFullPath](http://ahkscript.org/docs/Variables.htm#ScriptFullPath)|Identical|String
[A_ScriptHwnd](http://ahkscript.org/docs/Variables.htm#ScriptHwnd)|Identical|String
[A_ScriptName](http://ahkscript.org/docs/Variables.htm#ScriptName)|Identical|String
[A_Sec](http://ahkscript.org/docs/Variables.htm#Sec)|Identical|String
[A_Space](http://ahkscript.org/docs/Variables.htm#Space)|Identical|String
[A_StartMenu](http://ahkscript.org/docs/Variables.htm#StartMenu)|Identical|String
[A_StartMenuCommon](http://ahkscript.org/docs/Variables.htm#StartMenuCommon)|Identical|String
[A_Startup](http://ahkscript.org/docs/Variables.htm#Startup)|Identical|String
[A_StartupCommon](http://ahkscript.org/docs/Variables.htm#StartupCommon)|Identical|String
[A_StringCaseSense](http://ahkscript.org/docs/Variables.htm#StringCaseSense)|Identical|String
[A_Tab](http://ahkscript.org/docs/Variables.htm#Tab)|Identical|String
[A_Temp](http://ahkscript.org/docs/Variables.htm#Temp)|Identical|String
**[A_ThisFunc](http://ahkscript.org/docs/Variables.htm#ThisFunc)**|**Not needed (AHK specific)**|**N/A**
[A_ThisHotkey](http://ahkscript.org/docs/Variables.htm#ThisHotkey)|Identical|String
**[A_ThisLabel](http://ahkscript.org/docs/Variables.htm#ThisLabel)**|**Not needed (AHK specific)**|**N/A**
[A_ThisMenu](http://ahkscript.org/docs/Variables.htm#ThisMenu)|Identical|String
[A_ThisMenuItem](http://ahkscript.org/docs/Variables.htm#ThisMenuItem)|Identical|String
[A_ThisMenuItemPos](http://ahkscript.org/docs/Variables.htm#ThisMenuItemPos)|Identical|String
[A_TickCount](http://ahkscript.org/docs/Variables.htm#TickCount)|Identical|Number
[A_TimeIdle](http://ahkscript.org/docs/Variables.htm#TimeIdle)|Identical|Number
[A_TimeIdlePhysical](http://ahkscript.org/docs/Variables.htm#TimeIdlePhysical)|Identical|Number
[A_TimeSincePriorHotkey](http://ahkscript.org/docs/Variables.htm#TimeSincePriorHotkey)|Identical|Number
[A_TimeSinceThisHotkey](http://ahkscript.org/docs/Variables.htm#TimeSinceThisHotkey)|Identical|Number
[A_TitleMatchMode](http://ahkscript.org/docs/Variables.htm#TitleMatchMode)|Identical|String
[A_TitleMatchModeSpeed](http://ahkscript.org/docs/Variables.htm#TitleMatchModeSpeed)|Identical|String
[A_UserName](http://ahkscript.org/docs/Variables.htm#UserName)|Identical|String
[A_WDay](http://ahkscript.org/docs/Variables.htm#WDay)|Identical|String
[A_WinDelay](http://ahkscript.org/docs/Variables.htm#WinDelay)|Identical|Number
[A_WinDir](http://ahkscript.org/docs/Variables.htm#WinDir)|Identical|String
[A_WorkingDir](http://ahkscript.org/docs/Variables.htm#WorkingDir)|Identical|String
[A_YDay](http://ahkscript.org/docs/Variables.htm#YDay)|Identical|String
[A_Year](http://ahkscript.org/docs/Variables.htm#YYYY)|Identical|String
[A_YWeek](http://ahkscript.org/docs/Variables.htm#YWeek)|Identical|String
[A_YYYY](http://ahkscript.org/docs/Variables.htm#YYYY)|Identical|String
[Abs()](http://ahkscript.org/docs/Functions.htm#Abs)|Identical|Number
[ACos()](http://ahkscript.org/docs/Functions.htm#ACos)|Identical|Number
**[Array()](http://ahkscript.org/docs/Objects.htm#Usage)**|**Not needed (AHK specific)**|**N/A**
[Asc()](http://ahkscript.org/docs/Functions.htm#Asc)|Identical|Number
[ASin()](http://ahkscript.org/docs/Functions.htm#ASin)|Identical|Number
[ATan()](http://ahkscript.org/docs/Functions.htm#ATan)|Identical|Number
**[AutoTrim](http://ahkscript.org/docs/commands/AutoTrim.htm)**|**Not needed (AHK specific)**|**N/A**
[BlockInput](http://ahkscript.org/docs/commands/BlockInput.htm)|Normalization|Empty
[Ceil()](http://ahkscript.org/docs/Functions.htm#Ceil)|Identical|Number
[Chr()](http://ahkscript.org/docs/Functions.htm#Chr)|Identical|String
[Click](http://ahkscript.org/docs/commands/Click.htm)|Normalization|Empty
[Clipboard](http://ahkscript.org/docs/misc/Clipboard.htm)|Identical|String
[ClipboardAll](http://ahkscript.org/docs/misc/Clipboard.htm#ClipboardAll)|Identical|String
[ClipWait](http://ahkscript.org/docs/commands/ClipWait.htm)|Normalization|Empty
**[ComObjActive()](http://ahkscript.org/docs/commands/ComObjActive.htm)**|**Cannot use yet**|**N/A**
**[ComObjArray()](http://ahkscript.org/docs/commands/ComObjArray.htm)**|**Cannot use yet**|**N/A**
**[ComObjConnect()](http://ahkscript.org/docs/commands/ComObjConnect.htm)**|**Cannot use yet**|**N/A**
**[ComObjCreate()](http://ahkscript.org/docs/commands/ComObjCreate.htm)**|**Cannot use yet**|**N/A**
**[ComObject()](http://ahkscript.org/docs/commands/ComObjActive.htm)**|**Cannot use yet**|**N/A**
**[ComObjEnwrap()](http://ahkscript.org/docs/commands/ComObjActive.htm)**|**Not needed (Deprecated)**|**N/A**
**[ComObjError()](http://ahkscript.org/docs/commands/ComObjError.htm)**|**Cannot use yet**|**N/A**
**[ComObjFlags()](http://ahkscript.org/docs/commands/ComObjFlags.htm)**|**Cannot use yet**|**N/A**
**[ComObjGet()](http://ahkscript.org/docs/commands/ComObjGet.htm)**|**Cannot use yet**|**N/A**
**[ComObjMissing()](http://ahkscript.org/docs/commands/ComObjActive.htm)**|**Not needed (Deprecated)**|**N/A**
**[ComObjParameter()](http://ahkscript.org/docs/commands/ComObjActive.htm)**|**Cannot use yet**|**N/A**
**[ComObjQuery()](http://ahkscript.org/docs/commands/ComObjQuery.htm)**|**Cannot use yet**|**N/A**
**[ComObjType()](http://ahkscript.org/docs/commands/ComObjType.htm)**|**Cannot use yet**|**N/A**
**[ComObjUnwrap()](http://ahkscript.org/docs/commands/ComObjActive.htm)**|**Not needed (Deprecated)**|**N/A**
**[ComObjValue()](http://ahkscript.org/docs/commands/ComObjValue.htm)**|**Cannot use yet**|**N/A**
[ComSpec](http://ahkscript.org/docs/Variables.htm#ComSpec)|Identical|String
[Control](http://ahkscript.org/docs/commands/Control.htm)|Normalization|Empty
[ControlClick](http://ahkscript.org/docs/commands/ControlClick.htm)|Normalization|Empty
[ControlFocus](http://ahkscript.org/docs/commands/ControlFocus.htm)|Normalization|Empty
[ControlGet](http://ahkscript.org/docs/commands/ControlGet.htm)|Normalization|String
[ControlGetFocus](http://ahkscript.org/docs/commands/ControlGetFocus.htm)|Normalization|String
[ControlGetPos](http://ahkscript.org/docs/commands/ControlGetPos.htm)|Minor change (returns Object)|{}
[ControlGetText](http://ahkscript.org/docs/commands/ControlGetText.htm)|Normalization|String
[ControlMove](http://ahkscript.org/docs/commands/ControlMove.htm)|Normalization|Empty
[ControlSend](http://ahkscript.org/docs/commands/ControlSend.htm)|Normalization|Empty
[ControlSendRaw](http://ahkscript.org/docs/commands/ControlSend.htm)|Normalization|Empty
[ControlSetText](http://ahkscript.org/docs/commands/ControlSetText.htm)|Normalization|Empty
[CoordMode](http://ahkscript.org/docs/commands/CoordMode.htm)|Normalization|Empty
[Cos()](http://ahkscript.org/docs/Functions.htm#Cos)|Identical|Number
[Critical](http://ahkscript.org/docs/commands/Critical.htm)|Normalization|Empty
[DetectHiddenText](http://ahkscript.org/docs/commands/DetectHiddenText.htm)|Normalization|Empty
[DetectHiddenWindows](http://ahkscript.org/docs/commands/DetectHiddenWindows.htm)|Normalization|Empty
[DllCall()](http://ahkscript.org/docs/commands/DllCall.htm)|Identical|String
[Drive](http://ahkscript.org/docs/commands/Drive.htm)|Normalization|Empty
[DriveGet](http://ahkscript.org/docs/commands/DriveGet.htm)|Normalization|String
[DriveSpaceFree](http://ahkscript.org/docs/commands/DriveSpaceFree.htm)|Normalization|Number
**[Edit](http://ahkscript.org/docs/commands/Edit.htm)**|**Cannot use yet**|**N/A**
**[EnvAdd](http://ahkscript.org/docs/commands/EnvAdd.htm)**|**Not needed (Feature duplication)**|**N/A**
**[EnvDiv](http://ahkscript.org/docs/commands/EnvDiv.htm)**|**Not needed (Feature duplication)**|**N/A**
[EnvGet](http://ahkscript.org/docs/commands/EnvGet.htm)|Normalization|String
**[EnvMult](http://ahkscript.org/docs/commands/EnvMult.htm)**|**Not needed (Feature duplication)**|**N/A**
[EnvSet](http://ahkscript.org/docs/commands/EnvSet.htm)|Normalization|Empty
**[EnvSub](http://ahkscript.org/docs/commands/EnvSub.htm)**|**Not needed (Feature duplication)**|**N/A**
[EnvUpdate](http://ahkscript.org/docs/commands/EnvUpdate.htm)|Normalization|Empty
[ErrorLevel](http://ahkscript.org/docs/misc/ErrorLevel.htm)|Identical|N/A
**[Exception](http://ahkscript.org/docs/commands/Throw.htm#Exception)**|**Not needed (AHK specific)**|**N/A**
**[Exit](http://ahkscript.org/docs/commands/Exit.htm)**|**Not needed (AHK specific)**|**N/A**
[ExitApp](http://ahkscript.org/docs/commands/ExitApp.htm)|Normalization|Empty
[Exp()](http://ahkscript.org/docs/Functions.htm#Exp)|Identical|Number
[FileAppend](http://ahkscript.org/docs/commands/FileAppend.htm)|Normalization|Empty
[FileCopy](http://ahkscript.org/docs/commands/FileCopy.htm)|Normalization|Empty
[FileCopyDir](http://ahkscript.org/docs/commands/FileCopyDir.htm)|Normalization|Empty
[FileCreateDir](http://ahkscript.org/docs/commands/FileCreateDir.htm)|Normalization|Empty
[FileCreateShortcut](http://ahkscript.org/docs/commands/FileCreateShortcut.htm)|Normalization|Empty
[FileDelete](http://ahkscript.org/docs/commands/FileDelete.htm)|Normalization|Empty
[FileEncoding](http://ahkscript.org/docs/commands/FileEncoding.htm)|Normalization|Empty
[FileExist()](http://ahkscript.org/docs/Functions.htm#FileExist)|Identical|String
[FileGetAttrib](http://ahkscript.org/docs/commands/FileGetAttrib.htm)|Normalization|String
[FileGetShortcut](http://ahkscript.org/docs/commands/FileGetShortcut.htm)|Minor change (returns Object)|{}
[FileGetSize](http://ahkscript.org/docs/commands/FileGetSize.htm)|Normalization|Number
[FileGetTime](http://ahkscript.org/docs/commands/FileGetTime.htm)|Normalization|String
[FileGetVersion](http://ahkscript.org/docs/commands/FileGetVersion.htm)|Normalization|String
**[FileInstall](http://ahkscript.org/docs/commands/FileInstall.htm)**|**Cannot use compile-time features.**|**N/A**
[FileMove](http://ahkscript.org/docs/commands/FileMove.htm)|Normalization|Empty
[FileMoveDir](http://ahkscript.org/docs/commands/FileMoveDir.htm)|Normalization|Empty
[FileOpen()](http://ahkscript.org/docs/commands/FileOpen.htm)|Minor change (RawRead() multiple output)|File
[FileRead](http://ahkscript.org/docs/commands/FileRead.htm)|Normalization|String
[FileReadLine](http://ahkscript.org/docs/commands/FileReadLine.htm)|Normalization|String
[FileRecycle](http://ahkscript.org/docs/commands/FileRecycle.htm)|Normalization|Empty
[FileRecycleEmpty](http://ahkscript.org/docs/commands/FileRecycleEmpty.htm)|Normalization|Empty
[FileRemoveDir](http://ahkscript.org/docs/commands/FileRemoveDir.htm)|Normalization|Empty
[FileSelectFile](http://ahkscript.org/docs/commands/FileSelectFile.htm)|Normalization|String
[FileSelectFolder](http://ahkscript.org/docs/commands/FileSelectFolder.htm)|Normalization|String
[FileSetAttrib](http://ahkscript.org/docs/commands/FileSetAttrib.htm)|Normalization|Empty
[FileSetTime](http://ahkscript.org/docs/commands/FileSetTime.htm)|Normalization|Empty
[Floor()](http://ahkscript.org/docs/Functions.htm#Floor)|Identical|Number
[FormatTime](http://ahkscript.org/docs/commands/FormatTime.htm)|Normalization|String
**[Func()](http://ahkscript.org/docs/Functions.htm#Func)**|**Not needed (AHK specific)**|**N/A**
[GetKeyName()](http://ahkscript.org/docs/Functions.htm#GetKeyName)|Identical|String
[GetKeySC()](http://ahkscript.org/docs/Functions.htm#GetKeyName)|Identical|Number
**[GetKeyState](http://ahkscript.org/docs/commands/GetKeyState.htm)**|**Not needed (occluded by homonym)**|**String**
[GetKeyState()](http://ahkscript.org/docs/Functions.htm#GetKeyState)|Identical|Number
[GetKeyVK()](http://ahkscript.org/docs/Functions.htm#GetKeyName)|Identical|Number
**[Gosub](http://ahkscript.org/docs/commands/Gosub.htm)**|**Cannot use (AHK specific)**|**N/A**
**[Goto](http://ahkscript.org/docs/commands/Goto.htm)**|**Cannot use (AHK specific)**|**N/A**
[GroupActivate](http://ahkscript.org/docs/commands/GroupActivate.htm)|Normalization|Empty
[GroupAdd](http://ahkscript.org/docs/commands/GroupAdd.htm)|Normalization|Empty
[GroupClose](http://ahkscript.org/docs/commands/GroupClose.htm)|Normalization|Empty
[GroupDeactivate](http://ahkscript.org/docs/commands/GroupDeactivate.htm)|Normalization|Empty
[Gui](http://ahkscript.org/docs/commands/Gui.htm)|Normalization|Empty
[GuiClose](http://ahkscript.org/docs/commands/Gui.htm#GuiClose)|Minor change (built-in label becomes built-in function)|Empty
[GuiContextMenu](http://ahkscript.org/docs/commands/Gui.htm#GuiContextMenu)|Minor change (built-in label becomes built-in function)|Empty
[GuiControl](http://ahkscript.org/docs/commands/GuiControl.htm)|Normalization|Empty
[GuiControlGet](http://ahkscript.org/docs/commands/GuiControlGet.htm)|Normalization|String
[GuiDropFiles](http://ahkscript.org/docs/commands/Gui.htm#GuiDropFiles)|Minor change (built-in label becomes built-in function)|Empty
[GuiEscape](http://ahkscript.org/docs/commands/Gui.htm#GuiEscape)|Minor change (built-in label becomes built-in function)|Empty
[GuiSize](http://ahkscript.org/docs/commands/Gui.htm#GuiSize)|Minor change (built-in label becomes built-in function)|Empty
[Hotkey](http://ahkscript.org/docs/commands/Hotkey.htm)|Minor change (target label becomes closure)|Empty
[IL_Add()](http://ahkscript.org/docs/commands/ListView.htm#IL_Add)|Identical|Number
[IL_Create()](http://ahkscript.org/docs/commands/ListView.htm#IL_Create)|Identical|Number
[IL_Destroy()](http://ahkscript.org/docs/commands/ListView.htm#IL_Destroy)|Identical|Number
[ImageSearch](http://ahkscript.org/docs/commands/ImageSearch.htm)|Minor change (returns Object)|{}
[IniDelete](http://ahkscript.org/docs/commands/IniDelete.htm)|Normalization|Empty
[IniRead](http://ahkscript.org/docs/commands/IniRead.htm)|Normalization|String
[IniWrite](http://ahkscript.org/docs/commands/IniWrite.htm)|Normalization|Empty
[Input](http://ahkscript.org/docs/commands/Input.htm)|Normalization|String
[InputBox](http://ahkscript.org/docs/commands/InputBox.htm)|Normalization|String
[InStr()](http://ahkscript.org/docs/Functions.htm#InStr)|Identical|Number
**[IsByRef()](http://ahkscript.org/docs/Functions.htm#IsByRef)**|**Not needed (AHK specific)**|**N/A**
**[IsFunc()](http://ahkscript.org/docs/Functions.htm#IsFunc)**|**Not needed (AHK specific)**|**N/A**
**[IsLabel()](http://ahkscript.org/docs/Functions.htm#IsLabel)**|**Not needed (AHK specific)**|**N/A**
**[IsObject()](http://ahkscript.org/docs/Functions.htm#IsObject)**|**Not needed (AHK specific)**|**N/A**
[KeyHistory](http://ahkscript.org/docs/commands/KeyHistory.htm)|Normalization|Empty
[KeyWait](http://ahkscript.org/docs/commands/KeyWait.htm)|Normalization|Empty
[ListHotkeys](http://ahkscript.org/docs/commands/ListHotkeys.htm)|Normalization|Empty
**[ListLines](http://ahkscript.org/docs/commands/ListLines.htm)**|**Cannot implement for JS**|**N/A**
**[ListVars](http://ahkscript.org/docs/commands/ListVars.htm)**|**Cannot implement for JS**|**N/A**
[Ln()](http://ahkscript.org/docs/Functions.htm#Ln)|Identical|Number
[Log()](http://ahkscript.org/docs/Functions.htm#Log)|Identical|Number
[Loop](http://ahkscript.org/docs/commands/LoopFile.htm)|Major change|{}
[LTrim()](http://ahkscript.org/docs/Functions.htm#Log)|Identical|String
[LV_Add()](http://ahkscript.org/docs/commands/Trim.htm)|Identical|Number
[LV_Delete()](http://ahkscript.org/docs/commands/ListView.htm#LV_Delete)|Identical|Number
[LV_DeleteCol()](http://ahkscript.org/docs/commands/ListView.htm#LV_DeleteCol)|Identical|Number
[LV_GetCount()](http://ahkscript.org/docs/commands/ListView.htm#LV_GetCount)|Identical|Number
[LV_GetNext()](http://ahkscript.org/docs/commands/ListView.htm#LV_GetNext)|Identical|Number
[LV_GetText()](http://ahkscript.org/docs/commands/ListView.htm#LV_GetText)|Major change|String/{}
[LV_Insert()](http://ahkscript.org/docs/commands/ListView.htm#LV_Insert)|Identical|Number
[LV_InsertCol()](http://ahkscript.org/docs/commands/ListView.htm#LV_InsertCol)|Identical|Number
[LV_Modify()](http://ahkscript.org/docs/commands/ListView.htm#LV_Modify)|Identical|Number
[LV_ModifyCol()](http://ahkscript.org/docs/commands/ListView.htm#LV_ModifyCol)|Identical|Number
[LV_SetImageList()](http://ahkscript.org/docs/commands/ListView.htm#LV_SetImageList)|Identical|Number
[Menu](http://ahkscript.org/docs/commands/Menu.htm)|Normalization|Empty
[Mod()](http://ahkscript.org/docs/Functions.htm#Mod)|Identical|Number
[MouseClick](http://ahkscript.org/docs/commands/MouseClick.htm)|Normalization|Empty
[MouseClickDrag](http://ahkscript.org/docs/commands/MouseClickDrag.htm)|Normalization|Empty
[MouseGetPos](http://ahkscript.org/docs/commands/MouseGetPos.htm)|Minor change (returns Object)|{}
[MouseMove](http://ahkscript.org/docs/commands/MouseMove.htm)|Normalization|Empty
[MsgBox](http://ahkscript.org/docs/commands/MsgBox.htm)|Normalization|Empty
**[NumGet()](http://ahkscript.org/docs/commands/NumGet.htm)**|**Cannot use yet**|**N/A**
**[NumPut()](http://ahkscript.org/docs/commands/NumPut.htm)**|**Cannot use yet**|**N/A**
**[ObjAddRef()](http://ahkscript.org/docs/commands/ObjAddRef.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjClone()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
**[Object()](http://ahkscript.org/docs/Objects.htm#Usage_Associative_Arrays)**|**Not needed (AHK specific)**|**N/A**
**[ObjGetAddress()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjGetCapacity()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjHasKey()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjInsert()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjMaxIndex()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjMinIndex()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjNewEnum()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjRelease()](http://ahkscript.org/docs/commands/ObjAddRef.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjRemove()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
**[ObjSetCapacity()](http://ahkscript.org/docs/objects/Object.htm)**|**Not needed (AHK specific)**|**N/A**
[OnClipboardChange](http://ahkscript.org/docs/misc/Clipboard.htm#OnClipboardChange)|Minor change (built-in label becomes built-in function)|Empty
[OnExit](http://ahkscript.org/docs/commands/OnExit.htm)|Minor change (target label becomes closure)|Empty
[OnMessage()](http://ahkscript.org/docs/commands/OnMessage.htm)|Minor change (target function becomes closure)|Empty
[OutputDebug](http://ahkscript.org/docs/commands/OutputDebug.htm)|Normalization|Empty
[Pause](http://ahkscript.org/docs/commands/Pause.htm)|Normalization|Empty
[PixelGetColor](http://ahkscript.org/docs/commands/PixelGetColor.htm)|Normalization|String
[PixelSearch](http://ahkscript.org/docs/commands/PixelSearch.htm)|Minor change (returns Object)|{}
[PostMessage](http://ahkscript.org/docs/commands/PostMessage.htm)|Normalization|Empty
[Process](http://ahkscript.org/docs/commands/Process.htm)|Normalization|Empty
[ProgramFiles](http://ahkscript.org/docs/Variables.htm#ProgramFiles)|Identical|String
[Progress](http://ahkscript.org/docs/commands/Progress.htm)|Normalization|Empty
[Random](http://ahkscript.org/docs/commands/Random.htm)|Major change|Num/Empty
[RegDelete](http://ahkscript.org/docs/commands/RegDelete.htm)|Normalization|Empty
[RegExMatch()](http://ahkscript.org/docs/commands/RegExMatch.htm)|Major change|Number/{}
[RegExReplace()](http://ahkscript.org/docs/commands/RegExReplace.htm)|Major change|String/{}
**[RegisterCallback()](http://ahkscript.org/docs/commands/RegisterCallback.htm)**|**Cannot use yet**|**N/A**
[RegRead](http://ahkscript.org/docs/commands/RegRead.htm)|Normalization|String
[RegWrite](http://ahkscript.org/docs/commands/RegWrite.htm)|Normalization|Empty
[Reload](http://ahkscript.org/docs/commands/Reload.htm)|Normalization|Empty
[Round()](http://ahkscript.org/docs/Functions.htm#Round)|Identical|Number
[RTrim()](http://ahkscript.org/docs/commands/Trim.htm)|Identical|String
[Run](http://ahkscript.org/docs/commands/Run.htm)|Normalization|Empty
[RunAs](http://ahkscript.org/docs/commands/RunAs.htm)|Normalization|Empty
[RunWait](http://ahkscript.org/docs/commands/Run.htm)|Major change (doesn't return exit code)|String
[SB_SetIcon()](http://ahkscript.org/docs/commands/GuiControls.htm#SB_SetIcon)|Identical|Number
[SB_SetParts()](http://ahkscript.org/docs/commands/GuiControls.htm#SB_SetParts)|Identical|Number
[SB_SetText()](http://ahkscript.org/docs/commands/GuiControls.htm#SB_SetText)|Identical|Number
[Send](http://ahkscript.org/docs/commands/Send.htm)|Normalization|Empty
[SendEvent](http://ahkscript.org/docs/commands/Send.htm)|Normalization|Empty
[SendInput](http://ahkscript.org/docs/commands/Send.htm)|Normalization|Empty
[SendLevel](http://ahkscript.org/docs/commands/SendLevel.htm)|Normalization|Empty
[SendMessage](http://ahkscript.org/docs/commands/PostMessage.htm)|Normalization|Empty
[SendMode](http://ahkscript.org/docs/commands/SendMode.htm)|Normalization|Empty
[SendPlay](http://ahkscript.org/docs/commands/Send.htm)|Normalization|Empty
[SendRaw](http://ahkscript.org/docs/commands/Send.htm)|Normalization|Empty
[SetBatchLines](http://ahkscript.org/docs/commands/SetBatchLines.htm)|Normalization|Empty
[SetCapslockState](http://ahkscript.org/docs/commands/SetNumScrollCapsLockState.htm)|Normalization|Empty
[SetControlDelay](http://ahkscript.org/docs/commands/SetControlDelay.htm)|Normalization|Empty
[SetDefaultMouseSpeed](http://ahkscript.org/docs/commands/SetDefaultMouseSpeed.htm)|Normalization|Empty
**[SetEnv](http://ahkscript.org/docs/commands/SetEnv.htm)**|**Not needed (AHK specific)**|**N/A**
[SetFormat](http://ahkscript.org/docs/commands/SetFormat.htm)|Normalization|Empty
[SetKeyDelay](http://ahkscript.org/docs/commands/SetKeyDelay.htm)|Normalization|Empty
[SetMouseDelay](http://ahkscript.org/docs/commands/SetMouseDelay.htm)|Normalization|Empty
[SetNumLockState](http://ahkscript.org/docs/commands/SetNumScrollCapsLockState.htm)|Normalization|Empty
[SetRegView](http://ahkscript.org/docs/commands/SetRegView.htm)|Normalization|Empty
[SetScrollLockState](http://ahkscript.org/docs/commands/SetNumScrollCapsLockState.htm)|Normalization|Empty
[SetStoreCapslockMode](http://ahkscript.org/docs/commands/SetStoreCapslockMode.htm)|Normalization|Empty
**[SetTimer](http://ahkscript.org/docs/commands/SetTimer.htm)**|**Cannot use yet**|**Empty**
[SetTitleMatchMode](http://ahkscript.org/docs/commands/SetTitleMatchMode.htm)|Normalization|Empty
[SetWinDelay](http://ahkscript.org/docs/commands/SetWinDelay.htm)|Normalization|Empty
[SetWorkingDir](http://ahkscript.org/docs/commands/SetWorkingDir.htm)|Normalization|Empty
[Shutdown](http://ahkscript.org/docs/commands/Shutdown.htm)|Normalization|Empty
[Sin()](http://ahkscript.org/docs/Functions.htm#Sin)|Identical|Number
[Sleep](http://ahkscript.org/docs/commands/Sleep.htm)|Normalization|Empty
[Sort](http://ahkscript.org/docs/commands/Sort.htm)|Major change|String
[SoundBeep](http://ahkscript.org/docs/commands/SoundBeep.htm)|Normalization|Empty
[SoundGet](http://ahkscript.org/docs/commands/SoundGet.htm)|Normalization|Str/Num
[SoundGetWaveVolume](http://ahkscript.org/docs/commands/SoundGetWaveVolume.htm)|Normalization|Number
[SoundPlay](http://ahkscript.org/docs/commands/SoundPlay.htm)|Normalization|Empty
[SoundSet](http://ahkscript.org/docs/commands/SoundSet.htm)|Normalization|Empty
[SoundSetWaveVolume](http://ahkscript.org/docs/commands/SoundSetWaveVolume.htm)|Normalization|Empty
[SplashImage](http://ahkscript.org/docs/commands/Progress.htm)|Normalization|Empty
[SplashTextOff](http://ahkscript.org/docs/commands/SplashTextOn.htm)|Normalization|Empty
[SplashTextOn](http://ahkscript.org/docs/commands/SplashTextOn.htm)|Normalization|Empty
[SplitPath](http://ahkscript.org/docs/commands/SplitPath.htm)|Minor change (returns Object)|{}
[Sqrt()](http://ahkscript.org/docs/Functions.htm#Sqrt)|Identical|Number
[StatusBarGetText](http://ahkscript.org/docs/commands/StatusBarGetText.htm)|Normalization|String
[StatusBarWait](http://ahkscript.org/docs/commands/StatusBarWait.htm)|Normalization|Empty
[StrGet()](http://ahkscript.org/docs/Functions.htm#StrGet)|Identical|String
[StringCaseSense](http://ahkscript.org/docs/commands/StringCaseSense.htm)|Normalization|Empty
[StringGetPos](http://ahkscript.org/docs/commands/StringGetPos.htm)|Normalization|Number
[StringLeft](http://ahkscript.org/docs/commands/StringLeft.htm)|Normalization|String
[StringLen](http://ahkscript.org/docs/commands/StringLen.htm)|Normalization|String
[StringLower](http://ahkscript.org/docs/commands/StringLower.htm)|Normalization|String
[StringMid](http://ahkscript.org/docs/commands/StringMid.htm)|Normalization|String
[StringReplace](http://ahkscript.org/docs/commands/StringReplace.htm)|Normalization|String
[StringRight](http://ahkscript.org/docs/commands/StringLeft.htm)|Normalization|String
**[StringSplit](http://ahkscript.org/docs/commands/StringSplit.htm)**|**Not needed (deprecated by StrSplit)**|**N/A**
[StringTrimLeft](http://ahkscript.org/docs/commands/StringTrimLeft.htm)|Normalization|String
[StringTrimRight](http://ahkscript.org/docs/commands/StringTrimLeft.htm)|Normalization|String
[StringUpper](http://ahkscript.org/docs/commands/StringLower.htm)|Normalization|String
[StrLen()](http://ahkscript.org/docs/commands/StringLen.htm)|Identical|Number
[StrPut()](http://ahkscript.org/docs/commands/StrPutGet.htm)|Identical|Str/Num
[StrSplit()](http://ahkscript.org/docs/commands/StringSplit.htm)|Identical|Array
[SubStr()](http://ahkscript.org/docs/Functions.htm#SubStr)|Identical|String
[Suspend](http://ahkscript.org/docs/commands/Suspend.htm)|Normalization|Empty
[SysGet](http://ahkscript.org/docs/commands/SysGet.htm)|Minor change (returns Object)|Str/Num/{}
[Tan()](http://ahkscript.org/docs/Functions.htm#Tan)|Identical|Number
[Thread](http://ahkscript.org/docs/commands/Thread.htm)|Normalization|Empty
[ToolTip](http://ahkscript.org/docs/commands/ToolTip.htm)|Normalization|Empty
[Transform](http://ahkscript.org/docs/commands/Transform.htm)|Normalization|Str/Num
[TrayTip](http://ahkscript.org/docs/commands/TrayTip.htm)|Normalization|Empty
[Trim()](http://ahkscript.org/docs/commands/Trim.htm)|Identical|String
[TV_Add()](http://ahkscript.org/docs/commands/TreeView.htm#TV_Add)|Identical|Number
[TV_Delete()](http://ahkscript.org/docs/commands/TreeView.htm#TV_Delete)|Identical|Number
[TV_Get()](http://ahkscript.org/docs/commands/TreeView.htm#TV_Get)|Identical|Number
[TV_GetChild()](http://ahkscript.org/docs/commands/TreeView.htm#TV_GetChild)|Identical|Number
[TV_GetCount()](http://ahkscript.org/docs/commands/TreeView.htm#TV_GetCount)|Identical|Number
[TV_GetNext()](http://ahkscript.org/docs/commands/TreeView.htm#TV_GetNext)|Identical|Number
[TV_GetParent()](http://ahkscript.org/docs/commands/TreeView.htm#TV_GetParent)|Identical|Number
[TV_GetPrev()](http://ahkscript.org/docs/commands/TreeView.htm#TV_GetPrev)|Identical|Number
[TV_GetSelection()](http://ahkscript.org/docs/commands/TreeView.htm#TV_GetSelection)|Identical|Number
[TV_GetText()](http://ahkscript.org/docs/commands/TreeView.htm#TV_GetText)|Major change|String/{}
[TV_Modify()](http://ahkscript.org/docs/commands/TreeView.htm#TV_Modify)|Identical|Number
[TV_SetImageList()](http://ahkscript.org/docs/commands/TreeView.htm#TV_SetImageList)|Identical|Number
[UrlDownloadToFile](http://ahkscript.org/docs/commands/URLDownloadToFile.htm)|Normalization|Empty
**[VarSetCapacity()](http://ahkscript.org/docs/commands/VarSetCapacity.htm)**|**Cannot use yet**|**N/A**
[WinActivate](http://ahkscript.org/docs/commands/WinActivate.htm)|Normalization|Empty
[WinActivateBottom](http://ahkscript.org/docs/commands/WinActivateBottom.htm)|Normalization|Empty
[WinActive()](http://ahkscript.org/docs/commands/WinActive.htm)|Identical|String
[WinClose](http://ahkscript.org/docs/commands/WinClose.htm)|Normalization|Empty
[WinExist()](http://ahkscript.org/docs/commands/WinExist.htm)|Identical|String
[WinGet](http://ahkscript.org/docs/commands/WinGet.htm)|Minor change (returns Object)|Str/Num/{}
[WinGetActiveStats](http://ahkscript.org/docs/commands/WinGetActiveStats.htm)|Minor change (returns Object)|{}
[WinGetActiveTitle](http://ahkscript.org/docs/commands/WinGetActiveTitle.htm)|Normalization|String
[WinGetClass](http://ahkscript.org/docs/commands/WinGetClass.htm)|Normalization|String
[WinGetPos](http://ahkscript.org/docs/commands/WinGetPos.htm)|Minor change (returns Object)|{}
[WinGetText](http://ahkscript.org/docs/commands/WinGetText.htm)|Normalization|String
[WinGetTitle](http://ahkscript.org/docs/commands/WinGetTitle.htm)|Normalization|String
[WinHide](http://ahkscript.org/docs/commands/WinHide.htm)|Normalization|Empty
[WinKill](http://ahkscript.org/docs/commands/WinKill.htm)|Normalization|Empty
[WinMaximize](http://ahkscript.org/docs/commands/WinMaximize.htm)|Normalization|Empty
[WinMenuSelectItem](http://ahkscript.org/docs/commands/WinMenuSelectItem.htm)|Normalization|Empty
[WinMinimize](http://ahkscript.org/docs/commands/WinMinimize.htm)|Normalization|Empty
[WinMinimizeAll](http://ahkscript.org/docs/commands/WinMinimizeAll.htm)|Normalization|Empty
[WinMinimizeAllUndo](http://ahkscript.org/docs/commands/WinMinimizeAll.htm)|Normalization|Empty
[WinMove](http://ahkscript.org/docs/commands/WinMove.htm)|Normalization|Empty
[WinRestore](http://ahkscript.org/docs/commands/WinRestore.htm)|Normalization|Empty
[WinSet](http://ahkscript.org/docs/commands/WinSet.htm)|Normalization|Empty
[WinSetTitle](http://ahkscript.org/docs/commands/WinSetTitle.htm)|Normalization|Empty
[WinShow](http://ahkscript.org/docs/commands/WinShow.htm)|Normalization|Empty
[WinWait](http://ahkscript.org/docs/commands/WinWait.htm)|Normalization|Empty
[WinWaitActive](http://ahkscript.org/docs/commands/WinWaitActive.htm)|Normalization|Empty
[WinWaitClose](http://ahkscript.org/docs/commands/WinWaitClose.htm)|Normalization|Empty
[WinWaitNotActive](http://ahkscript.org/docs/commands/WinWaitActive.htm)|Normalization|Empty
**[#ClipboardTimeout](http://ahkscript.org/docs/commands/_ClipboardTimeout.htm)**|**Cannot use directives**|**N/A**
**[#CommentFlag](http://ahkscript.org/docs/commands/_CommentFlag.htm)**|**Not needed (AHK specific)**|**N/A**
**[#ErrorStdOut](http://ahkscript.org/docs/commands/_ErrorStdOut.htm)**|**Not needed (AHK specific)**|**N/A**
**[#EscapeChar](http://ahkscript.org/docs/commands/_EscapeChar.htm)**|**Not needed (AHK specific)**|**N/A**
**[#HotkeyInterval](http://ahkscript.org/docs/commands/_HotkeyInterval.htm)**|**Cannot use directives**|**N/A**
**[#HotkeyModifierTimeout](http://ahkscript.org/docs/commands/_HotkeyModifierTimeout.htm)**|**Cannot use directives**|**N/A**
**[#Hotstring](http://ahkscript.org/docs/commands/_Hotstring.htm)**|**Cannot use directives. TODO: implement "Hotstring()" by Menixator**|**N/A**
**[#If](http://ahkscript.org/docs/commands/_If.htm)**|**Cannot use directives. Try "Hotkey()"+"if" instead.**|**N/A**
**[#IfTimeout](http://ahkscript.org/docs/commands/_IfTimeout.htm)**|**Cannot use directives. Try "Hotkey()"+"if" instead.**|**N/A**
**[#IfWinActive](http://ahkscript.org/docs/commands/_IfWinActive.htm)**|**Cannot use directives. Try "Hotkey()"+"if" instead.**|**N/A**
**[#IfWinExist](http://ahkscript.org/docs/commands/_IfWinActive.htm)**|**Cannot use directives. Try "Hotkey()"+"if" instead.**|**N/A**
**[#Include](http://ahkscript.org/docs/commands/_Include.htm)**|**Cannot use yet.**|**N/A**
**[#InputLevel](http://ahkscript.org/docs/commands/_InputLevel.htm)**|**Cannot use directives**|**N/A**
**[#InstallKeybdHook](http://ahkscript.org/docs/commands/_InstallKeybdHook.htm)**|**Cannot use directives**|**N/A**
**[#InstallMouseHook](http://ahkscript.org/docs/commands/_InstallMouseHook.htm)**|**Cannot use directives**|**N/A**
**[#KeyHistory](http://ahkscript.org/docs/commands/_KeyHistory.htm)**|**Cannot use directives**|**N/A**
**[#LTrim](http://ahkscript.org/docs/Scripts.htm#LTrim)**|**Not needed (AHK specific)**|**N/A**
**[#MaxHotkeysPerInterval](http://ahkscript.org/docs/commands/_MaxHotkeysPerInterval.htm)**|**Cannot use directives**|**N/A**
**[#MaxMem](http://ahkscript.org/docs/commands/_MaxMem.htm)**|**Cannot use directives**|**N/A**
**[#MaxThreads](http://ahkscript.org/docs/commands/_MaxThreads.htm)**|**Cannot use directives**|**N/A**
**[#MaxThreadsBuffer](http://ahkscript.org/docs/commands/_MaxThreadsBuffer.htm)**|**Cannot use directives**|**N/A**
**[#MaxThreadsPerHotkey](http://ahkscript.org/docs/commands/_MaxThreadsPerHotkey.htm)**|**Cannot use directives**|**N/A**
**[#MenuMaskKey](http://ahkscript.org/docs/commands/_MenuMaskKey.htm)**|**Cannot use directives**|**N/A**
**[#NoEnv](http://ahkscript.org/docs/commands/_NoEnv.htm)**|**Not needed (AHK specific)**|**N/A**
**[#NoTrayIcon](http://ahkscript.org/docs/commands/_NoTrayIcon.htm)**|**Cannot use directives. Try "Menu()" instead.**|**N/A**
**[#Persistent](http://ahkscript.org/docs/commands/_Persistent.htm)**|**Cannot use directives. Try creating a (dummy) "hotkey()".**|**N/A**
**[#SingleInstance](http://ahkscript.org/docs/commands/_SingleInstance.htm)**|**Cannot use directives. Try "Run" and "/restart" instead.**|**N/A**
**[#UseHook](http://ahkscript.org/docs/commands/_UseHook.htm)**|**Cannot use directives. Try "Hotkey($)" instead.**|**N/A**
**[#Warn](http://ahkscript.org/docs/commands/_Warn.htm)**|**Not needed (AHK specific)**|**N/A**
**[#WinActivateForce](http://ahkscript.org/docs/commands/_WinActivateForce.htm)**|**Cannot use directives**|**N/A**
~|Addition: "Require()" (a globally scoped #Include)|Empty


## TODO
- Test every keyword
- Accept/Provide URI paths in all transactions (not DOS-style paths)
- Allow "Include" to use online URL
- Implement "IncludeAgain"
- Implement "DateAdd" and "DateDiff"
- Implement some of the Directives (especially "#SingleInstance")
- Maybe implement a console (Firebug lite has some issues)