ScriptName NQS_NamedQuicksaves_MCM Extends SKI_ConfigBase


GlobalVariable Property _NQS_ManualSaveKey Auto  ; Int
GlobalVariable Property _NQS_CyclicSaveKey Auto  ; Int
GlobalVariable Property _NQS_CyclicLoadKey Auto  ; Int
GlobalVariable Property _NQS_CyclicMaxSaves Auto  ; Int
GlobalVariable Property _NQS_CyclicSaveIndex Auto  ; Int
GlobalVariable Property _NQS_IntervalActive Auto  ; Bool
GlobalVariable Property _NQS_IntervalMaxSaves Auto  ; Int
GlobalVariable Property _NQS_IntervalDuration Auto  ; Float
GlobalVariable Property _NQS_IntervalSaveIndex Auto  ; Int
NQS_NamedQuicksaves_Main Property _RemoteMain Auto


; Called when the config menu is initialized.
Event OnConfigInit()
	ModName = "$NQS_ModName"
	pages = New String[1]
	pages[0] = "$NQS_pages0"
EndEvent


; Called when the config menu is closed.
Event OnConfigClose()
EndEvent


; Called when a version update of this script has been detected.
; a_version - The new version.
Event OnVersionUpdate(Int a_version)
EndEvent


; Called when a new page is selected, including the initial empty page.
; a_page - The name of the the current page, or "" if no page is selected.
Event OnPageReset(String a_page)
	If (a_page == "$NQS_pages0")
		SetCursorFillMode(LEFT_TO_RIGHT)
		
		AddHeaderOption("$NQS_HeaderOption_Manual")
		AddHeaderOption("")
		AddKeyMapOptionST("ManualSaveKey_K", "$NQS_KeyMapOption_ManualSaveKey", _NQS_ManualSaveKey.GetValue() As Int)
		AddEmptyOption()

		AddHeaderOption("$NQS_HeaderOption_Cyclic")
		AddHeaderOption("")
		AddKeyMapOptionST("CyclicSaveKey_K", "$NQS_KeyMapOption_CyclicSaveKey", _NQS_CyclicSaveKey.GetValue() As Int)
		AddSliderOptionST("CyclicMaxSaves_S", "$NQS_SliderOption_CyclicMaxSaves", _NQS_CyclicMaxSaves.GetValue() As Float)
		AddKeyMapOptionST("CyclicLoadKey_K", "$NQS_KeyMapOption_CyclicLoadKey", _NQS_CyclicLoadKey.GetValue() As Int)
		AddEmptyOption()
		
		AddHeaderOption("$NQS_HeaderOption_Interval")
		AddHeaderOption("")
		AddToggleOptionST("IntervalActive_B", "$NQS_ToggleOption_IntervalActive", _NQS_IntervalActive.GetValue() As Bool)
		AddSliderOptionST("IntervalMaxSaves_S", "$NQS_SliderOption_IntervalMaxSaves", _NQS_IntervalMaxSaves.GetValue() As Float)
		AddEmptyOption()
		AddSliderOptionST("IntervalDuration_S", "$NQS_SliderOption_IntervalDuration", _NQS_IntervalDuration.GetValue() As Float)
	EndIf
EndEvent


; Manual Save Key
State ManualSaveKey_K
	Event OnKeyMapChangeST(Int a_newKeyCode, String a_conflictControl, String a_conflictName)
		If (KeyConflict(a_conflictControl, a_conflictName))
			_RemoteMain.NQS_UnregisterOldKey(_NQS_ManualSaveKey.GetValue() As Int)
			_NQS_ManualSaveKey.SetValue(a_newKeyCode)
			_RemoteMain.NQS_RegisterNewKey(a_newKeyCode)
			SetKeymapOptionValueST(a_newKeyCode)
		EndIf
	EndEvent

	Event OnDefaultST()
		_RemoteMain.NQS_Reset(_NQS_ManualSaveKey)
		SetKeymapOptionValueST(_NQS_ManualSaveKey.GetValue() As Int)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$NQS_InfoText_ManualSaveKey")
	EndEvent
EndState


; Cyclic Save Key
State CyclicSaveKey_K
	Event OnKeyMapChangeST(Int a_newKeyCode, String a_conflictControl, String a_conflictName)
		If (KeyConflict(a_conflictControl, a_conflictName))
			_RemoteMain.NQS_UnregisterOldKey(_NQS_CyclicSaveKey.GetValue() As Int)
			_NQS_CyclicSaveKey.SetValue(a_newKeyCode)
			_RemoteMain.NQS_RegisterNewKey(a_newKeyCode)
			SetKeymapOptionValueST(a_newKeyCode)
		EndIf
	EndEvent

	Event OnDefaultST()
		_RemoteMain.NQS_Reset(_NQS_CyclicSaveKey)
		SetKeymapOptionValueST(_NQS_CyclicSaveKey.GetValue() As Int)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$NQS_InfoText_CyclicSaveKey")
	EndEvent
