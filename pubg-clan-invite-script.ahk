#Requires AutoHotkey v2.0

running := false

invitePercentX := 0
invitePercentY := 0

inputPercentX := 0
inputPercentY := 0

; =============================
; СОХРАНИТЬ КНОПКУ INVITE
; =============================

F8:: {

global invitePercentX, invitePercentY

MouseGetPos &mouseX, &mouseY
WinGetPos &winX, &winY, &winW, &winH, "PUBG"

relX := mouseX - winX
relY := mouseY - winY

invitePercentX := relX / winW
invitePercentY := relY / winH

MsgBox "Кнопка Invite сохранена"

}

; =============================
; СОХРАНИТЬ ПОЛЕ ВВОДА
; =============================

F9:: {

global inputPercentX, inputPercentY

MouseGetPos &mouseX, &mouseY
WinGetPos &winX, &winY, &winW, &winH, "PUBG"

relX := mouseX - winX
relY := mouseY - winY

inputPercentX := relX / winW
inputPercentY := relY / winH

MsgBox "Поле ввода сохранено"

}

; =============================
; ЗАПУСК
; =============================

F6:: {

global running
global invitePercentX, invitePercentY
global inputPercentX, inputPercentY

if (invitePercentX = 0 or inputPercentX = 0) {
    MsgBox "Сначала нажми F8 (Invite) и F9 (поле ввода)"
    return
}

running := true

Loop Read "nicks.txt"
{

    if (!running)
        break

    nick := Trim(A_LoopReadLine)
    if (nick = "")
        continue

    WinActivate "PUBG"
    Sleep 300

    WinGetPos &x, &y, &w, &h, "PUBG"

    inputX := x + w * inputPercentX
    inputY := y + h * inputPercentY

    inviteX := x + w * invitePercentX
    inviteY := y + h * invitePercentY

    ; клик в поле ввода
    Click inputX, inputY
    Sleep 200

    ; очистить поле
    Send "^a"
    Sleep 100
    Send "{Delete}"
    Sleep 200

    ; вставить ник
    A_Clipboard := nick
    Sleep 100
    Send "^v"
    Sleep 200

    ; поиск
    Send "{Enter}"
    Sleep 1500

    ; нажать Invite
    Click inviteX, inviteY
    Sleep 2000
}

MsgBox "Готово"

}

; =============================
; СТОП
; =============================

F7:: {
global running
running := false
}