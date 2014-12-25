#NoEnv
;#SingleInstance, Force

#Include %A_ScriptDir%\lib\API.ahk
#Include %A_ScriptDir%\lib\ComDispatch.ahk
#Include %A_ScriptDir%\lib\ComDispTable.ahk
#Include %A_ScriptDir%\lib\ComVar.ahk
#Include %A_ScriptDir%\lib\getArgs.ahk
#Include %A_ScriptDir%\lib\fixIE.ahk
#Include %A_ScriptDir%\lib\trace.ahk


; Global variables
hotkeysMap := {}
mapOnMessageClosures := {}
threadDefaults := {}
errLevel := 0
closureOnClipboardChange := ""
closureOnExit := ""

ENUM_NUMBER_TYPES =
(
A_ControlDelay,A_DefaultMouseSpeed,A_IconHidden,A_Is64bitOS,A_IsAdmin,A_IsCritical,A_IsPaused,
A_IsSuspended,A_KeyDelay,A_MouseDelay,A_PtrSize,A_ScreenDPI,A_ScreenHeight,A_ScreenWidth,
A_TickCount,A_TimeIdle,A_TimeIdlePhysical,A_TimeSincePriorHotkey,A_TimeSinceThisHotkey,
A_WinDelay,ACos,ASin,ATan,Cos,Exp,Ln,Log,Sin,Sqrt,Tan
)
enumNumberTypes := enum(ENUM_NUMBER_TYPES)

REG_NAMES =
(
HKEY_LOCAL_MACHINE,HKLM
HKEY_USERS,HKU
HKEY_CURRENT_USER,HKCU
HKEY_CLASSES_ROOT,HKCR
HKEY_CURRENT_CONFIG,HKCC
)
regNames := enum(REG_NAMES)


; Accept parameters
args := getArgs()
main := ""
for key, val in args {
	if (RegExMatch(val, "i)\.js$")) {
		main := val
		break
	}
}
if (!main) {
	main := "demo.js"
}
Loop, %main%
{
	mainPath := A_LoopFileLongPath
}
if (!mainPath) {
	end("The main file could not be located!`n" . main)
}



; Set working dir
SplitPath, mainPath,, mainPathDir
SetWorkingDir %mainPathDir%  ; From now on, all relative paths are based on the JS location



; Build and hook the webpage.
fixIE(true)
Gui Add, ActiveX, w800 h600 vwb, Shell.Explorer
wb.Navigate("about:blank")
wb.document.write("<script>__AHK = {}</script>") ; attempt to mitigate the race condition by speeding up the registering
wb.document.parentWindow.__AHK := ComDispatch("", "bridge")
FileRead, ExoJS, %A_ScriptDir%\lib\Exo.js
wb.document.write("<html><head><script>" . ExoJS . "</script></head><body></body></html>")
FileRead, mainContent, %mainPath%
wb.document.write("<script>" . mainContent . "</script>")
fixIE(false)



; Uncomment this to see the Browser
;Gui, Show


return


/*
GuiClose:
ExitApp
ESC::
ExitApp
*/


/**
 *
 */
bridge(this,name,args*){
	;trace(name)
	
	global enumNumberTypes
	global errLevel
	
	setThreadDefaults()
	
	; identify function
	fn := Func("_" . name)
	if (!fn) {
		isBuiltIn := 1
		fn := Func(name)
	}
	
	if (fn) { ; action (command, function, directive), either from API or built-in
		verifyParamCount(fn, name, args)
		try {
			result := fn.(args*) ; variadic function call (http://ahkscript.org/docs/Functions.htm#VariadicCall)
			errLevel := 0
		} catch, e {
			errLevel := e.Message
		}
	} else { ; built-in variable
		if (args.MaxIndex()) { ; someone tried to write to this variable
			end("The built-in variable """ . name . """ is read-only!")
		}
		result := %name%
	}
	if (isBuiltIn) { ; a non-API (non-overriden) action or variable
		if (enumNumberTypes.HasKey(name)) {
			inject(result, "Number")
		} else {
			inject(result)
		}
	} else {
		; nothing to do here. The API action has already injected the results
	}
}



/**
 *
 */
verifyParamCount(fn, name, args){
	len := args.MaxIndex()
	if (!len) {
		len := 0
	}
	if (len > fn.MaxParams) {
		end("Too MANY arguments for """ . name . "()""!")
	} else if (len < fn.MinParams) {
		end("Too few arguments for """ . name . "()""!")
	}
}


/**
 * We need the variadic "args" to pass along the parameters of "OnMessage"
 */
trigger(closureId, args*){
	if (closureId != "") {
		global wb
		ExoObj := wb.document.parentWindow.Exo
		result := ""
		if (!args.MaxIndex()) {
			result := ExoObj.trigger(closureId)
		} else if (args.MaxIndex() == 1) {
			result := ExoObj.trigger(closureId, args[1])
		} else if (args.MaxIndex() == 2) {
			result := ExoObj.trigger(closureId, args[1], args[2])
		} else if (args.MaxIndex() == 3) {
			result := ExoObj.trigger(closureId, args[1], args[2], args[3])
		} else if (args.MaxIndex() == 4) {
			result := ExoObj.trigger(closureId, args[1], args[2], args[3], args[4])
		}
		return result
	}
}


/**
 *
 */
inject(obj, type="", path=""){
    global wb
    if (isObject(obj)) {
        prefix :=  path==""?"" : (path . ".")
		isArray := 1
		for key, val in obj {
			if (key + 100 == "") { ; failed the Number test
				isArray := 0
				break
			}
        }
		if (isArray && obj.MinIndex() == 1) {
			obj.Remove(0) ; make it 0-based
		}
		;trace("isArray = " . isArray)
        wb.document.parentWindow.Exo.receive("", isArray?"Array":"Object", path)
        for key, val in obj {
            inject(val, "", prefix . key)
        }
    } else {
        wb.document.parentWindow.Exo.receive(obj, type, path)
    }
}


/**
 *
 */
enum(blob){
	blob := RegExReplace(blob, "\s+", ",")
	parts := StrSplit(blob, ",")
	output := {}
	for key, val in parts {
		output[val] := 1
	}
	return output
}


/**
 *
 */
setThreadDefaults(){
	global threadDefaults
	for key, val in threadDefaults {
		fn := Func("_" . key)
		fn.(val*) ; variadic function call
	}
}




/**
 *
 */
end(message){
	message .= "`nThe application will now exit."
	MsgBox % message
	ExitApp
}



;#########################################################
;##################   L A B E L S   ######################
;#########################################################


/**
 * Built-in label.
 */
OnClipboardChange:
	global closureOnClipboardChange
	trigger(closureOnClipboardChange)
return


/**
 * "OnExit()" redirects here.
 */
LabelOnExit:
	global closureOnExit
	trigger(closureOnExit)
	ExitApp
return


/**
 * "Hotkey()" redirects here.
 */
LabelHotkey:
	global hotkeysMap
	trigger(hotkeysMap[A_ThisHotkey])
return


/**
 * "OnMessage()" redirects here. Not actually a label, but close enough.
 */
OnMessageClosure(wParam, lParam, msg, hwnd){
	global mapOnMessageClosures
	trigger(mapOnMessageClosures[msg], wParam, lParam, msg, hwnd)
}




/*
TODO:
guiescape guiclose guisize guicontextmenu guidropfiles

*/

