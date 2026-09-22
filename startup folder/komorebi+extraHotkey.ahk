#Requires AutoHotkey v2.0
#SingleInstance Force

scriptModTime := FileGetTime(A_ScriptFullPath, "M")
SetTimer CheckForScriptChanges, 250

CheckForScriptChanges() {
    global scriptModTime

    currentModTime := FileGetTime(A_ScriptFullPath, "M")

    if (currentModTime != scriptModTime) {
        scriptModTime := currentModTime
        Reload()
    }
}
zenWasActive := false

SetTimer CheckZen, 100

CheckZen() {
    global zenWasActive

    zenActive := WinActive("ahk_exe zen.exe")

    if (zenActive && !zenWasActive) {
        roblox := WinExist("ahk_exe RobloxPlayerBeta.exe")

        if roblox {
            PostMessage(0x112, 0xF020, 0, , roblox)
        }
    }

    zenWasActive := zenActive
}

WorkspaceNumber := 9

ArrayFromZero(Length){
  temp := []
  Loop Length {
    temp.Push(A_Index-1)
  }
  return temp
}

; Set workspaces (start from 0)
; ArrayFromZero(9) => [0,1,2,3,4,5,6,7,8]
global numbers := ArrayFromZero(WorkspaceNumber)

init(){
  ;; focus-follows-mouse feels buggy
  Run "komorebic focus-follows-mouse disable", ,"Hide"

  ;; From
  ;; https://github.com/LGUG2Z/komorebi/blob/master/komorebi.sample.ahk

  ; Always float IntelliJ popups, matching on class
  Run "komorebic float-rule class SunAwtDialog", , "Hide"

  ; Always float Control Panel, matching on title
  Run "komorebic float-rule title 'Control Panel'", , "Hide"

  ; Always float Task Manager, matching on class
  Run "komorebic float-rule class TaskManagerWindow", , "Hide"

  ; Always float Wally, matching on executable name
  Run "komorebic float-rule exe Wally.exe", , "Hide"

  Run "komorebic float-rule exe wincompose.exe", , "Hide"

  ; Always float Calculator app, matching on window title
  Run "komorebic float-rule title Calculator", , "Hide"

  Run "komorebic float-rule exe 1Password.exe", , "Hide"

  ;; For BandZip annoying updater
  Run "komorebic float-rule exe Updater.exe", , "Hide"

  Run "komorebic float-rule exe ScreenToGif.exe", , "Hide"

  ;; No tiling for Settings
  Run "komorebic float-rule title Settings", , "Hide"

  Run "komorebic identify-tray-application exe Discord.exe", , "Hide"

  Run "komorebic identify-tray-application exe Telegram.exe", , "Hide"

  Run "komorebic identify-tray-application exe cloudmusic.exe", , "Hide"

  Run "komorebic identify-tray-application exe everything.exe", , "Hide"

  Run "komorebic identify-tray-application exe GoldenDict.exe", , "Hide"

  Run "komorebic identify-tray-application exe 'Clash for Windows.exe'", , "Hide"

  ;; Fix for the infamous TIM
  Run "komorebic identify-tray-application exe TIM.exe", , "Hide"

  Run "komorebic float-rule title TXMenuWindow", , "Hide"

  Run "komorebic manage-rule class TXGuiFoundation", , "Hide"

  ;; Infamous WeChat from Microsoft Store
  Run "komorebic identify-tray-application exe WeChatStore.exe", , "Hide"

  Run "komorebic manage-rule exe WeChatStore.exe", , "Hide"

  Run "komorebic float-rule class SetMenuWnd", , "Hide"

  Run "komorebic float-rule class CefWebViewWnd", , "Hide"

  ;; IDM can't be handled properly
  ;; I don't like it tiling anyway. So I just comment it
  ;; Run("komorebic manage-rule exe IDMan.exe",,"Hide")

  Run "komorebic ensure-workspaces 0 " . WorkspaceNumber, , "Hide"

  ; Set the padding to all the workspaces
  for num in numbers {
    RunWait("komorebic workspace-padding 8 " . num . " 8", , "Hide")
    RunWait("komorebic container-padding -2 " . num . " -2", , "Hide")
  }
}

;; Run init function at start
init()


; ============================================================
; WINDOW FOCUS
; ============================================================

; Alt + Left = focus left
!left::{
  Run "komorebic focus left", , "Hide"
}

; Alt + Down = focus down
!down::{
  Run "komorebic focus down", , "Hide"
}

; Alt + Up = focus up
!up::{
  Run "komorebic focus up", , "Hide"
}

; Alt + Right = focus right
!right::{
  Run "komorebic focus right", , "Hide"
}


; ============================================================
; MOVE WINDOWS
; ============================================================

; Alt + 1 = move window left
!1::{
  Run "komorebic move left", , "Hide"
}

; Alt + 2 = move window up
!2::{
  Run "komorebic move up", , "Hide"
}

; Alt + 3 = move window right
!3::{
  Run "komorebic move right", , "Hide"
}

; Alt + 4 = move window down
!4::{
  Run "komorebic move down", , "Hide"
}


