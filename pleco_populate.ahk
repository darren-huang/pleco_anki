#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include JSON.ahk
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Load saved variables in mouse_positions.ini
mouse_pos_file_path := "mouse_positions.ini"
if FileExist(mouse_pos_file_path) {
    FileRead, mouse_pos_file, % A_ScriptDir "\" mouse_pos_file_path
    mouse_pos_s := JSON.Load(mouse_pos_file)
}
else mouse_pos_s := []

; Variable for the different position names
pos_names := ["Menu", "Settings", "Flashcards", "Default_Tags", "Available_Tags"]

; SetTag(tag) {

; }

SaveMousePos(pos_int) {
    global mouse_pos_s, pos_names
    MouseGetPos, xpos, ypos
    mouse_pos_s[pos_int] := [xpos, ypos]
    MsgBox % pos_int " " . pos_names[pos_int] .  " - store X" xpos ", Y" ypos "!"
}

LoadMousePos(pos_int) {
    global mouse_pos_s, pos_names
    ref := mouse_pos_s[pos_int]
    MsgBox % pos_int " " . pos_names[pos_int] .  " - X" ref[1] ", Y" ref[2] "!"
    MouseMove, ref[1], ref[2]
}

loop, 10 {
    index := Mod(A_Index, 10)
    Hotkey, % "^" index, SaveMousePosLabel
    Hotkey, % "!" index, LoadMousePosLabel
}
return

;; hotkeys
SaveMousePosLabel:
SaveMousePos(SubStr(A_ThisHotkey, 2))
return

LoadMousePosLabel:
LoadMousePos(SubStr(A_ThisHotkey, 2))
return

^`::
mouse_pos_s_string := JSON.Dump(mouse_pos_s)
MsgBox % mouse_pos_s_string
return

^Esc::
MsgBox, 262212, Confirm, % "Reload and Save Vars?"
IfMsgBox, Yes 
{
    mouse_pos_s_string := JSON.Dump(mouse_pos_s)
    FileDelete, % mouse_pos_file_path
    sleep, 600
    ; MsgBox % st_printarr(mouse_pos_s)
    MsgBox % mouse_pos_s_string
    FileAppend, %mouse_pos_s_string%, % mouse_pos_file_path
    Reload
}
Return

!Esc::
MsgBox, 262212, Confirm, % "Reload (vars will NOT be saved)?"
IfMsgBox, Yes 
{
    Reload
}
Return