var Exo = {


	/**
	 *
	 */
	'send':function(name,args){
		var a = []; // a true-array storage for the arguments
		if (args && args.length) {
			var len = args.length;
			for (var i = 0; i < len; i++) {
				var arg = args[i];
				if (typeof arg === 'function') {
					var index = Exo._closures.indexOf(arg);
					if (index < 0) {
						Exo._closures.push(arg);
						index = Exo._closures.length - 1;
					}
					arg = index;
				}
				a.push(arg);
			}
		}
		
		// Call the "bridge()" in AHK.
		// Normally, we would ".apply()" the arguments. However, the bridge has a ghostly presence
		// (it exists if you call it directly, but you can't get a handle on it).
		// Therefore, we must use "eval()".
		var evalBlob = "__AHK.bridge(name";
		for (var i = 0; i < a.length; i++) {
			evalBlob += ",a[" + i + "]";
		}
		evalBlob += ")";

		// The outcome of running the bridge is stored by AHK in "_result".
		Exo._result = undefined;
		eval(evalBlob);
		return Exo._result;
	},
	
	
	/**
	 *
	 */
	'trigger':function(){
		var len = arguments.length;
		if (!len) {
			alert("Missing closure!");
			return
		}
		var args = [];
		for (var i = 0; i < len; i++) {
			args.push(arguments[i]);
		}
		var closureId = args[0];
		var closure = Exo._closures[closureId];
		if (typeof closure === 'function') {
			args.shift();
			return closure.apply(null,args);
		} else {
			alert("Cannot trigger closure!");
		}
	},
	
	
	/**
	 * This function gets called by AHK to store values in "_result".
	 * It was needed because we want the result to have a native type, not just "String".
	 * The "_result" that gets set here will be returned by "send()".
	 */
	'receive':function(value, type, path){
		path = String(path); // ensure we don't get a Number from AHK
		//console.log(value+','+type+',' + path)
		var val;
		switch (type) {
			case 'Number': val = Number(value); break;
			case 'Undefined': val = undefined; break;
			case 'Array': val = []; break;
			case 'Object': val = {}; break;
			case 'String': val = String(value); break;
			default: val = value; break;
		}
		if (path) {
			var label = String(path);
			var target = Exo._result;
			var parts = path.split('.');
			if (parts.length > 1) {
				label = parts.pop();
				var blob = 'Exo._result["' + parts.join('"]["') + '"]';
				target = eval(blob);
			}
			target[label] = val;
		} else {
			Exo._result = val;
		}
		//alert(JSON.stringify(Exo._result))
	},
	
	
	/**
	 * Stores any functions that were passed as parameters to Exo.send()
	 * so that they can later be retrieved by Exo.trigger() based on their numeric index.
	 */
	'_closures':[],


	/**
	 * Stores the return value that "send()" will use.
	 * We had to use this workaround because "AHK.bridge()" can only return String and we don't want
	 * to use JSON. Basically, the data flow is like this:
	 *		A_Now -> Exo.send() -------------------------------------> _result
	 *						|								  |
	 *						-> AHK.bridge() ->Exo.receive() ->
	 */
	'_result':null



};


