if (dlg_id == 0 || GdIsDone(dlg_id)) {
  if (dlg == 0) dlg_id = GdOpenFile("*.png;PNG Images|*.bmp;BMP Images|*.gif;GIF Images|*.jpeg,*.jpg;JPEG Images", 800, 600);
  else if (dlg == 1) dlg_id = GdOpenFiles("*.png;PNG Images|*.bmp;BMP Images|*.gif;GIF Images|*.jpeg,*.jpg;JPEG Images", 800, 600);
  else if (dlg == 2) dlg_id = GdSaveFile("*.png;PNG Images|*.bmp;BMP Images|*.gif;GIF Images|*.jpeg,*.jpg;JPEG Images", 800, 600);
  else if (dlg == 3) dlg_id = GdOpenDir(800, 600);
  else if (dlg == 4) dlg_id = GdOpenAny("*.png;PNG Images|*.bmp;BMP Images|*.gif;GIF Images|*.jpeg,*.jpg;JPEG Images", 800, 600);
}
if (dlg == 5) dlg = -1;
dlg++;
