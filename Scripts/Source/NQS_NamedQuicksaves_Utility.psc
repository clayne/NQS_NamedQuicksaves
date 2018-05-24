ScriptName NQS_NamedQuicksaves_Utility Extends Form


; Gets the player hash used to uniquely identify the player's save profile.
; RETURN - Returns the player hash as an 8-digit string.
String Function GetPlayerHash() Global Native


; Converts the given string to it's hexadecimal equivalent. Preserves case.
; a_string - The string to convert to hexadecimal.
; RETURN - Returns the hexadecimal equivalent of the passed string.
String Function StringToHex(String a_string) Global Native