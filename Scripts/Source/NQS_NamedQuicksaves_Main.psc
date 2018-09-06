ScriptName NQS_NamedQuicksaves_Main Extends Quest


Import NQS_NamedQuicksaves_Utility


GlobalVariable Property _NQS_ManualSaveKey Auto  ; Int
GlobalVariable Property _NQS_CyclicSaveKey Auto  ; Int
GlobalVariable Property _NQS_CyclicLoadKey Auto  ; Int
GlobalVariable Property _NQS_CyclicMaxSaves Auto  ; Int
GlobalVariable Property _NQS_CyclicSaveIndex Auto  ; Int
GlobalVariable Property _NQS_IntervalActive Auto  ; Bool
GlobalVariable Property _NQS_IntervalMaxSaves Auto  ; Int
GlobalVariable Property _NQS_IntervalDuration Auto  ; Float
GlobalVariable Property _NQS_IntervalSaveIndex Auto  ; Int
Actor Property _NQS_PlayerRef Auto


Event OnInit()
	NQS_Reset(_NQS_ManualSaveKey)
	NQS_Reset(_NQS_CyclicSaveKey)
	NQS_Reset(_NQS_CyclicLoadKey)
	NQS_Reset(_NQS_CyclicMaxSaves)
	NQS_Reset(_NQS_CyclicSaveIndex)
	NQS_Reset(_NQS_IntervalActive)
	NQS_Reset(_NQS_IntervalMaxSaves)
	NQS_Reset(_NQS_IntervalDuration)
	NQS_Reset(_NQS_IntervalSaveIndex)
EndEvent


Event OnKeyDown(Int a_keyCode)
	If (a_keyCode == _NQS_ManualSaveKey.GetValue() As Int)
		Game.RequestSave()
	ElseIf (a_keyCode == _NQS_CyclicSaveKey.GetValue() As Int)
		NQS_MakeSave(_NQS_CyclicMaxSaves, _NQS_CyclicSaveIndex, "Cyclic")
	ElseIf (a_keyCode == _NQS_CyclicLoadKey.GetValue() As Int)
		NQS_LoadSave(_NQS_CyclicSaveIndex, "Cyclic")
	EndIf
EndEvent


Event OnUpdate()
	If (_NQS_PlayerRef.GetCombatState() == 0)
		NQS_MakeSave(_NQS_IntervalMaxSaves, _NQS_IntervalSaveIndex, "Interval")
		RegisterForSingleUpdate(_NQS_IntervalDuration.GetValue() As Float * 60.0)
	Else
		RegisterForSingleUpdate(60.0)
	EndIf
EndEvent


; Registers the given keycode.
; a_keyCode - The keycode to register.
Function NQS_RegisterNewKey(Int a_keyCode)
	RegisterForKey(a_keyCode)
EndFunction


; Unregisters the given keycode.
; a_keyCode - The keycode to unregister.
Function NQS_UnregisterOldKey(Int a_keyCode)
	UnregisterForKey(a_keyCode)
EndFunction


; Resets a GlobalVariable to its default value.
; a_globalVar - The variable to reset.
Function NQS_Reset(GlobalVariable a_globalVar)
	If (a_globalVar == _NQS_ManualSaveKey)
		NQS_UnregisterOldKey(_NQS_ManualSaveKey.GetValue() As Int)
		_NQS_ManualSaveKey.SetValue(-1)
	ElseIf (a_globalVar == _NQS_CyclicSaveKey)
		NQS_UnregisterOldKey(_NQS_CyclicSaveKey.GetValue() As Int)
		_NQS_CyclicSaveKey.SetValue(-1)
	ElseIf (a_globalVar == _NQS_CyclicLoadKey)
		NQS_UnregisterOldKey(_NQS_CyclicLoadKey.GetValue() As Int)
		_NQS_CyclicLoadKey.SetValue(-1)
	ElseIf (a_globalVar == _NQS_CyclicMaxSaves)
		_NQS_CyclicMaxSaves.SetValue(10)
	ElseIf (a_globalVar == _NQS_CyclicSaveIndex)
		_NQS_CyclicSaveIndex.SetValue(1)
	ElseIf (a_globalVar == _NQS_IntervalActive)
		_NQS_IntervalActive.SetValue(0)
		UnregisterForUpdate()
	ElseIf (a_globalVar == _NQS_IntervalMaxSaves)
		_NQS_IntervalMaxSaves.SetValue(10)
	ElseIf (a_globalVar == _NQS_IntervalDuration)
		_NQS_IntervalDuration.SetValue(30.0)
	ElseIf (a_globalVar == _NQS_IntervalSaveIndex)
		_NQS_IntervalSaveIndex.SetValue(1)
	EndIf
EndFunction


; Emulates the game's save format and makes a save.
; a_maxSaves - The max allowed saves for this savetype.
; a_saveIndex - The index the current savetype is at (resets when it exceeds a_maxSaves).
; a_type - The type of save to be made.
Function NQS_MakeSave(GlobalVariable a_maxSaves, GlobalVariable a_saveIndex, String a_type)
	If (a_saveIndex.GetValue() As Int > a_maxSaves.GetValue() As Int)
		NQS_Reset(a_saveIndex)
	EndIf
	String playerName = _NQS_PlayerRef.GetActorBase().GetName()
	String hexName = StringToHex(playerName)
	Game.SaveGame("Save" + Math.Floor(a_saveIndex.GetValue() As Float) + "_" + getPlayerHash() + "_0_" + hexName + "_NQS" + a_type + "_000000_00000000000000_1_1")
	a_saveIndex.SetValue(a_saveIndex.GetValue() As Int + 1)
	Debug.Notification("$Saving...")
EndFunction


; Loads the specified save type.
; a_saveIndex - The index the current savetype is at.
; a_type - The type of save to load.
Function NQS_LoadSave(GlobalVariable a_saveIndex, String a_type)
	String playerName = _NQS_PlayerRef.GetActorBase().GetName()
	String hexName = StringToHex(playerName)
	Game.LoadGame("Save" + Math.Floor(a_saveIndex.GetValue() As Float - 1.0) + "_" + getPlayerHash() + "_0_" + hexName + "_NQS" + a_type + "_000000_00000000000000_1_1")
EndFunction


; Toggles variable on/off.
; a_globalVar - The variable to toggle.
Function NQS_Toggle(GlobalVariable a_globalVar)
	If (a_globalVar.GetValue() As Bool)
		NQS_Reset(a_globalVar)
	Else
		a_globalVar.SetValue(1)
		If (a_globalVar == _NQS_IntervalActive)
			RegisterForSingleUpdate(_NQS_IntervalDuration.GetValue() As Float * 60.0)
		EndIf
	EndIf
EndFunction