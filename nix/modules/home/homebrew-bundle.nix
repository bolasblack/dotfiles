{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.home.homebrewBundle;

  brewCmd = if cfg.enableRosetta then "arch -x86_64 /usr/local/bin/brew" else "/opt/homebrew/bin/brew";
  brewInstallExtraArgs = concatStringsSep " " (
    [ "--force" "--no-upgrade" ] ++
    (optional (cfg.autoCleanup) "--cleanup") ++
    (optional (cfg.flatpaks == []) "--no-flatpak") ++
    (optional (cfg.vscodeExtensions == []) "--no-vscode") ++
    (optional (cfg.cargoPackages == []) "--no-cargo") ++
    (optional (cfg.goPackages == []) "--no-go")
  );

  # Helpers to format values for Brewfile
  # Handles boolean, integer, list, and strings
  formatValue = v:
    if isBool v then (if v then "true" else "false")
    else if isInt v then toString v
    else if isList v then "[${concatMapStringsSep ", " (x: formatValue x) v}]"
    else "\"${toString v}\"";

  # Helper to generate arguments string: key: value, ...
  formatArgs = args:
    concatStringsSep ", " (mapAttrsToList (k: v: "${k}: ${formatValue v}") args);

  # Helper to process an entry (string or attrset)
  # type: "brew", "cask", ...
  # entry: "name" or { name = "name"; arg1 = val1; ... }
  formatEntry = type: entry:
    if isString entry then
      "${type} \"${entry}\""
    else
      let
        name = entry.name;
        args = removeAttrs entry [ "name" ];
        argsStr = formatArgs args;
      in
      "${type} \"${name}\"" + (optionalString (args != { }) ", ${argsStr}");

  # Generate content from options
  generatedContentLines =
    (map (tap: "tap \"${tap}\"") cfg.taps) ++
    (map (brew: formatEntry "brew" brew) cfg.brews) ++
    (map (cask: formatEntry "cask" cask) cfg.casks) ++
    (map (mas: formatEntry "mas" mas) cfg.mas) ++
    (map (vscode: formatEntry "vscode" vscode) cfg.vscodeExtensions) ++
    (map (cargo: formatEntry "cargo" cargo) cfg.cargoPackages) ++
    (map (go: formatEntry "go" go) cfg.goPackages) ++
    (map (flatpak: formatEntry "flatpak" flatpak) cfg.flatpaks);

  # Read extra Brewfile if provided
  # If it's a path (build time), read it now.
  # If it's a string (runtime), insert Ruby code to load it at runtime.
  extraContent =
    if cfg.extraBrewfile == null then ""
    else if ! isString cfg.extraBrewfile then
      if builtins.pathExists cfg.extraBrewfile then
        "\n" + (builtins.readFile cfg.extraBrewfile)
      else
        lib.warn "Configured `homebrewBundle.extraBrewfile` '${toString cfg.extraBrewfile}' does not exist. Skipping." ""
    else
      ''
        # Include external Brewfile defined in Nix configuration
        extra_brewfile = "${cfg.extraBrewfile}"
        if File.exist?(extra_brewfile)
          instance_eval(File.read(extra_brewfile))
        else
          puts "Warning: Extra Brewfile '#{extra_brewfile}' not found. Skipping."
        end
      '';

  prebuiltBrewfilePath = ".Brewfile";
  prebuiltBrewfileContent = concatStringsSep "\n" (
    generatedContentLines ++
    [ extraContent ]
  );

in
{
  options.home.homebrewBundle = {
    enable = mkEnableOption "Homebrew Bundle support";

    autoCleanup = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to remove unused formulae and casks.";
    };

    enableRosetta = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to use Rosetta 2 prefix for brew command if on Apple Silicon.";
    };

    extraBrewfile = mkOption {
      type = types.nullOr (types.either types.path types.str);
      default = null;
      description = "Path to an additional Brewfile. Strings are treated as runtime paths (merged at activation). Paths are read at build time.";
    };

    taps = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "List of Homebrew taps.";
    };

    brews = mkOption {
      type = types.listOf (types.either types.str types.attrs);
      default = [ ];
      description = ''
        List of Homebrew formulae.
        Can be a string "name" or an attribute set { name = "name"; ...ARGS }.
      '';
    };

    casks = mkOption {
      type = types.listOf (types.either types.str types.attrs);
      default = [ ];
      description = ''
        List of Homebrew casks.
        Can be a string "name" or an attribute set { name = "name"; ...ARGS }.
      '';
    };

    mas = mkOption {
      type = types.listOf (types.either types.str types.attrs);
      default = [ ];
      description = ''
        List of Mac App Store apps.
        Can be a string "name" (if you want to rely on search? usually mas needs id) 
        OR an attribute set { name = "AppName"; id = 123456; ... }.
      '';
    };

    flatpaks = mkOption {
      type = types.listOf (types.either types.str types.attrs);
      default = [ ];
      description = ''
        List of Flatpak apps.
        Can be a string "name" or an attribute set { name = "name"; ...ARGS }.
      '';
    };

    vscodeExtensions = mkOption {
      type = types.listOf (types.either types.str types.attrs);
      default = [ ];
      description = ''
        List of VSCode extensions.
        Can be a string "name" or an attribute set { name = "name"; ...ARGS }.
      '';
    };

    cargoPackages = mkOption {
      type = types.listOf (types.either types.str types.attrs);
      default = [ ];
      description = ''
        List of Cargo packages.
        Can be a string "name" or an attribute set { name = "name"; ...ARGS }.
      '';
    };

    goPackages = mkOption {
      type = types.listOf (types.either types.str types.attrs);
      default = [ ];
      description = ''
        List of Go packages.
        Can be a string "name" or an attribute set { name = "name"; ...ARGS }.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.sessionPath = [ "/opt/homebrew/bin/" ];

    # Generate ~/.Brewfile with merged content
    home.file."${prebuiltBrewfilePath}" = {
      text = prebuiltBrewfileContent;
      onChange = ''
        echo "Homebrew config changed. Checking bundle status..."
        if ! ${brewCmd} bundle check --file="$HOME/${prebuiltBrewfilePath}" --verbose > /dev/null 2>&1; then
          echo "Bundle not satisfied. Installing..."
          ${brewCmd} bundle install --file="$HOME/${prebuiltBrewfilePath}" --verbose ${brewInstallExtraArgs}
        else
          echo "Bundle satisfied. Skipping install."
        fi
      '';
    };
  };
}
