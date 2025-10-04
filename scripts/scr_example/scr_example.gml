if (os_type == os_macosx) {
  zip_unzip(working_directory + "gdfiledialogs.app.zip", working_directory);
  global.gdpid = ProcessExecute("chmod +x \"" + working_directory + "gdfiledialogs\"");
  FreeExecutedProcessStandardInput(global.gdpid);
  FreeExecutedProcessStandardOutput(global.gdpid);
  global.gdpid = ProcessExecute("xattr -d -r com.apple.quarantine \"" + working_directory + "gdfiledialogs\"");
  FreeExecutedProcessStandardInput(global.gdpid);
  FreeExecutedProcessStandardOutput(global.gdpid);
} else if (os_type == os_linux) {
  global.gdpid = ProcessExecute("chmod +x \"" + working_directory + "gdfiledialogs.elf\"");
  FreeExecutedProcessStandardInput(global.gdpid);
  FreeExecutedProcessStandardOutput(global.gdpid);
}
global.gdexe = "\"" + working_directory + "gdfiledialogs" + ((os_type == os_windows) ? ".exe\"" : ((os_type == os_macosx) ? "\"" : ".elf\""));
function GdOpenFile(Filter, Title) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --open-file \"" + Filter + "\" \"" + Title + "\"");
  return global.gdpid;
}
function GdOpenFiles(Filter, Title) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --open-files \"" + Filter + "\" \"" + Title + "\"");
  return global.gdpid;
}
function GdSaveFile(Filter, Title) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --save-file \"" + Filter + "\" \"" + Title + "\"");
  return global.gdpid;
}
function GdOpenDir(Title) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --open-dir \"\" \"" + Title + "\"");
  return global.gdpid;
}
function GdOpenAny(Filter, Title) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --open-any \"" + Filter + "\" \"" + Title + "\"");
  return global.gdpid;
}
function GdIsDone(DialogId) {
  return CompletionStatusFromExecutedProcess(DialogId);
}
function GdCallback(DialogId) {
  var str = "";
  var arr = string_split(string_replace_all(ExecutedProcessReadFromStandardOutput(DialogId), "\r", ""), "\n", false);
  if (array_length(arr) >= 7) 
    array_delete(arr, 0, 7);
  if (array_length(arr) >= 2) 
    array_delete(arr, array_length(arr) - 1, 1);
  for (var i = 0; i < array_length(arr); i++) 
    str += arr[i] + ((i < array_length(arr) - 1) ? "\n" : "");
  FreeExecutedProcessStandardInput(global.gdpid);
  FreeExecutedProcessStandardOutput(global.gdpid);
  return str;
}

