/**
 * Credits: GeekDude
 * URL: http://www.autohotkey.com/board/topic/93660-embedded-ie-shellexplorer-render-issues-fix-force-it-to-use-a-newer-render-engine/
 */ 
FixIE(Apply=True, Version="", ExeName="") {
	static Key := "Software\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BROWSER_EMULATION"
	Versions := {7:7000, 8:8888, 9:9999, 10:10001, 11:11001}
	if !(Version := Versions[Version])
		Version := 0 ; Disable browser emulation
	if !ExeName
	{
		if A_IsCompiled
			ExeName := A_ScriptName
		else
			SplitPath, A_AhkPath, ExeName
	}
	if Apply
		RegWrite, REG_DWORD, HKCU, %Key%, %ExeName%, %Version%
	else
		RegDelete, HKCU, %Key%, %ExeName%
} 