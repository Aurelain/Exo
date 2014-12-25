/**
 * Used only for debugging.
 * Why not use JSON.stringify by Coco and others? Because of several reasons:
 * 1. We want a cleaner look: no quotes, no escapes
 * 2. We want to allow the empty key ("")
 */
trace(s){
	s := _serialize(s,0)
	MsgBox, 262144,,%s% ; Always on top
}
_serialize(obj,indent){
	if (IsObject(obj)) {
		prefix := ""
		Loop,%indent%
		{
			prefix .= "`t"
		}
		out := "`n"
		out .= prefix . "{`n"
		for key, val in obj {
			out .= prefix . "`t" . key . ":" . _serialize(val, indent+1) . "`n"
		}
		out .= prefix . "}"
		return out
	} else {
		return obj
	}
}