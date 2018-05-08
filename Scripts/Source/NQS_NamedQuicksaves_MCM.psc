ScriptName NQS_NamedQuicksaves_MCM Extends SKI_ConfigBase


GlobalVariable Property _NQS_ManualSaveKey Auto
GlobalVariable Property _NQS_CyclicSaveKey Auto
GlobalVariable Property _NQS_CyclicMaxSaves Auto
GlobalVariable Property _NQS_CyclicSaveIndex Auto
GlobalVariable Property _NQS_IntervalActive Auto
GlobalVariable Property _NQS_IntervalDuration Auto
GlobalVariable Property _NQS_IntervalMaxSaves Auto
GlobalVariable Property _NQS_IntervalSaveIndex Auto
NQS_NamedQuicksaves_Main Property _RemoteMain Auto


Int _ManualSaveKey_K
Int _CyclicSaveKey_K
Int _CyclicMaxSaves_S
Int _IntervalActive_B
Int _IntervalDuration_S
Int _IntervalMaxSaves_S


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
		
		AddHeaderOption("$NQS_HeaderOption_1")
		AddHeaderOption("$NQS_HeaderOption_2")
		
		_ManualSaveKey_K = AddKeyMapOption("$NQS_KeyMapOption_ManualSaveKey", _NQS_ManualSaveKey.GetValue() As Int)
		AddEmptyOption()
		
		_CyclicSaveKey_K = AddKeyMapOption("$NQS_KeyMapOption_CyclicSaveKey", _NQS_CyclicSaveKey.GetValue() As Int)
		_CyclicMaxSaves_S = AddSliderOption("$NQS_SliderOption_CyclicMaxSaves", _NQS_CyclicMaxSaves.GetValue() As Int)
		
		AddHeaderOption("$NQS_HeaderOption_3")
		AddEmptyOption()
		_IntervalActive_B = AddToggleOption("$NQS_ToggleOption_IntervalActive", _NQS_IntervalActive.GetValue() As Bool)
		_IntervalDuration_S = AddSliderOption("$NQS_SliderOption_IntervalDuration", _NQS_IntervalDuration.GetValue() As Int)
		AddEmptyOption()
		_IntervalMaxSaves_S = AddSliderOption("$NQS_SliderOption_IntervalMaxSaves", _NQS_IntervalMaxSaves.GetValue() As Int)
	EndIf
EndEvent


; Called when highlighting an option.
; a_option - The option ID.
Event OnOptionHighlight(Int a_option)
	If (a_option == _ManualSaveKey_K)
		SetInfoText("$NQS_InfoText_ManualSaveKey")
	ElseIf (a_option == _CyclicSaveKey_K)
		SetInfoText("$NQS_InfoText_CyclicSaveKey")
	ElseIf (a_option == _CyclicMaxSaves_S)
		SetInfoText("$NQS_InfoText_CyclicMaxSaves")
	ElseIf (a_option == _IntervalActive_B)
		SetInfoText("$NQS_InfoText_IntervalActive")
	ElseIf (a_option == _IntervalDuration_S)
		SetInfoText("$NQS_InfoText_IntervalDuration")
	ElseIf (a_option == _IntervalMaxSaves_S)
		SetInfoText("$NQS_InfoText_IntervalMaxSaves")
	EndIf
EndEvent


; Called when resetting an option to its default value.
; a_option - The option ID.
Event OnOptionDefault(Int a_option)
	If (a_option == _ManualSaveKey_K)
		_RemoteMain.NQS_Reset(_NQS_ManualSaveKey)
		SetKeymapOptionValue(a_option, _NQS_ManualSaveKey.GetValue() As Int)
	ElseIf (a_option == _CyclicSaveKey_K)
		_RemoteMain.NQS_Reset(_NQS_CyclicSaveKey)
		SetKeymapOptionValue(a_option, _NQS_CyclicSaveKey.GetValue() As Int)
	ElseIf (a_option == _CyclicMaxSaves_S)
		_RemoteMain.NQS_Reset(_NQS_CyclicMaxSaves)
		SetSliderOptionValue(a_option, _NQS_CyclicMaxSaves.GetValue() As Int)
	ElseIf (a_option == _IntervalActive_B)
		_RemoteMain.NQS_Reset(_NQS_IntervalActive)
		SetToggleOptionValue(a_option, _NQS_IntervalActive.GetValue() As Bool)
	ElseIf (a_option == _IntervalDuration_S)
		_RemoteMain.NQS_Reset(_NQS_IntervalDuration)
		SetSliderOptionValue(a_option, _NQS_IntervalDuration.GetValue() As Int)
	ElseIf (a_option == _IntervalMaxSaves_S)
		_RemoteMain.NQS_Reset(_NQS_IntervalMaxSaves)
		SetSliderOptionValue(a_option, _NQS_IntervalMaxSaves.GetValue() As Int)
	EndIf
