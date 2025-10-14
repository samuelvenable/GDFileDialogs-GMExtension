function GenerateWorkingDirectory() {
  // GenerateWorkingDirectory() - Call this Function at Game Start
  // Sets DirectoryGetCurrentWorking() to Ubuntu (Linux) Assets SubFolder
  // Sets DirectoryGetCurrentWorking() to Mac App Bundle Resources Folder
  if (os_type == os_linux)  { return DirectorySetCurrentWorking(DirectoryGetCurrentWorking() + "/assets/"); }
  if (os_type != os_macosx) { return true; }
  success = false; 
  exe_pname = ExecutableFromSelf();                // = "/Path/To/YourAppBundle.app/Contents/MacOS/";
  macos_dname = filename_dir(exe_pname);           // = "/Path/To/YourAppBundle.app/Contents/MacOS";
  macos_bname = filename_name(macos_dname);        // = "MacOS";
  contents_dname = filename_dir(macos_dname);      // = "/Path/To/YourAppBundle.app/Contents";
  contents_bname = filename_name(contents_dname);  // = "Contents";
  app_dname = filename_dir(contents_dname);        // = "/Path/To/YourAppBundle.app";
  app_ename = filename_ext(app_dname);             // = ".app";
  contents_pname = filename_path(macos_dname);     // = "/Path/To/YourAppBundle.app/Contents/";
  resources_pname = contents_pname + "Resources/"; // = "/Path/To/YourAppBundle.app/Contents/Resources/";
  // if running from the IDE change working directory to:
  if (directory_exists(filename_path(parameter_string(1)))) {
    success = DirectorySetCurrentWorking(filename_path(parameter_string(1)));
  } // if "/Path/To/YourAppBundle.app/Contents/MacOS/YourExe" and "/Path/To/YourAppBundle.app/Contents/Resources/" exists
  else if (macos_bname == "MacOS" && contents_bname == "Contents" && app_ename == ".app" && directory_exists(resources_pname)) {
    // set working directory to "/Path/To/YourAppBundle.app/Contents/Resources/" and allow loading normal included files
    success = DirectorySetCurrentWorking(resources_pname);
  }
  return success;
}
GenerateWorkingDirectory();
if (os_type == os_macosx) {
  zip_unzip(working_directory + "gdfiledialogs.app.zip", working_directory);
  global.gdpid = ProcessExecute("chmod +x \"" + working_directory + "gdfiledialogs\"");
  FreeExecutedProcessStandardInput(global.gdpid);
  FreeExecutedProcessStandardOutput(global.gdpid);
  global.gdpid = ProcessExecute("xattr -d -r com.apple.quarantine \"" + working_directory + "gdfiledialogs\"");
  FreeExecutedProcessStandardInput(global.gdpid);
  FreeExecutedProcessStandardOutput(global.gdpid);
} else if (os_type == os_linux) {
  global.gdpid = ProcessExecute("chmod +x \"" + working_directory + "gdfiledialogs.x86_64\"");
  FreeExecutedProcessStandardInput(global.gdpid);
  FreeExecutedProcessStandardOutput(global.gdpid);
}
global.gdexe = "\"" + working_directory + "gdfiledialogs" + ((os_type == os_windows) ? ".exe\"" : ((os_type == os_macosx) ? "\" 2> /dev/null" : ".x86_64\" 2> /dev/null"));
function GdOpenFile(Filter, Width = display_get_width() * 0.5, Height = display_get_height() * 0.5) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --open-file \"" + string(Filter) + "\" " + string(Width) + " " + string(Height));
  return global.gdpid;
}
function GdOpenFiles(Filter, Width = display_get_width() * 0.5, Height = display_get_height() * 0.5) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --open-files \"" + string(Filter) + "\" " + string(Width) + " " + string(Height));
  return global.gdpid;
}
function GdSaveFile(Filter, Width = display_get_width() * 0.5, Height = display_get_height() * 0.5) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --save-file \"" + string(Filter) + "\" " + string(Width) + " " + string(Height));
  return global.gdpid;
}
function GdOpenDir(Width = display_get_width() * 0.5, Height = display_get_height() * 0.5) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --open-dir " + string(Width) + " " + string(Height));
  return global.gdpid;
}
function GdOpenAny(Filter, Width = display_get_width() * 0.5, Height = display_get_height() * 0.5) {
  global.gdpid = ProcessExecuteAsync(global.gdexe + " --open-any \"" + string(Filter) + "\" " + string(Width) + " " + string(Height));
  return global.gdpid;
}
function GdIsDone(DialogId) {
  return CompletionStatusFromExecutedProcess(DialogId);
}
function GdCallback(DialogId) {
  str = "";
  if (os_type == os_windows) {
    var username = environment_get_variable("USERNAME")
    temp_path = "C:/Users/" + username + "/AppData/Local/Temp/"
  } else {
    temp_path = "/tmp/"
  }
  if (file_exists(temp_path + "gdfiledialogs.txt")) {
    var fd = file_text_open_read(temp_path + "gdfiledialogs.txt");
    if (fd != -1) {
      while (!file_text_eof(fd)) {
        str += file_text_read_string(fd) + "\n";
		file_text_readln(fd);
	  }
	  file_text_close(fd);
    }
    file_delete(temp_path + "gdfiledialogs.txt");
    if (string_length(str) > 0) {
      if (string_copy(str, string_length(str) - 1, 1) == "\n") {
        str = string_copy(str, 0, string_length(str) - 1);
	  }
    }
  }
  FreeExecutedProcessStandardInput(global.gdpid);
  FreeExecutedProcessStandardOutput(global.gdpid);
  return str;
}
