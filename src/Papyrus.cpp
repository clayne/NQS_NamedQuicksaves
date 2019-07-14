#include "Papyrus.h"

#include <cstdio>
#include <iomanip>
#include <sstream>
#include <string_view>

#include "RE/Skyrim.h"


namespace NQS_NamedQuicksaves_Utility
{
	RE::BSFixedString GetPlayerHash(RE::StaticFunctionTag*)
	{
		char buf[] = "DEADBEEF";
		auto saveData = RE::BSWin32SaveDataSystemUtility::GetSingleton();
		if (saveData->profileHash == static_cast<UInt32>(-1)) {
			std::snprintf(buf, sizeof(buf), "%08o", 0);
		} else {
			std::snprintf(buf, sizeof(buf), "%08X", saveData->profileHash);
		}
		return buf;
	}


	RE::BSFixedString StringToHex(RE::StaticFunctionTag*, RE::BSFixedString a_string)
	{
		std::string_view str(a_string);

		std::stringstream sstream;
		for (auto ch : str) {
			sstream << std::uppercase << std::hex << static_cast<int>(ch);
		}

		return sstream.str();
	}


	bool RegisterFuncs(RE::BSScript::Internal::VirtualMachine* a_vm)
	{
		a_vm->RegisterFunction("GetPlayerHash", "NQS_NamedQuicksaves_Utility", GetPlayerHash);
		a_vm->RegisterFunction("StringToHex", "NQS_NamedQuicksaves_Utility", StringToHex);
		return true;
	}
}
