#include "../skse64/PluginAPI.h"
#include "../skse64_common/skse_version.h"
#include <shlobj.h>


#include "NQSUtility.h"


static PluginHandle	g_pluginHandle = kPluginHandle_Invalid;
static SKSEPapyrusInterface* g_papyrus = NULL;


extern "C" {
	bool SKSEPlugin_Query(const SKSEInterface * skse, PluginInfo * info)
	{
		gLog.OpenRelative(CSIDL_MYDOCUMENTS, "\\My Games\\Skyrim Special Edition\\SKSE\\SprintJump.log");
		gLog.SetPrintLevel(IDebugLog::kLevel_Error);
		gLog.SetLogLevel(IDebugLog::kLevel_DebugMessage);

		_MESSAGE("Named Quicksaves");

		// populate info structure
		info->infoVersion = PluginInfo::kInfoVersion;
		info->name = "NQSNamedQuicksaves";
		info->version = 1;

		// store plugin handle so we can identify ourselves later
		g_pluginHandle = skse->GetPluginHandle();

		if (skse->isEditor)
		{
			_MESSAGE("loaded in editor, marking as incompatible");
			return false;
		}
		else if (skse->runtimeVersion != RUNTIME_VERSION_1_5_39)
		{
			_MESSAGE("unsupported runtime version %08X", skse->runtimeVersion);
			return false;
		}

		// supported runtime version
		return true;
	}


	bool SKSEPlugin_Load(const SKSEInterface * skse) {
		_MESSAGE("MyScriptPlugin loaded");

		g_papyrus = (SKSEPapyrusInterface *)skse->QueryInterface(kInterface_Papyrus);

		//Check if the function registration was a success...
		bool btest = g_papyrus->Register(NQSUtility::RegisterFuncs);

		if (btest) {
			_MESSAGE("Register Succeeded");
		}

		return true;
	}
};

