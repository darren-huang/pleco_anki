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

; file for wordlist
; wordlist_txt := FileOpen("formatted_wordlist.txt", "r", "UTF-8")
wordlist_txt := "formatted_wordlist_4.txt"

; Variable for the different position names
pos_names := ["Menu", "Settings", "Flashcards", "Default_Tags", "Available_Tags", "Clear_Search_Bar", "Add_Flashcard"]


SetTag(tag) {
    global mouse_pos_s
    wait_time := 750
    scroll_wait := 300
    key_press_delay := 100
    key_hold := 50

    MouseMove, mouse_pos_s[1][1], mouse_pos_s[1][2] ; menu pos
    MouseClick, Left ; menu click
    sleep, wait_time

    MouseMove, mouse_pos_s[2][1], mouse_pos_s[2][2] ; setting pos

    Loop, 5 { ; scroll up menu
        MouseClick, WheelUp
        Sleep, scroll_wait
    }
    Sleep, wait_time

    MouseClick, Left ; settings click
    sleep, wait_time

    Loop, 10 { ; scroll down settings
        MouseClick, WheelDown
        Sleep, scroll_wait
    }
    Sleep, wait_time

    MouseMove, mouse_pos_s[3][1], mouse_pos_s[3][2] ; flashcard pos
    MouseClick, Left ; flashcard click
    Sleep, wait_time

    Loop, 10 { ; scroll down settings
        MouseClick, WheelDown
        Sleep, scroll_wait
    }
    Sleep, wait_time

    MouseMove, mouse_pos_s[4][1], mouse_pos_s[4][2] ; default tag pos
    MouseClick, Left
    Sleep, wait_time

    SetKeyDelay, key_press_delay, key_hold
    SendEvent {Down}{Enter}{Down}{Right}{Enter}
    Sleep, wait_time

    MouseMove, mouse_pos_s[5][1], mouse_pos_s[5][2] ; available tag pos
    MouseClick, Left
    Sleep, wait_time

    SendEvent ^a ; ctrl A
    Sleep, wait_time
    Send % tag ; enter tag 
    Sleep, wait_time
    SendEvent {Down}{Right}{Enter} ; select
    Sleep, % wait_time

    MouseMove, mouse_pos_s[4][1], mouse_pos_s[4][2] ; default tag pos
    Sleep, wait_time
    MouseClick, Left
    Sleep, wait_time

    SendEvent {Down}{Enter}{Down}{Right}{Enter}{Esc}{Esc}
}

CreateFlashcard(word){
    global mouse_pos_s

    MouseMove, mouse_pos_s[6][1], mouse_pos_s[6][2] ; clear search bar
    MouseClick, Left
    Sleep, 750

    Send % "{Raw}" word
    Sleep, 750

    MouseMove, mouse_pos_s[7][1], mouse_pos_s[7][2] ; add flashcard
    MouseClick, Left
    Sleep, 750

    MouseMove, mouse_pos_s[8][1], mouse_pos_s[8][2] ; close menu if necessary
    MouseClick, Left
    Sleep, 750

}

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

F1::
SetTag("test_f1 fake-tag")
return

F2::
FileEncoding, UTF-8
Loop, read, % wordlist_txt 
{
    if InStr(A_LoopReadLine, "hsk_level") {
        SetTag(A_LoopReadLine)
    } else {
        CreateFlashcard(A_LoopReadLine)
    }
}
return

F3::
Send % "{Raw}枢纽"
return

F4::
word := "枢纽枢纽枢纽枢纽枢纽"
CreateFlashcard(word)
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