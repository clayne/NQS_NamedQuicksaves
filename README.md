# NQS NamedQuicksaves



### Save Structure

Save3_0C2D58E2_0_507269736F6E6572_Tamriel_000002_20180503063315_4_1.ess

* **Save3**: Type and index of save

* **0C2D58E2**: Unique hash used to identify your save profile. Regenerated on closing racemenu.

* **0**: Flag for modded game.

* **507269736F6E6572**: Character name in hex.

* **Tamriel**: coc code.

* **000002**: Days, hours, minutes played.

* **20180503063315**: Year, month, day, hour, minute, second in GMT + 0.

* **4**:  Player level.

* **1**:  Unknown flags.

### Updating

1. Clone the project and place the folder in `skse64`, it should look something like `skse64_2_00_08\src\skse64\NQS_NamedQuicksaves\NQS_NamedQuicksaves.vcxproj`, depending on the version of SKSE64.

2. Open `skse64.sln` and remove `skse64_loader`, `skse64_loader_common`, and `skse64_steam_loader`. Now add `NQS_NamedQuicksaves.vcxproj` to the project.

3. Change `common_vc14`, `skse64`, and `skse64_common` to static libraries (Right Click -> Properties -> Configuration Properties -> General -> Project Defaults -> Configuration Type -> Static library (.lib)).

4. Start Skyrim and make a new save.

5. Locate your save and copy the hash (see above).

6. Open cheat engine and open `SkyrimSE.exe`.

7. Enable the `Hex` box and scan for the hash using `Scan Type: Exact Value` and `Value Type: 4 Bytes`.

8. Copy all green addresses to the addresslist.

9. Go back to Skyrim, open the console and type `showracemenu`, then close the racemenu.

10. Make a new save and copy the hash.

11. Back in Cheat Engine, locate the addresses in your addresslist which updated to the new hash.

12. Once you've narrowed down the correct address, double-click on the address and copy down the offset.

13. Open `NQS_Utility.cpp` and update `playerHash` to the new offset.

14. Now you can build the solution.
