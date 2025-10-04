if (dlg <= 4 && GdIsDone(dlg_id)) {
  callback = GdCallback(dlg_id);
  if (callback != "")
    show_message(callback);
}