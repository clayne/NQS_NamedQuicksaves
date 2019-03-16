#pragma once

#include "skse64/GameTypes.h"  // BSFixedString

class VMClassRegistry;
struct StaticFunctionTag;


// Gets the player's save profile hash
BSFixedString GetPlayerHash(StaticFunctionTag* a_base);

// Returns the passed string as its hex equivalent
BSFixedString StringToHex(StaticFunctionTag* a_base, BSFixedString a_string);

bool RegisterFuncs(VMClassRegistry* a_registry);
