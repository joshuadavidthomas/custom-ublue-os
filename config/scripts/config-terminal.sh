#!/usr/bin/env bash

set -ouex pipefail

sed -i '/<entry name="launchers" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/browser,preferred:\/\/terminal,applications:org.kde.discover.desktop,preferred:\/\/filemanager<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
sed -i '/<entry name="favorites" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/browser,preferred:\/\/terminal,systemsettings.desktop,org.kde.dolphin.desktop,org.kde.kate.desktop,org.kde.discover.desktop<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml

sed -i 's@Keywords=shell;prompt;command;commandline;cmd;@Keywords=shell;prompt;command;commandline;cmd;konsole;console;@g' /usr/share/applications/org.wezfurlong.wezterm.desktop
sed -i 's@\[Desktop Action new-window\]@\[Desktop Action new-window\]\nX-KDE-Shortcuts=Ctrl+Alt+T@g' /usr/share/applications/org.wezfurlong.wezterm.desktop
cp /usr/share/applications/org.wezfurlong.wezterm.desktop /usr/share/kglobalaccel/org.wezfurlong.wezterm.desktop

sed -i 's@\[Desktop Action new-window\]\nX-KDE-Shortcuts=Ctrl+Alt+T@\[Desktop Action new-window\]@g' /usr/share/applications/org.gnome.Ptyxis.desktop
sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/org.gnome.Ptyxis.desktop
rm -f /usr/share/kglobalaccel/org.gnome.Ptyxis.desktop
