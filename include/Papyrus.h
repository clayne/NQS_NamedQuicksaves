#pragma once

#include "RE/Skyrim.h"

namespace NQS_NamedQuicksaves_Utility
{
	// Gets the player's save profile hash
	RE::BSFixedString GetPlayerHash(RE::StaticFunctionTag*);

	// Returns the passed string as its hex equivalent
	RE::BSFixedString StringToHex(RE::StaticFunctionTag*, RE::BSFixedString a_string);

	bool RegisterFuncs(RE::BSScript::Internal::VirtualMachine* a_vm);
}
