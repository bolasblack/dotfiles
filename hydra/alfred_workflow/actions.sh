
. workflowHandler.sh

APP=/Applications/Hydra.app/Contents/Resources/hydra

showOptions() {
  addResult 'reload' 'reload' 'Reload hydra config' '' '' 'yes' 'autocomplete'
  addResult 'repl'   'repl'   'Open hydra repl'     '' '' 'yes' 'autocomplete'
  addResult 'log'    'log'    'Show hydra log'      '' '' 'yes' 'autocomplete'
  addResult 'update' 'update' 'Check hydra update'  '' '' 'yes' 'autocomplete'
  addResult 'donate' 'donate' 'Donate hydra'        '' '' 'yes' 'autocomplete'

  getXMLResults
}

doActions() {
  case "$1" in
    reload)
      $APP 'hydra.reload()'
      ;;
    repl)
      $APP 'repl.open()'
      ;;
    update)
      $APP 'checkforupdates()'
      ;;
    log)
      $APP 'logger.show()'
      ;;
    donate)
      $APP 'donate()'
      ;;
    *)
      $APP "hydra.alert('$1 Didn\'t match anything')"
  esac
}

