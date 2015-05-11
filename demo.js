Hotkey('ESC', function(){ExitApp()});
alert(A_Now);
FileAppend('Hello, World!', 'hello.txt')
var list = Loop('*.txt');
for (var i = 0; i < list.length; i++) {
	var fileProperties = list[i];
	MsgBox(fileProperties.LongPath);
}
Sleep(1000);
ExitApp();