Object.defineProperty(window,'A_AhkPath',{get:function(){return Exo.send('A_AhkPath');}, set:function(value){Exo.send('A_AhkPath',[value]);}});
Object.defineProperty(window,'A_AhkVersion',{get:function(){return Exo.send('A_AhkVersion');}, set:function(value){Exo.send('A_AhkVersion',[value]);}});
Object.defineProperty(window,'A_AppData',{get:function(){return Exo.send('A_AppData');}, set:function(value){Exo.send('A_AppData',[value]);}});
Object.defineProperty(window,'A_AppDataCommon',{get:function(){return Exo.send('A_AppDataCommon');}, set:function(value){Exo.send('A_AppDataCommon',[value]);}});
Object.defineProperty(window,'A_BatchLines',{get:function(){return Exo.send('A_BatchLines');}, set:function(value){Exo.send('A_BatchLines',[value]);}});
Object.defineProperty(window,'A_CaretX',{get:function(){return Exo.send('A_CaretX');}, set:function(value){Exo.send('A_CaretX',[value]);}});
Object.defineProperty(window,'A_CaretY',{get:function(){return Exo.send('A_CaretY');}, set:function(value){Exo.send('A_CaretY',[value]);}});
Object.defineProperty(window,'A_ComputerName',{get:function(){return Exo.send('A_ComputerName');}, set:function(value){Exo.send('A_ComputerName',[value]);}});
Object.defineProperty(window,'A_ControlDelay',{get:function(){return Exo.send('A_ControlDelay');}, set:function(value){Exo.send('A_ControlDelay',[value]);}});
Object.defineProperty(window,'A_Cursor',{get:function(){return Exo.send('A_Cursor');}, set:function(value){Exo.send('A_Cursor',[value]);}});
Object.defineProperty(window,'A_DD',{get:function(){return Exo.send('A_DD');}, set:function(value){Exo.send('A_DD',[value]);}});
Object.defineProperty(window,'A_DDD',{get:function(){return Exo.send('A_DDD');}, set:function(value){Exo.send('A_DDD',[value]);}});
Object.defineProperty(window,'A_DDDD',{get:function(){return Exo.send('A_DDDD');}, set:function(value){Exo.send('A_DDDD',[value]);}});
Object.defineProperty(window,'A_DefaultMouseSpeed',{get:function(){return Exo.send('A_DefaultMouseSpeed');}, set:function(value){Exo.send('A_DefaultMouseSpeed',[value]);}});
Object.defineProperty(window,'A_Desktop',{get:function(){return Exo.send('A_Desktop');}, set:function(value){Exo.send('A_Desktop',[value]);}});
Object.defineProperty(window,'A_DesktopCommon',{get:function(){return Exo.send('A_DesktopCommon');}, set:function(value){Exo.send('A_DesktopCommon',[value]);}});
Object.defineProperty(window,'A_DetectHiddenText',{get:function(){return Exo.send('A_DetectHiddenText');}, set:function(value){Exo.send('A_DetectHiddenText',[value]);}});
Object.defineProperty(window,'A_DetectHiddenWindows',{get:function(){return Exo.send('A_DetectHiddenWindows');}, set:function(value){Exo.send('A_DetectHiddenWindows',[value]);}});
Object.defineProperty(window,'A_ExitReason',{get:function(){return Exo.send('A_ExitReason');}, set:function(value){Exo.send('A_ExitReason',[value]);}});
Object.defineProperty(window,'A_FileEncoding',{get:function(){return Exo.send('A_FileEncoding');}, set:function(value){Exo.send('A_FileEncoding',[value]);}});
Object.defineProperty(window,'A_FormatFloat',{get:function(){return Exo.send('A_FormatFloat');}, set:function(value){Exo.send('A_FormatFloat',[value]);}});
Object.defineProperty(window,'A_FormatInteger',{get:function(){return Exo.send('A_FormatInteger');}, set:function(value){Exo.send('A_FormatInteger',[value]);}});
Object.defineProperty(window,'A_Hour',{get:function(){return Exo.send('A_Hour');}, set:function(value){Exo.send('A_Hour',[value]);}});
Object.defineProperty(window,'A_IconFile',{get:function(){return Exo.send('A_IconFile');}, set:function(value){Exo.send('A_IconFile',[value]);}});
Object.defineProperty(window,'A_IconHidden',{get:function(){return Exo.send('A_IconHidden');}, set:function(value){Exo.send('A_IconHidden',[value]);}});
Object.defineProperty(window,'A_IconNumber',{get:function(){return Exo.send('A_IconNumber');}, set:function(value){Exo.send('A_IconNumber',[value]);}});
Object.defineProperty(window,'A_IconTip',{get:function(){return Exo.send('A_IconTip');}, set:function(value){Exo.send('A_IconTip',[value]);}});
Object.defineProperty(window,'A_IPAddress1',{get:function(){return Exo.send('A_IPAddress1');}, set:function(value){Exo.send('A_IPAddress1',[value]);}});
Object.defineProperty(window,'A_IPAddress2',{get:function(){return Exo.send('A_IPAddress2');}, set:function(value){Exo.send('A_IPAddress2',[value]);}});
Object.defineProperty(window,'A_IPAddress3',{get:function(){return Exo.send('A_IPAddress3');}, set:function(value){Exo.send('A_IPAddress3',[value]);}});
Object.defineProperty(window,'A_IPAddress4',{get:function(){return Exo.send('A_IPAddress4');}, set:function(value){Exo.send('A_IPAddress4',[value]);}});
Object.defineProperty(window,'A_Is64bitOS',{get:function(){return Exo.send('A_Is64bitOS');}, set:function(value){Exo.send('A_Is64bitOS',[value]);}});
Object.defineProperty(window,'A_IsAdmin',{get:function(){return Exo.send('A_IsAdmin');}, set:function(value){Exo.send('A_IsAdmin',[value]);}});
Object.defineProperty(window,'A_IsCompiled',{get:function(){return Exo.send('A_IsCompiled');}, set:function(value){Exo.send('A_IsCompiled',[value]);}});
Object.defineProperty(window,'A_IsCritical',{get:function(){return Exo.send('A_IsCritical');}, set:function(value){Exo.send('A_IsCritical',[value]);}});
Object.defineProperty(window,'A_IsPaused',{get:function(){return Exo.send('A_IsPaused');}, set:function(value){Exo.send('A_IsPaused',[value]);}});
Object.defineProperty(window,'A_IsSuspended',{get:function(){return Exo.send('A_IsSuspended');}, set:function(value){Exo.send('A_IsSuspended',[value]);}});
Object.defineProperty(window,'A_IsUnicode',{get:function(){return Exo.send('A_IsUnicode');}, set:function(value){Exo.send('A_IsUnicode',[value]);}});
Object.defineProperty(window,'A_KeyDelay',{get:function(){return Exo.send('A_KeyDelay');}, set:function(value){Exo.send('A_KeyDelay',[value]);}});
Object.defineProperty(window,'A_Language',{get:function(){return Exo.send('A_Language');}, set:function(value){Exo.send('A_Language',[value]);}});
Object.defineProperty(window,'A_LastError',{get:function(){return Exo.send('A_LastError');}, set:function(value){Exo.send('A_LastError',[value]);}});
Object.defineProperty(window,'A_MDay',{get:function(){return Exo.send('A_MDay');}, set:function(value){Exo.send('A_MDay',[value]);}});
Object.defineProperty(window,'A_Min',{get:function(){return Exo.send('A_Min');}, set:function(value){Exo.send('A_Min',[value]);}});
Object.defineProperty(window,'A_MM',{get:function(){return Exo.send('A_MM');}, set:function(value){Exo.send('A_MM',[value]);}});
Object.defineProperty(window,'A_MMM',{get:function(){return Exo.send('A_MMM');}, set:function(value){Exo.send('A_MMM',[value]);}});
Object.defineProperty(window,'A_MMMM',{get:function(){return Exo.send('A_MMMM');}, set:function(value){Exo.send('A_MMMM',[value]);}});
Object.defineProperty(window,'A_Mon',{get:function(){return Exo.send('A_Mon');}, set:function(value){Exo.send('A_Mon',[value]);}});
Object.defineProperty(window,'A_MouseDelay',{get:function(){return Exo.send('A_MouseDelay');}, set:function(value){Exo.send('A_MouseDelay',[value]);}});
Object.defineProperty(window,'A_MSec',{get:function(){return Exo.send('A_MSec');}, set:function(value){Exo.send('A_MSec',[value]);}});
Object.defineProperty(window,'A_MyDocuments',{get:function(){return Exo.send('A_MyDocuments');}, set:function(value){Exo.send('A_MyDocuments',[value]);}});
Object.defineProperty(window,'A_Now',{get:function(){return Exo.send('A_Now');}, set:function(value){Exo.send('A_Now',[value]);}});
Object.defineProperty(window,'A_NowUTC',{get:function(){return Exo.send('A_NowUTC');}, set:function(value){Exo.send('A_NowUTC',[value]);}});
Object.defineProperty(window,'A_NumBatchLines',{get:function(){return Exo.send('A_NumBatchLines');}, set:function(value){Exo.send('A_NumBatchLines',[value]);}});
Object.defineProperty(window,'A_OSType',{get:function(){return Exo.send('A_OSType');}, set:function(value){Exo.send('A_OSType',[value]);}});
Object.defineProperty(window,'A_OSVersion',{get:function(){return Exo.send('A_OSVersion');}, set:function(value){Exo.send('A_OSVersion',[value]);}});
Object.defineProperty(window,'A_PriorHotkey',{get:function(){return Exo.send('A_PriorHotkey');}, set:function(value){Exo.send('A_PriorHotkey',[value]);}});
Object.defineProperty(window,'A_PriorKey',{get:function(){return Exo.send('A_PriorKey');}, set:function(value){Exo.send('A_PriorKey',[value]);}});
Object.defineProperty(window,'A_ProgramFiles',{get:function(){return Exo.send('A_ProgramFiles');}, set:function(value){Exo.send('A_ProgramFiles',[value]);}});
Object.defineProperty(window,'A_Programs',{get:function(){return Exo.send('A_Programs');}, set:function(value){Exo.send('A_Programs',[value]);}});
Object.defineProperty(window,'A_ProgramsCommon',{get:function(){return Exo.send('A_ProgramsCommon');}, set:function(value){Exo.send('A_ProgramsCommon',[value]);}});
Object.defineProperty(window,'A_PtrSize',{get:function(){return Exo.send('A_PtrSize');}, set:function(value){Exo.send('A_PtrSize',[value]);}});
Object.defineProperty(window,'A_RegView',{get:function(){return Exo.send('A_RegView');}, set:function(value){Exo.send('A_RegView',[value]);}});
Object.defineProperty(window,'A_ScreenDPI',{get:function(){return Exo.send('A_ScreenDPI');}, set:function(value){Exo.send('A_ScreenDPI',[value]);}});
Object.defineProperty(window,'A_ScreenHeight',{get:function(){return Exo.send('A_ScreenHeight');}, set:function(value){Exo.send('A_ScreenHeight',[value]);}});
Object.defineProperty(window,'A_ScreenWidth',{get:function(){return Exo.send('A_ScreenWidth');}, set:function(value){Exo.send('A_ScreenWidth',[value]);}});
Object.defineProperty(window,'A_ScriptDir',{get:function(){return Exo.send('A_ScriptDir');}, set:function(value){Exo.send('A_ScriptDir',[value]);}});
Object.defineProperty(window,'A_ScriptFullPath',{get:function(){return Exo.send('A_ScriptFullPath');}, set:function(value){Exo.send('A_ScriptFullPath',[value]);}});
Object.defineProperty(window,'A_ScriptHwnd',{get:function(){return Exo.send('A_ScriptHwnd');}, set:function(value){Exo.send('A_ScriptHwnd',[value]);}});
Object.defineProperty(window,'A_ScriptName',{get:function(){return Exo.send('A_ScriptName');}, set:function(value){Exo.send('A_ScriptName',[value]);}});
Object.defineProperty(window,'A_Sec',{get:function(){return Exo.send('A_Sec');}, set:function(value){Exo.send('A_Sec',[value]);}});
Object.defineProperty(window,'A_Space',{get:function(){return Exo.send('A_Space');}, set:function(value){Exo.send('A_Space',[value]);}});
Object.defineProperty(window,'A_StartMenu',{get:function(){return Exo.send('A_StartMenu');}, set:function(value){Exo.send('A_StartMenu',[value]);}});
Object.defineProperty(window,'A_StartMenuCommon',{get:function(){return Exo.send('A_StartMenuCommon');}, set:function(value){Exo.send('A_StartMenuCommon',[value]);}});
Object.defineProperty(window,'A_Startup',{get:function(){return Exo.send('A_Startup');}, set:function(value){Exo.send('A_Startup',[value]);}});
Object.defineProperty(window,'A_StartupCommon',{get:function(){return Exo.send('A_StartupCommon');}, set:function(value){Exo.send('A_StartupCommon',[value]);}});
Object.defineProperty(window,'A_StringCaseSense',{get:function(){return Exo.send('A_StringCaseSense');}, set:function(value){Exo.send('A_StringCaseSense',[value]);}});
Object.defineProperty(window,'A_Tab',{get:function(){return Exo.send('A_Tab');}, set:function(value){Exo.send('A_Tab',[value]);}});
Object.defineProperty(window,'A_Temp',{get:function(){return Exo.send('A_Temp');}, set:function(value){Exo.send('A_Temp',[value]);}});
Object.defineProperty(window,'A_ThisHotkey',{get:function(){return Exo.send('A_ThisHotkey');}, set:function(value){Exo.send('A_ThisHotkey',[value]);}});
Object.defineProperty(window,'A_ThisMenu',{get:function(){return Exo.send('A_ThisMenu');}, set:function(value){Exo.send('A_ThisMenu',[value]);}});
Object.defineProperty(window,'A_ThisMenuItem',{get:function(){return Exo.send('A_ThisMenuItem');}, set:function(value){Exo.send('A_ThisMenuItem',[value]);}});
Object.defineProperty(window,'A_ThisMenuItemPos',{get:function(){return Exo.send('A_ThisMenuItemPos');}, set:function(value){Exo.send('A_ThisMenuItemPos',[value]);}});
Object.defineProperty(window,'A_TickCount',{get:function(){return Exo.send('A_TickCount');}, set:function(value){Exo.send('A_TickCount',[value]);}});
Object.defineProperty(window,'A_TimeIdle',{get:function(){return Exo.send('A_TimeIdle');}, set:function(value){Exo.send('A_TimeIdle',[value]);}});
Object.defineProperty(window,'A_TimeIdlePhysical',{get:function(){return Exo.send('A_TimeIdlePhysical');}, set:function(value){Exo.send('A_TimeIdlePhysical',[value]);}});
Object.defineProperty(window,'A_TimeSincePriorHotkey',{get:function(){return Exo.send('A_TimeSincePriorHotkey');}, set:function(value){Exo.send('A_TimeSincePriorHotkey',[value]);}});
Object.defineProperty(window,'A_TimeSinceThisHotkey',{get:function(){return Exo.send('A_TimeSinceThisHotkey');}, set:function(value){Exo.send('A_TimeSinceThisHotkey',[value]);}});
Object.defineProperty(window,'A_TitleMatchMode',{get:function(){return Exo.send('A_TitleMatchMode');}, set:function(value){Exo.send('A_TitleMatchMode',[value]);}});
Object.defineProperty(window,'A_TitleMatchModeSpeed',{get:function(){return Exo.send('A_TitleMatchModeSpeed');}, set:function(value){Exo.send('A_TitleMatchModeSpeed',[value]);}});
Object.defineProperty(window,'A_UserName',{get:function(){return Exo.send('A_UserName');}, set:function(value){Exo.send('A_UserName',[value]);}});
Object.defineProperty(window,'A_WDay',{get:function(){return Exo.send('A_WDay');}, set:function(value){Exo.send('A_WDay',[value]);}});
Object.defineProperty(window,'A_WinDelay',{get:function(){return Exo.send('A_WinDelay');}, set:function(value){Exo.send('A_WinDelay',[value]);}});
Object.defineProperty(window,'A_WinDir',{get:function(){return Exo.send('A_WinDir');}, set:function(value){Exo.send('A_WinDir',[value]);}});
Object.defineProperty(window,'A_WorkingDir',{get:function(){return Exo.send('A_WorkingDir');}, set:function(value){Exo.send('A_WorkingDir',[value]);}});
Object.defineProperty(window,'A_YDay',{get:function(){return Exo.send('A_YDay');}, set:function(value){Exo.send('A_YDay',[value]);}});
Object.defineProperty(window,'A_Year',{get:function(){return Exo.send('A_Year');}, set:function(value){Exo.send('A_Year',[value]);}});
Object.defineProperty(window,'A_YWeek',{get:function(){return Exo.send('A_YWeek');}, set:function(value){Exo.send('A_YWeek',[value]);}});
Object.defineProperty(window,'A_YYYY',{get:function(){return Exo.send('A_YYYY');}, set:function(value){Exo.send('A_YYYY',[value]);}});
Object.defineProperty(window,'Clipboard',{get:function(){return Exo.send('Clipboard');}, set:function(value){Exo.send('Clipboard',[value]);}});
Object.defineProperty(window,'ClipboardAll',{get:function(){return Exo.send('ClipboardAll');}, set:function(value){Exo.send('ClipboardAll',[value]);}});
Object.defineProperty(window,'ComSpec',{get:function(){return Exo.send('ComSpec');}, set:function(value){Exo.send('ComSpec',[value]);}});
Object.defineProperty(window,'ErrorLevel',{get:function(){return Exo.send('ErrorLevel');}, set:function(value){Exo.send('ErrorLevel',[value]);}});
Object.defineProperty(window,'Parameters',{get:function(){return Exo.send('Parameters');}, set:function(value){Exo.send('Parameters',[value]);}});
Object.defineProperty(window,'ProgramFiles',{get:function(){return Exo.send('ProgramFiles');}, set:function(value){Exo.send('ProgramFiles',[value]);}});
function Abs(){return Exo.send('Abs',arguments)};
function ACos(){return Exo.send('ACos',arguments)};
function Asc(){return Exo.send('Asc',arguments)};
function ASin(){return Exo.send('ASin',arguments)};
function ATan(){return Exo.send('ATan',arguments)};
function BlockInput(){return Exo.send('BlockInput',arguments)};
function Ceil(){return Exo.send('Ceil',arguments)};
function Chr(){return Exo.send('Chr',arguments)};
function Click(){return Exo.send('Click',arguments)};
function ClipWait(){return Exo.send('ClipWait',arguments)};
function Control(){return Exo.send('Control',arguments)};
function ControlClick(){return Exo.send('ControlClick',arguments)};
function ControlFocus(){return Exo.send('ControlFocus',arguments)};
function ControlGet(){return Exo.send('ControlGet',arguments)};
function ControlGetFocus(){return Exo.send('ControlGetFocus',arguments)};
function ControlGetPos(){return Exo.send('ControlGetPos',arguments)};
function ControlGetText(){return Exo.send('ControlGetText',arguments)};
function ControlMove(){return Exo.send('ControlMove',arguments)};
function ControlSend(){return Exo.send('ControlSend',arguments)};
function ControlSendRaw(){return Exo.send('ControlSendRaw',arguments)};
function ControlSetText(){return Exo.send('ControlSetText',arguments)};
function CoordMode(){return Exo.send('CoordMode',arguments)};
function Cos(){return Exo.send('Cos',arguments)};
function Critical(){return Exo.send('Critical',arguments)};
function DetectHiddenText(){return Exo.send('DetectHiddenText',arguments)};
function DetectHiddenWindows(){return Exo.send('DetectHiddenWindows',arguments)};
function DllCall(){return Exo.send('DllCall',arguments)};
function Drive(){return Exo.send('Drive',arguments)};
function DriveGet(){return Exo.send('DriveGet',arguments)};
function DriveSpaceFree(){return Exo.send('DriveSpaceFree',arguments)};
function EnvGet(){return Exo.send('EnvGet',arguments)};
function EnvSet(){return Exo.send('EnvSet',arguments)};
function EnvUpdate(){return Exo.send('EnvUpdate',arguments)};
function ExitApp(){return Exo.send('ExitApp',arguments)};
function Exp(){return Exo.send('Exp',arguments)};
function FileAppend(){return Exo.send('FileAppend',arguments)};
function FileCopy(){return Exo.send('FileCopy',arguments)};
function FileCopyDir(){return Exo.send('FileCopyDir',arguments)};
function FileCreateDir(){return Exo.send('FileCreateDir',arguments)};
function FileCreateShortcut(){return Exo.send('FileCreateShortcut',arguments)};
function FileDelete(){return Exo.send('FileDelete',arguments)};
function FileEncoding(){return Exo.send('FileEncoding',arguments)};
function FileExist(){return Exo.send('FileExist',arguments)};
function FileGetAttrib(){return Exo.send('FileGetAttrib',arguments)};
function FileGetShortcut(){return Exo.send('FileGetShortcut',arguments)};
function FileGetSize(){return Exo.send('FileGetSize',arguments)};
function FileGetTime(){return Exo.send('FileGetTime',arguments)};
function FileGetVersion(){return Exo.send('FileGetVersion',arguments)};
function FileMove(){return Exo.send('FileMove',arguments)};
function FileMoveDir(){return Exo.send('FileMoveDir',arguments)};
function FileRead(){return Exo.send('FileRead',arguments)};
function FileReadLine(){return Exo.send('FileReadLine',arguments)};
function FileRecycle(){return Exo.send('FileRecycle',arguments)};
function FileRecycleEmpty(){return Exo.send('FileRecycleEmpty',arguments)};
function FileRemoveDir(){return Exo.send('FileRemoveDir',arguments)};
function FileSelectFile(){return Exo.send('FileSelectFile',arguments)};
function FileSelectFolder(){return Exo.send('FileSelectFolder',arguments)};
function FileSetAttrib(){return Exo.send('FileSetAttrib',arguments)};
function FileSetTime(){return Exo.send('FileSetTime',arguments)};
function Floor(){return Exo.send('Floor',arguments)};
function FormatTime(){return Exo.send('FormatTime',arguments)};
function GetKeyName(){return Exo.send('GetKeyName',arguments)};
function GetKeySC(){return Exo.send('GetKeySC',arguments)};
function GetKeyState(){return Exo.send('GetKeyState',arguments)};
function GetKeyVK(){return Exo.send('GetKeyVK',arguments)};
function GroupActivate(){return Exo.send('GroupActivate',arguments)};
function GroupAdd(){return Exo.send('GroupAdd',arguments)};
function GroupClose(){return Exo.send('GroupClose',arguments)};
function GroupDeactivate(){return Exo.send('GroupDeactivate',arguments)};
function Gui(){return Exo.send('Gui',arguments)};
function GuiControl(){return Exo.send('GuiControl',arguments)};
function GuiControlGet(){return Exo.send('GuiControlGet',arguments)};
function Hotkey(){return Exo.send('Hotkey',arguments)};
function IL_Add(){return Exo.send('IL_Add',arguments)};
function IL_Create(){return Exo.send('IL_Create',arguments)};
function IL_Destroy(){return Exo.send('IL_Destroy',arguments)};
function ImageSearch(){return Exo.send('ImageSearch',arguments)};
function Include(){return Exo.send('Include',arguments)};
function IniDelete(){return Exo.send('IniDelete',arguments)};
function IniRead(){return Exo.send('IniRead',arguments)};
function IniWrite(){return Exo.send('IniWrite',arguments)};
function Input(){return Exo.send('Input',arguments)};
function InputBox(){return Exo.send('InputBox',arguments)};
function InStr(){return Exo.send('InStr',arguments)};
function KeyHistory(){return Exo.send('KeyHistory',arguments)};
function KeyWait(){return Exo.send('KeyWait',arguments)};
function ListHotkeys(){return Exo.send('ListHotkeys',arguments)};
function Ln(){return Exo.send('Ln',arguments)};
function Log(){return Exo.send('Log',arguments)};
function Loop(){return Exo.send('Loop',arguments)};
function LTrim(){return Exo.send('LTrim',arguments)};
function LV_Add(){return Exo.send('LV_Add',arguments)};
function LV_Delete(){return Exo.send('LV_Delete',arguments)};
function LV_DeleteCol(){return Exo.send('LV_DeleteCol',arguments)};
function LV_GetCount(){return Exo.send('LV_GetCount',arguments)};
function LV_GetNext(){return Exo.send('LV_GetNext',arguments)};
function LV_GetText(){return Exo.send('LV_GetText',arguments)};
function LV_Insert(){return Exo.send('LV_Insert',arguments)};
function LV_InsertCol(){return Exo.send('LV_InsertCol',arguments)};
function LV_Modify(){return Exo.send('LV_Modify',arguments)};
function LV_ModifyCol(){return Exo.send('LV_ModifyCol',arguments)};
function LV_SetImageList(){return Exo.send('LV_SetImageList',arguments)};
function Menu(){return Exo.send('Menu',arguments)};
function Mod(){return Exo.send('Mod',arguments)};
function MouseClick(){return Exo.send('MouseClick',arguments)};
function MouseClickDrag(){return Exo.send('MouseClickDrag',arguments)};
function MouseGetPos(){return Exo.send('MouseGetPos',arguments)};
function MouseMove(){return Exo.send('MouseMove',arguments)};
function MsgBox(){return Exo.send('MsgBox',arguments)};
function OnClipboardChange(){return Exo.send('OnClipboardChange',arguments)};
function OnExit(){return Exo.send('OnExit',arguments)};
function OnMessage(){return Exo.send('OnMessage',arguments)};
function OutputDebug(){return Exo.send('OutputDebug',arguments)};
function Pause(){return Exo.send('Pause',arguments)};
function PixelGetColor(){return Exo.send('PixelGetColor',arguments)};
function PixelSearch(){return Exo.send('PixelSearch',arguments)};
function PostMessage(){return Exo.send('PostMessage',arguments)};
function Process(){return Exo.send('Process',arguments)};
function Progress(){return Exo.send('Progress',arguments)};
function Random(){return Exo.send('Random',arguments)};
function RegDelete(){return Exo.send('RegDelete',arguments)};
function RegExMatch(){return Exo.send('RegExMatch',arguments)};
function RegExReplace(){return Exo.send('RegExReplace',arguments)};
function RegRead(){return Exo.send('RegRead',arguments)};
function RegWrite(){return Exo.send('RegWrite',arguments)};
function Reload(){return Exo.send('Reload',arguments)};
function Round(){return Exo.send('Round',arguments)};
function RTrim(){return Exo.send('RTrim',arguments)};
function Run(){return Exo.send('Run',arguments)};
function RunAs(){return Exo.send('RunAs',arguments)};
function RunWait(){return Exo.send('RunWait',arguments)};
function SB_SetIcon(){return Exo.send('SB_SetIcon',arguments)};
function SB_SetParts(){return Exo.send('SB_SetParts',arguments)};
function SB_SetText(){return Exo.send('SB_SetText',arguments)};
function Send(){return Exo.send('Send',arguments)};
function SendEvent(){return Exo.send('SendEvent',arguments)};
function SendInput(){return Exo.send('SendInput',arguments)};
function SendLevel(){return Exo.send('SendLevel',arguments)};
function SendMessage(){return Exo.send('SendMessage',arguments)};
function SendMode(){return Exo.send('SendMode',arguments)};
function SendPlay(){return Exo.send('SendPlay',arguments)};
function SendRaw(){return Exo.send('SendRaw',arguments)};
function SetBatchLines(){return Exo.send('SetBatchLines',arguments)};
function SetCapslockState(){return Exo.send('SetCapslockState',arguments)};
function SetControlDelay(){return Exo.send('SetControlDelay',arguments)};
function SetDefaultMouseSpeed(){return Exo.send('SetDefaultMouseSpeed',arguments)};
function SetFormat(){return Exo.send('SetFormat',arguments)};
function SetKeyDelay(){return Exo.send('SetKeyDelay',arguments)};
function SetMouseDelay(){return Exo.send('SetMouseDelay',arguments)};
function SetNumLockState(){return Exo.send('SetNumLockState',arguments)};
function SetRegView(){return Exo.send('SetRegView',arguments)};
function SetScrollLockState(){return Exo.send('SetScrollLockState',arguments)};
function SetStoreCapslockMode(){return Exo.send('SetStoreCapslockMode',arguments)};
function SetTimer(){return Exo.send('SetTimer',arguments)};
function SetTitleMatchMode(){return Exo.send('SetTitleMatchMode',arguments)};
function SetWinDelay(){return Exo.send('SetWinDelay',arguments)};
function SetWorkingDir(){return Exo.send('SetWorkingDir',arguments)};
function Shutdown(){return Exo.send('Shutdown',arguments)};
function Sin(){return Exo.send('Sin',arguments)};
function Sleep(){return Exo.send('Sleep',arguments)};
function Sort(){return Exo.send('Sort',arguments)};
function SoundBeep(){return Exo.send('SoundBeep',arguments)};
function SoundGet(){return Exo.send('SoundGet',arguments)};
function SoundGetWaveVolume(){return Exo.send('SoundGetWaveVolume',arguments)};
function SoundPlay(){return Exo.send('SoundPlay',arguments)};
function SoundSet(){return Exo.send('SoundSet',arguments)};
function SoundSetWaveVolume(){return Exo.send('SoundSetWaveVolume',arguments)};
function SplashImage(){return Exo.send('SplashImage',arguments)};
function SplashTextOff(){return Exo.send('SplashTextOff',arguments)};
function SplashTextOn(){return Exo.send('SplashTextOn',arguments)};
function SplitPath(){return Exo.send('SplitPath',arguments)};
function Sqrt(){return Exo.send('Sqrt',arguments)};
function StatusBarGetText(){return Exo.send('StatusBarGetText',arguments)};
function StatusBarWait(){return Exo.send('StatusBarWait',arguments)};
function StrGet(){return Exo.send('StrGet',arguments)};
function StringCaseSense(){return Exo.send('StringCaseSense',arguments)};
function StringGetPos(){return Exo.send('StringGetPos',arguments)};
function StringLeft(){return Exo.send('StringLeft',arguments)};
function StringLen(){return Exo.send('StringLen',arguments)};
function StringLower(){return Exo.send('StringLower',arguments)};
function StringMid(){return Exo.send('StringMid',arguments)};
function StringReplace(){return Exo.send('StringReplace',arguments)};
function StringRight(){return Exo.send('StringRight',arguments)};
function StringTrimLeft(){return Exo.send('StringTrimLeft',arguments)};
function StringTrimRight(){return Exo.send('StringTrimRight',arguments)};
function StringUpper(){return Exo.send('StringUpper',arguments)};
function StrLen(){return Exo.send('StrLen',arguments)};
function StrPut(){return Exo.send('StrPut',arguments)};
function StrSplit(){return Exo.send('StrSplit',arguments)};
function SubStr(){return Exo.send('SubStr',arguments)};
function Suspend(){return Exo.send('Suspend',arguments)};
function SysGet(){return Exo.send('SysGet',arguments)};
function Tan(){return Exo.send('Tan',arguments)};
function Thread(){return Exo.send('Thread',arguments)};
function ToolTip(){return Exo.send('ToolTip',arguments)};
function Transform(){return Exo.send('Transform',arguments)};
function TrayTip(){return Exo.send('TrayTip',arguments)};
function Trim(){return Exo.send('Trim',arguments)};
function TV_Add(){return Exo.send('TV_Add',arguments)};
function TV_Delete(){return Exo.send('TV_Delete',arguments)};
function TV_Get(){return Exo.send('TV_Get',arguments)};
function TV_GetChild(){return Exo.send('TV_GetChild',arguments)};
function TV_GetCount(){return Exo.send('TV_GetCount',arguments)};
function TV_GetNext(){return Exo.send('TV_GetNext',arguments)};
function TV_GetParent(){return Exo.send('TV_GetParent',arguments)};
function TV_GetPrev(){return Exo.send('TV_GetPrev',arguments)};
function TV_GetSelection(){return Exo.send('TV_GetSelection',arguments)};
function TV_GetText(){return Exo.send('TV_GetText',arguments)};
function TV_Modify(){return Exo.send('TV_Modify',arguments)};
function TV_SetImageList(){return Exo.send('TV_SetImageList',arguments)};
function UrlDownloadToFile(){return Exo.send('UrlDownloadToFile',arguments)};
function WinActivate(){return Exo.send('WinActivate',arguments)};
function WinActivateBottom(){return Exo.send('WinActivateBottom',arguments)};
function WinActive(){return Exo.send('WinActive',arguments)};
function WinClose(){return Exo.send('WinClose',arguments)};
function WinExist(){return Exo.send('WinExist',arguments)};
function WinGet(){return Exo.send('WinGet',arguments)};
function WinGetActiveStats(){return Exo.send('WinGetActiveStats',arguments)};
function WinGetActiveTitle(){return Exo.send('WinGetActiveTitle',arguments)};
function WinGetClass(){return Exo.send('WinGetClass',arguments)};
function WinGetPos(){return Exo.send('WinGetPos',arguments)};
function WinGetText(){return Exo.send('WinGetText',arguments)};
function WinGetTitle(){return Exo.send('WinGetTitle',arguments)};
function WinHide(){return Exo.send('WinHide',arguments)};
function WinKill(){return Exo.send('WinKill',arguments)};
function WinMaximize(){return Exo.send('WinMaximize',arguments)};
function WinMenuSelectItem(){return Exo.send('WinMenuSelectItem',arguments)};
function WinMinimize(){return Exo.send('WinMinimize',arguments)};
function WinMinimizeAll(){return Exo.send('WinMinimizeAll',arguments)};
function WinMinimizeAllUndo(){return Exo.send('WinMinimizeAllUndo',arguments)};
function WinMove(){return Exo.send('WinMove',arguments)};
function WinRestore(){return Exo.send('WinRestore',arguments)};
function WinSet(){return Exo.send('WinSet',arguments)};
function WinSetTitle(){return Exo.send('WinSetTitle',arguments)};
function WinShow(){return Exo.send('WinShow',arguments)};
function WinWait(){return Exo.send('WinWait',arguments)};
function WinWaitActive(){return Exo.send('WinWaitActive',arguments)};
function WinWaitClose(){return Exo.send('WinWaitClose',arguments)};
function WinWaitNotActive(){return Exo.send('WinWaitNotActive',arguments)};