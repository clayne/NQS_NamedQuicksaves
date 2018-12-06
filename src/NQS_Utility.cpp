#include "skse64/GameTypes.h"
#include "skse64/PapyrusNativeFunctions.h"
#include "skse64/PapyrusVM.h"
#include "skse64/PluginAPI.h"
#include "skse64_common/Relocation.h"
#include <iomanip>
#include <sstream>
#include <string>

#include "NQS_Utility.h"


namespace NQS_NamedQuicksaves_Utility
{
	BSFixedString GetPlayerHash(StaticFunctionTag* base)
	{
		// Grab player hash
		static RelocPtr <SInt32> playerHash(0x034BC3F4);	// 1_5_62

		// Convert to hex
		std::stringstream sstream;
		sstream << std::hex << *playerHash;
		std::string hexName = sstream.str();

		// Convert lowercase characters to uppercase
		for (auto & c: hexName) {
			c = toupper(c);
		}

		// Sign extension
		while (std::strlen(hexName.c_str()) < 8) {
			hexName = '0' + hexName;
		}

		return hexName.c_str();
	}


	BSFixedString StringToHex(StaticFunctionTag* base, BSFixedString a_string)
	{
		std::string str = a_string.c_str();

		// Convert to hex
		std::stringstream sstream;
		for (auto & c : str) {
			sstream << std::hex << (int)c;
		}
		str = sstream.str();

		// Convert lowercase characters to uppercase
		for (auto & c : str) {
			c = toupper(c);
		}

		return str.c_str();
	}


	bool RegisterFuncs(VMClassRegistry* registry)
	{
		registry->RegisterFunction(
			new NativeFunction0<StaticFunctionTag, BSFixedString>("GetPlayerHash", "NQS_NamedQuicksaves_Utility", NQS_NamedQuicksaves_Utility::GetPlayerHash, registry));
		registry->RegisterFunction(
			new NativeFunction1<StaticFunctionTag, BSFixedString, BSFixedString>("StringToHex", "NQS_NamedQuicksaves_Utility", NQS_NamedQuicksaves_Utility::StringToHex, registry));

		return true;
	}
}