; ============================================================
; MOVE WINDOW WITH ALT + SHIFT + ARROWS
; ============================================================

!+left::{
  Run "komorebic move left", , "Hide"
}

!+down::{
  Run "komorebic move down", , "Hide"
}

!+up::{
  Run "komorebic move up", , "Hide"
}

!+right::{
  Run "komorebic move right", , "Hide"
}


; ============================================================
; PROMOTE
; ============================================================

; Alt + Shift + Enter
!+Enter::{
  Run "komorebic promote", , "Hide"
}


; ============================================================
; LAYOUTS
; ============================================================

; Alt + Shift + R = rows
!+r::{
  Run "komorebic change-layout rows", , "Hide"
}

; Alt + Shift + C = columns
!+c::{
  Run "komorebic change-layout columns", , "Hide"
}

; Alt + Shift + B = BSP
!+b::{
  Run "komorebic change-layout bsp", , "Hide"
}


; ============================================================
; MONOCLE / MAXIMIZE
; ============================================================

; Alt + Shift + F = monocle
!+f::{
  Run "komorebic toggle-monocle", , "Hide"
}

; Alt + F = maximize
!f::{
  RunWait("komorebic toggle-maximize", , "Hide")
}


; ============================================================
; FLIP LAYOUT
; ============================================================

; Alt + Shift + X = horizontal flip
!+x::{
  Run "komorebic flip-layout horizontal", , "Hide"
}

; Alt + Shift + Y = vertical flip
!+y::{
  Run "komorebic flip-layout vertical", , "Hide"
}


; ============================================================
; FLOATING / TILING
; ============================================================

; Alt + T = toggle floating
; Floating windows can be resized freely without
; komorebi controlling their dimensions
!t::{
  Run "komorebic toggle-float", , "Hide"
}

; Alt + Shift + T = toggle tiling for workspace
!+t::{
  Run "komorebic toggle-tiling", , "Hide"
}


; ============================================================
; PAUSE KOMOREBI
; ============================================================

; Alt + P = pause / resume komorebi
!p::{
  Run "komorebic toggle-pause", , "Hide"
}


; ============================================================
; FORCE RETILE
; ============================================================

; Ctrl + Shift + R = force retile
^+r::{
  Run "komorebic retile", , "Hide"
}


; ============================================================
; RESIZE AXIS
; ============================================================

; Alt + = = increase horizontal size
!=::{
  Run "komorebic resize-axis horizontal increase", , "Hide"
}

; Alt + - = decrease horizontal size
!-::{
  Run "komorebic resize-axis horizontal decrease", , "Hide"
}

; Ctrl + Alt + = = increase vertical size
!^=::{
  Run "komorebic resize-axis vertical increase", , "Hide"
}

; Ctrl + Alt + - = decrease vertical size
!^-::{
  Run "komorebic resize-axis vertical decrease", , "Hide"
}


; ============================================================
; CLOSE WINDOW
; ============================================================

; Alt + Q = close focused window
!q::{
  WinClose("A")
}


; ============================================================
; RESTART KOMOREBI
; ============================================================

; Alt + Shift + Q
!+q::{
  RunWait("komorebic restore-windows", , "Hide")

  RunWait("powershell " . "Stop-Process -Name 'komorebi'", , "Hide")

  RunWait("komorebic start")

  Sleep(1000)

  init()
}


; ============================================================
; GET WINDOW INFO
; ============================================================

; Alt + Shift + M
!+m::{
  window_id := ""

  MouseGetPos(,,&window_id)

  window_title := WinGetTitle(window_id)

  window_class := WinGetClass(window_id)

  MsgBox(window_id "`n" window_class "`n" window_title)
}


; ============================================================
; MINIMIZE / RESTORE
; ============================================================

global minimized_window := ""

; Windows that should not be minimized by Alt + M
global FilterOutClass := [
  "WorkerW",
  "Shell_TrayWnd",
  "NotifyIconOverflowWindow"
]


; Alt + M = toggle minimize
!m::{
  try {
    ; If there is a window under the cursor then activate it
    window_id := ""

    MouseGetPos(,,&window_id)

    WinActivate(window_id)

    ; Get active window
    active_id := WinGetID("A")

    window_state := WinGetMinMax("A")

    ; Restore previously minimized window
    if (minimized_window != "") {
      WinRestore(minimized_window)

      global minimized_window := ""
    } else {

      ; Don't minimize filtered windows
      for filter in FilterOutClass {
        if (WinGetClass(active_id) == filter) {
          return
        }
      }

      WinMinimize(active_id)

      global minimized_window := active_id
    }

  } catch as e {

    ; If there is an error, focus window under cursor
    window_id := ""

    MouseGetPos(,,&window_id)

    WinActivate(window_id)
  }
}


; ============================================================
; POWERSHELL
; ============================================================

; Win + Z = launch PowerShell 7
#z::{
    Run '"C:\Program Files\WindowsApps\Microsoft.PowerShell_7.6.6.0_x64__8wekyb3d8bbwe\pwsh.exe" -NoLogo -NoProfileLoadTime'
}