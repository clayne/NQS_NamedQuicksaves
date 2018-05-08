ScriptName NQS_NamedQuicksaves_Main Extends ReferenceAlias


Import NQS_NamedQuicksaves_Utility


GlobalVariable Property _NQS_ManualSaveKey Auto
GlobalVariable Property _NQS_CyclicSaveKey Auto
GlobalVariable Property _NQS_CyclicMaxSaves Auto
GlobalVariable Property _NQS_CyclicSaveIndex Auto
GlobalVariable Property _NQS_IntervalActive Auto
GlobalVariable Property _NQS_IntervalDuration Auto
GlobalVariable Property _NQS_IntervalMaxSaves Auto
GlobalVariable Property _NQS_IntervalSaveIndex Auto


Event OnInit()
	UnregisterForAllKeys()
	UnregisterForUpdate()
	_NQS_ManualSaveKey.SetValue(-1)
	_NQS_CyclicSaveKey.SetValue(-1)
	_NQS_CyclicMaxSaves.SetValue(10)
	_NQS_CyclicSaveIndex.SetValue(1)
	_NQS_IntervalActive.SetValue(0)
	_NQS_IntervalDuration.SetValue(30.0)
	_NQS_IntervalMaxSaves.SetValue(10)
	_NQS_IntervalSaveIndex.SetValue(1)
EndEvent


Event OnKeyDown(Int a_keyCode)
	If (a_keyCode == _NQS_ManualSaveKey.GetValue() As Int)
		Game.RequestSave()
	ElseIf (a_keyCode == _NQS_CyclicSaveKey.GetValue() As Int)
		NQS_MakeSave(_NQS_CyclicMaxSaves, _NQS_CyclicSaveIndex, "Cyclic")
	EndIf
EndEvent


Event OnUpdate()
	NQS_MakeSave(_NQS_IntervalMaxSaves, _NQS_IntervalSaveIndex, "Interval")
	RegisterForSingleUpdate(_NQS_IntervalDuration.GetValue() As Float)
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
; a_globalVar - The GlobalVariable to reset.
Function NQS_Reset(GlobalVariable a_globalVar)
	If (a_globalVar == _NQS_ManualSaveKey)
		NQS_UnregisterOldKey(_NQS_ManualSaveKey.GetValue() As Int)
		_NQS_ManualSaveKey.SetValue(-1)
	ElseIf (a_globalVar == _NQS_CyclicSaveKey)
		NQS_UnregisterOldKey(_NQS_CyclicSaveKey.GetValue() As Int)
		_NQS_CyclicSaveKey.SetValue(-1)
	ElseIf (a_globalVar == _NQS_CyclicMaxSaves)
		_NQS_CyclicMaxSaves.SetValue(10)
	ElseIf (a_globalVar == _NQS_CyclicSaveIndex)
		_NQS_CyclicSaveIndex.SetValue(1)
	ElseIf (a_globalVar == _NQS_IntervalActive)
		_NQS_IntervalActive.SetValue(0)
	ElseIf (a_globalVar == _NQS_IntervalDuration)
		_NQS_IntervalDuration.SetValue(30.0)
	ElseIf (a_globalVar == _NQS_IntervalMaxSaves)
		_NQS_IntervalMaxSaves.SetValue(10)
	ElseIf (a_globalVar == _NQS_IntervalSaveIndex)
		_NQS_IntervalSaveIndex.SetValue(1)
	EndIf
EndFunction


; Emulates the game's save format and makes a save.
; a_maxSaves - The max allowed saves for this savetype.
; a_saveIndex - The index the current savetype is at (resets when it exceeds a_maxSaves).
; a_type - The type of the save to be made.
Function NQS_MakeSave(GlobalVariable a_maxSaves, GlobalVariable a_saveIndex, String a_type)
	If ((a_saveIndex.GetValue() As Int) > (a_maxSaves.GetValue() As Int))
		NQS_Reset(a_saveIndex)
	EndIf
	String playerName = Game.GetPlayer().GetActorBase().GetName()
	String hexName = StringToHex(playerName)
	Game.SaveGame("Save" + Math.Floor(a_saveIndex.GetValue() As Int) + "_"+ getPlayerHash() + "_0_" + hexName + "_NQS" + a_type + "_000000_00000000000000_1_1")
	a_saveIndex.SetValue((a_saveIndex.GetValue() As Int) + 1)
	Debug.Notification("Saving...")
EndFunction


; Toggles interval save on/off
Function NQS_IntervalToggle()
	If ((_NQS_IntervalActive.GetValue() As Int) != 0)
		_NQS_IntervalActive.SetValue(0)
	Else
		_NQS_IntervalActive.SetValue(1)
	EndIf
	If (_NQS_IntervalActive.GetValue() As Bool)
		RegisterForSingleUpdate(_NQS_IntervalDuration.GetValue() As Float)
	Else
		UnregisterForUpdate()
	EndIf
EndFunction