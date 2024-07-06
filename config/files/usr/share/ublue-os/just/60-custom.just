custom-setup:
    #!/usr/bin/env bash

    WAKAPI_API_URL=$(gum input --value "https://wakapi.app.joshthomas.cool/api")
    WAKAPI_API_KEY=$(gum input --placeholder "Wakapi API Key")

    cat <<EOF >~/.wakatime.cfg
    [settings]
    debug = false
    hidefilenames = false
    ignore =
        COMMIT_EDITMSG$
        PULLREQ_EDITMSG$
        MERGE_MSG$
        TAG_EDITMSG$
    api_url = $WAKAPI_API_URL
    api_key = $WAKAPI_API_KEY
    EOF

    cat <<EOF >~/.config/mimeapps.list
    [Added Associations]
    x-scheme-handler/http=vivaldi-stable.desktop;
    x-scheme-handler/https=vivaldi-stable.desktop;

    [Default Applications]
    text/html=org.mozilla.firefox.desktop
    x-scheme-handler/http=vivaldi-stable.desktop;
    x-scheme-handler/https=vivaldi-stable.desktop;
    EOF

    update-mime-database /usr/share/mime
