#include "NQS_Utility.h"

#include "skse64_common/Relocation.h"  // RelocPtr
#include "skse64/GameEvents.h"  // EventDispatcher
#include "skse64/GameTypes.h"  // BSFixedString
#include "skse64/PapyrusNativeFunctions.h"  // StaticFunctionTag, NativeFunction
#include "skse64/PapyrusVM.h"  // VMClassRegistry

#include <cstdio>  // snprintf
#include <iomanip>  // hex
#include <sstream>  // stringstream
#include <string>  // string


namespace
{
	class BSSaveDataEvent;


	class BSWin32SaveDataSystemUtility
	{
	public:
		virtual ~BSWin32SaveDataSystemUtility();


		static BSWin32SaveDataSystemUtility* GetSingleton()
		{
			using func_t = BSWin32SaveDataSystemUtility * ();
			// E8 ? ? ? ? 4C 8B 18
			RelocAddr<func_t*> func(0x0133EC10);	// 1_5_72
			return func();
		}


		// members
		EventDispatcher<BSSaveDataEvent>	dispatcher;
		UInt32								unk;
		UInt32								profileHash;
	};
}


BSFixedString GetPlayerHash(StaticFunctionTag* a_base)
{
	static char buf[100];
	BSWin32SaveDataSystemUtility* saveData = BSWin32SaveDataSystemUtility::GetSingleton();
	if (saveData->profileHash == static_cast<UInt32>(-1)) {
		return "00000000";
	} else {
		std::snprintf(buf, sizeof(buf), "%08X", saveData->profileHash);
		return buf;
	}
}


BSFixedString StringToHex(StaticFunctionTag* a_base, BSFixedString a_string)
{
	std::string str = a_string.c_str();

	// Convert to hex
	std::stringstream sstream;
	for (auto& c : str) {
		sstream << std::hex << (int)c;
	}
	str = sstream.str();

	// Convert lowercase characters to uppercase
	for (auto& c : str) {
		c = toupper(c);
	}

	return str.c_str();
}


bool RegisterFuncs(VMClassRegistry* a_registry)
{
	a_registry->RegisterFunction(
		new NativeFunction0<StaticFunctionTag, BSFixedString>("GetPlayerHash", "NQS_NamedQuicksaves_Utility", GetPlayerHash, a_registry));
	a_registry->RegisterFunction(
		new NativeFunction1<StaticFunctionTag, BSFixedString, BSFixedString>("StringToHex", "NQS_NamedQuicksaves_Utility", StringToHex, a_registry));

	return true;
}
