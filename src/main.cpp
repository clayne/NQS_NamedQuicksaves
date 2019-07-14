#include "skse64_common/skse_version.h"

#include "Papyrus.h"
#include "version.h"

#include "SKSE/API.h"


extern "C" {
	bool SKSEPlugin_Query(const SKSE::QueryInterface* a_skse, SKSE::PluginInfo* a_info)
	{
		SKSE::Logger::OpenRelative(FOLDERID_Documents, L"\\My Games\\Skyrim Special Edition\\SKSE\\NQS_NamedQuicksaves.log");
		SKSE::Logger::SetPrintLevel(SKSE::Logger::Level::kDebugMessage);
		SKSE::Logger::SetFlushLevel(SKSE::Logger::Level::kDebugMessage);
		SKSE::Logger::UseLogStamp(true);

		_MESSAGE("NQS_NamedQuicksaves v%s", NQS_VERSION_VERSTRING);

		a_info->infoVersion = SKSE::PluginInfo::kVersion;
		a_info->name = "NQS_NamedQuicksaves";
		a_info->version = NQS_VERSION_MAJOR;

		if (a_skse->IsEditor()) {
			_FATALERROR("Loaded in editor, marking as incompatible!\n");
			return false;
		}

		switch (a_skse->RuntimeVersion()) {
		case RUNTIME_VERSION_1_5_73:
		case RUNTIME_VERSION_1_5_80:
			break;
		default:
			_FATALERROR("Unsupported runtime version %08X!\n", a_skse->RuntimeVersion());
			return false;
		}

		return true;
	}


	bool SKSEPlugin_Load(const SKSE::LoadInterface* a_skse)
	{
		_MESSAGE("NQS_NamedQuicksaves loaded");

		if (!SKSE::Init(a_skse)) {
			return false;
		}

		auto papyrus = SKSE::GetPapyrusInterface();
		if (!papyrus->Register(NQS_NamedQuicksaves_Utility::RegisterFuncs)) {
			_FATALERROR("Failed to register papyrus reg callback!\n");
			return false;
		}

		return true;
	}
};
