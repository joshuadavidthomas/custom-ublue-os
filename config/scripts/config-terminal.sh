#!/usr/bin/env bash

set -ouex pipefail

sed -i '/<entry name="launchers" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/browser,applications:org.wezfurlong.wezterm.desktop,applications:org.kde.discover.desktop,preferred:\/\/filemanager<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
sed -i '/<entry name="favorites" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/browser,applications:org.wezfurlong.wezterm.desktop,systemsettings.desktop,org.kde.dolphin.desktop,org.kde.kate.desktop,org.kde.discover.desktop<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml

sed -i 's@Keywords=@Keywords=konsole;console;@g' /usr/share/applications/org.wezfurlong.wezterm.desktop
sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nX-KDE-Shortcuts=Ctrl+Alt+T@g' /usr/share/applications/org.wezfurlong.wezterm.desktop
ln -s /usr/share/applications/org.wezfurlong.wezterm.desktop /usr/share/kglobalaccel/org.wezfurlong.wezterm.desktop

sed -i '/X-KDE-Shortcuts=Ctrl+Alt+T/d' /usr/share/applications/org.gnome.Ptyxis.desktop
sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/org.gnome.Ptyxis.desktop
rm -f /usr/share/kglobalaccel/org.gnome.Ptyxis.desktop
