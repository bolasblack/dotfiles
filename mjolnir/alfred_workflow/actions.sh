
. workflowHandler.sh

bin=/usr/local/bin/mjolnir

binFileAvaliable() {
    [ -x $bin ] && tmp=$($bin -c 'print(1)' 2>&1)
}

showOptions() {
    if binFileAvaliable; then
        addResult 'reload'  'reload'  'Reload mjolnir config' '' '' 'yes' ''
        addResult 'console' 'console' 'Open mjolnir console'  '' '' 'yes' ''
        addResult 'luacode' 'luacode' 'Execute lua code'      '' '' 'no'  ''
    else
        addResult 'unavaliable' 'unavaliable' 'Mjolnir cli is not avaliable' 'Is it installed? or Is Mjolnir running?' '' 'no' ''
    fi
    getXMLResults
}

doActions() {
    case "$1" in
        reload)
            $bin -c 'mjolnir.reload()'
            ;;
        console)
            $bin -c 'mjolnir.openconsole()'
            ;;
        *)
            $bin -c "$1"
    esac
}
