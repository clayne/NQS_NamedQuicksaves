#include "common/IDebugLog.h"  // gLog
#include "skse64/PluginAPI.h"  // PluginHandle, SKSEPapyrusInterface, SKSEInterface, PluginInfo
#include "skse64_common/skse_version.h"  // RUNTIME_VERSION

#include <shlobj.h>  // CSIDL_MYDOCUMENTS

#include "NQS_Utility.h"  // RegisterFuncs
#include "version.h"  // NQS_VERSION_VERSTRING


static PluginHandle	g_pluginHandle = kPluginHandle_Invalid;
static SKSEPapyrusInterface* g_papyrus = 0;


extern "C" {
	bool SKSEPlugin_Query(const SKSEInterface* a_skse, PluginInfo* a_info)
	{
		gLog.OpenRelative(CSIDL_MYDOCUMENTS, "\\My Games\\Skyrim Special Edition\\SKSE\\NQS_NamedQuicksaves.log");
		gLog.SetPrintLevel(IDebugLog::kLevel_Error);
		gLog.SetLogLevel(IDebugLog::kLevel_DebugMessage);

		_MESSAGE("NQS_NamedQuicksaves v%s", NQS_VERSION_VERSTRING);

		a_info->infoVersion = PluginInfo::kInfoVersion;
		a_info->name = "NQS_NamedQuicksaves";
		a_info->version = 1;

		g_pluginHandle = a_skse->GetPluginHandle();

		if (a_skse->isEditor) {
			_FATALERROR("[FATAL ERROR] Loaded in editor, marking as incompatible!\n");
			return false;
		}
		if (a_skse->runtimeVersion != RUNTIME_VERSION_1_5_73) {
			_FATALERROR("[FATAL ERROR] Unsupported runtime version %08X!\n", a_skse->runtimeVersion);
			return false;
		}

		return true;
	}


	bool SKSEPlugin_Load(const SKSEInterface* a_skse)
	{
		_MESSAGE("[MESSAGE] NQS_NamedQuicksaves loaded");

		g_papyrus = (SKSEPapyrusInterface *)a_skse->QueryInterface(kInterface_Papyrus);

		if (g_papyrus->Register(RegisterFuncs)) {
			_MESSAGE("[MESSAGE] Papyrus registration succeeded");
		} else {
			_FATALERROR("[FATAL ERROR] Papyrus registration failed!\n");
		}

		return true;
	}
};
