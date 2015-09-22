#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force ; just reload it, dont ask me
 

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; open up unicode charactermap on LEFT-CONTROL + LEFT-SHIFT + F12
<+<^F12::

	Run, %A_windir%\system32\charmap.exe\
 

Return


; for posting reponame to trello 
<+<^F11::
	ClipSaved := Clipboard
	ClipSaved := StrReplace(ClipSaved, "http://", "https://", All)

	IfInString, ClipSaved, https://github.com/
	{
		RepoName := StrReplace(ClipSaved, "https://github.com/", "", All)

		SendInput % "[**["
		SendInput % RepoName
		SendInput % "]**]("
		SendInput % ClipSaved
		SendInput % ")"
	}
Return


; directly send the ent er key via paste
;<+<^F11::
;F11::
;	KeyWait, F11, D T4
;	if ErrorLevel 
;	{
;	Control, EditPaste, f
;	MouseGetPos, xpos, ypos, varwin, varcont
;	ControlGetFocus outputvar, wimtitle, wintext
;	if ErrorLevel
;		MsgBox, nope
;	MsgBox, w %varwin% c %varcont%
;	MsgBox, cont: %outputVar% tit: %wimtitle% wint: %wintext%
;	ControlSend, %varcontrol%, hey
;	SendInput `r`n
;	SoundBeep, 1100, 1000 
;	}
;	else 
;	{
;		SoundBeep, 400, 1000 
;	}
;Return
