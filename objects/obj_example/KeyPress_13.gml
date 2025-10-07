if (dlg_id == 0 || GdIsDone(dlg_id)) {
  if (dlg == 0) dlg_id = GdOpenFile("*.exe;Microsoft Windows Portable Executable|*.app.zip;Compressed (Zipped) macOS Application|*.x86_64;x86_64-Architectured Linux Executable");
  else if (dlg == 1) dlg_id = GdOpenFiles("*.exe;Microsoft Windows Portable Executable|*.app.zip;Compressed (Zipped) macOS Application|*.x86_64;x86_64-Architectured Linux Executable");
  else if (dlg == 2) dlg_id = GdSaveFile("*.exe;Microsoft Windows Portable Executable|*.app.zip;Compressed (Zipped) macOS Application|*.x86_64;x86_64-Architectured Linux Executable");
  else if (dlg == 3) dlg_id = GdOpenDir();
  else if (dlg == 4) dlg_id = GdOpenAny("*.exe;Microsoft Windows Portable Executable|*.app.zip;Compressed (Zipped) macOS Application|*.x86_64;x86_64-Architectured Linux Executable");
}
if (dlg == 5) dlg = -1;
dlg++;