EndEvent


; Called when a non-interactive option has been selected.
; a_option - The option ID.
Event OnOptionSelect(Int a_option)
	If (a_option == _IntervalActive_B)
		_RemoteMain.NQS_IntervalToggle()
		SetToggleOptionValue(a_option, _NQS_IntervalActive.GetValue() As Bool)
	EndIf
EndEvent


; Called when a slider option has been selected.
; a_option - The option ID.
Event OnOptionSliderOpen(Int a_option)
	If (a_option == _CyclicMaxSaves_S)
		SetSliderDialogStartValue(_NQS_CyclicMaxSaves.GetValue() As Int)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(1, 100)
		SetSliderDialogInterval(1)
	ElseIf (a_option == _IntervalDuration_S)
		SetSliderDialogStartValue(_NQS_IntervalDuration.GetValue() As Int)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(10, 300)
		SetSliderDialogInterval(5)
	ElseIf (a_option == _IntervalMaxSaves_S)
		SetSliderDialogStartValue(_NQS_IntervalMaxSaves.GetValue() As Int)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(1, 100)
		SetSliderDialogInterval(1)
	EndIf
EndEvent


; Called when a new slider value has been accepted.
; a_option - The option ID.
; a_value - The accepted value.
Event OnOptionSliderAccept(Int a_option, Float a_value)
	If (a_option == _CyclicMaxSaves_S)
		_NQS_CyclicMaxSaves.SetValue(a_value)
		SetSliderOptionValue(a_option, a_value)
	ElseIf (a_option == _IntervalDuration_S)
		_NQS_IntervalDuration.SetValue(a_value)
		SetSliderOptionValue(a_option, a_value)
	ElseIf (a_option == _IntervalMaxSaves_S)
		_NQS_IntervalMaxSaves.SetValue(a_value)
		SetSliderOptionValue(a_option, a_value)
	EndIf
EndEvent


; Called when a key has been remapped.
; a_option - The option ID.
; a_keyCode - The new keycode.
; a_conflictControl - The conflicting control if the keycode was already in use; "" otherwise.
; a_conflictName - ModName of the conflicting mod; "" if there was no conflict or if conflicting with a vanilla control.
Event OnOptionKeyMapChange(Int a_option, Int a_keyCode, String a_conflictControl, String a_conflictName)
	If (a_option == _ManualSaveKey_K)
		If (KeyConflict(a_conflictControl, a_conflictName))
			_RemoteMain.NQS_UnregisterOldKey(_NQS_ManualSaveKey.GetValue() As Int)
			_NQS_ManualSaveKey.SetValue(a_keyCode)
			_RemoteMain.NQS_RegisterNewKey(_NQS_ManualSaveKey.GetValue() As Int)
			SetKeymapOptionValue(a_option, a_keyCode)
		EndIf
	ElseIf (a_option == _CyclicSaveKey_K)
		If (KeyConflict(a_conflictControl, a_conflictName))
			_RemoteMain.NQS_UnregisterOldKey(_NQS_CyclicSaveKey.GetValue() As Int)
			_NQS_CyclicSaveKey.SetValue(a_keyCode)
			_RemoteMain.NQS_RegisterNewKey(_NQS_CyclicSaveKey.GetValue() As Int)
			SetKeymapOptionValue(a_option, a_keyCode)
		EndIf
	EndIf
EndEvent


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