EndState


; Cyclic Max Saves
State CyclicMaxSaves_S
	Event OnSliderOpenST()
		SetSliderDialogStartValue(_NQS_CyclicMaxSaves.GetValue() As Float)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float a_value)
		_NQS_CyclicMaxSaves.SetValue(a_value)
		SetSliderOptionValueST(a_value)
	EndEvent

	Event OnDefaultST()
		_RemoteMain.NQS_Reset(_NQS_CyclicMaxSaves)
		SetSliderOptionValueST(_NQS_CyclicMaxSaves.GetValue() As Float)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$NQS_InfoText_CyclicMaxSaves")
	EndEvent
EndState


; Cyclic Load Key
State CyclicLoadKey_K
	Event OnKeyMapChangeST(Int a_newKeyCode, String a_conflictControl, String a_conflictName)
		If (KeyConflict(a_conflictControl, a_conflictName))
			_RemoteMain.NQS_UnregisterOldKey(_NQS_CyclicLoadKey.GetValue() As Int)
			_NQS_CyclicLoadKey.SetValue(a_newKeyCode)
			_RemoteMain.NQS_RegisterNewKey(a_newKeyCode)
			SetKeymapOptionValueST(a_newKeyCode)
		EndIf
	EndEvent

	Event OnDefaultST()
		_RemoteMain.NQS_Reset(_NQS_CyclicLoadKey)
		SetKeymapOptionValueST(_NQS_CyclicLoadKey.GetValue() As Int)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$NQS_InfoText_CyclicLoadKey")
	EndEvent
EndState


; Interval Active
State IntervalActive_B
	Event OnSelectST()
		_RemoteMain.NQS_Toggle(_NQS_IntervalActive)
		SetToggleOptionValueST(_NQS_IntervalActive.GetValue() As Bool)
	EndEvent

	Event OnDefaultST()
		_RemoteMain.NQS_Reset(_NQS_IntervalActive)
		SetToggleOptionValueST(_NQS_IntervalActive.GetValue() As Bool)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$NQS_InfoText_IntervalActive")
	EndEvent
EndState


; Interval Max Saves
State IntervalMaxSaves_S
	Event OnSliderOpenST()
		SetSliderDialogStartValue(_NQS_IntervalMaxSaves.GetValue() As Float)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent

	Event OnSliderAcceptST(Float a_value)
		_NQS_IntervalMaxSaves.SetValue(a_value)
		SetSliderOptionValueST(a_value)
	EndEvent

	Event OnDefaultST()
		_RemoteMain.NQS_Reset(_NQS_IntervalMaxSaves)
		SetSliderOptionValueST(_NQS_IntervalMaxSaves.GetValue() As Float)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$NQS_InfoText_IntervalMaxSaves")
	EndEvent
EndState


; Interval Duration
State IntervalDuration_S
	Event OnSliderOpenST()
		SetSliderDialogStartValue(_NQS_IntervalDuration.GetValue() As Float)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(5.0, 300.0)
		SetSliderDialogInterval(5.0)
	EndEvent

	Event OnSliderAcceptST(Float a_value)
		_NQS_IntervalDuration.SetValue(a_value)
		SetSliderOptionValueST(a_value)
	EndEvent

	Event OnDefaultST()
		_RemoteMain.NQS_Reset(_NQS_IntervalDuration)
		SetSliderOptionValueST(_NQS_IntervalDuration.GetValue() As Float)
	EndEvent

	Event OnHighlightST()
		SetInfoText("$NQS_InfoText_IntervalDuration")
	EndEvent
EndState


; Returns the static version of this script.
; RETURN - The static version of this script.
; History:
; 1 - Initial Release (v1.0.0)
; 2 - Added support for cyclic saving (v.1.2.0)
; 3 - Fixed bug in name to hex conversion (v1.2.1)
Int Function GetVersion()
	Return 3
EndFunction


; Generic dialogue for handling key conflicts.
; a_conflictControl - The conflicting control if the keycode was already in use; "" otherwise.
; a_conflictName - ModName of the conflicting mod; "" if there was no conflict or if conflicting with a vanilla control.
; RETURN - Returns True if no conflict, or the user wishes to proceed anyway. Else returns False.
Bool Function KeyConflict(String a_conflictControl, String a_conflictName)
	If (a_conflictControl != "")
		String msg
		If (a_conflictName != "")
			msg = "$NQS_KeyConflict_Msg1\n'" + a_conflictControl + "'\n(" + a_conflictName + ")\n\n$NQS_KeyConflict_Msg2"
		Else
			msg = "$NQS_KeyConflict_Msg1\n'" + a_conflictControl + "'\n\n$NQS_KeyConflict_Msg2"
		EndIf
		Return ShowMessage(msg, True, "$Yes", "$No")
	EndIf
	Return True
EndFunction