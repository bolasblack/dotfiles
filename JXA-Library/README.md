# Apple JavaScript for Automation Library

* About JXA Library: https://developer.apple.com/library/archive/releasenotes/InterapplicationCommunication/RN-JavaScriptForAutomation/Articles/OSX10-10.html#//apple_ref/doc/uid/TP40014508-CH109-SW14

## Usage

Link files:

```bash
mkdir -p "~/Library/Script Libraries" && \
cd "~/Library/Script Libraries" && \
ln -s ~/dotfiles/JXA-Library c4
```

Use library:

```javascript
const { require } = Library('c4/require.js')
require('~/workSpace/somemodule')
```

## Other resource

* JavaScript for Automation Release Notes: https://developer.apple.com/library/archive/releasenotes/InterapplicationCommunication/RN-JavaScriptForAutomation/Articles/Introduction.html
* AppleScript Language Guide: https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html
* Mac Automation Scripting Guide: https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/index.html
* Keyboard Maestro Wiki - JavaScript for Automation (JXA) Discussion https://wiki.keyboardmaestro.com/JavaScript_for_Automation
