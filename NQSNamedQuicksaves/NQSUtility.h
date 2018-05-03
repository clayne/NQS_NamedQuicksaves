#pragma once
#include "../skse64/PluginAPI.h"
#include "../skse64/GameTypes.h"
#include "../skse64/PapyrusNativeFunctions.h"


namespace NQSUtility
{
	BSFixedString getPlayerHash(StaticFunctionTag* base);
	// Gets the player's save profile hash

	BSFixedString StringToHex(StaticFunctionTag* base, BSFixedString a_string);
	// Returns the passed string as its hex equivalent

	bool RegisterFuncs(VMClassRegistry* registry);
}