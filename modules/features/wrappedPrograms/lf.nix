{
  inputs,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: let
    conf =
      pkgs.writeText "config"
      # bash
      ''
        set reverse true
        set preview true
        set hidden true
        set drawbox true
        set icons true
        set ignorecase true

        # previewer
        # cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
        # &${pkgs.ctpv}/bin/ctpv -s $id
        # set cleaner ${pkgs.ctpv}/bin/ctpvclear
        # set previewer ${pkgs.ctpv}/bin/ctpv


        cmd stripspace %stripspace "$f"

        map "\""
        map o
        map d
        map e
        map f
        map . set hidden!
        map D delete
        map p paste
        map dd cut
        map y copy
        map ` mark-load
        map \' mark-load
        map <enter> open
        map a rename
        map r reload
        map C clear
        map U unselect

        map do drag-out

        map g~ cd
        map gh cd
        map g/ /
        map gd cd ~/downloads
        map gt cd /tmp
        map gv cd ~/videos
        map go cd ~/documents
        map gc cd ~/.config
        map gn cd ~/irix
        map gp cd ~/projects
        map gs cd ~/.local/share
        map gm cd /run/media

        map eE $ $EDITOR "$f"
        map ee $ ${lib.getExe pkgs.direnv} exec . $EDITOR "$f"
        map e. $ ${lib.getExe pkgs.direnv} exec . $EDITOR .
        map V $ ${lib.getExe pkgs.bat} --paging=always --theme=gruvbox "$f"
        map do $ ${lib.getExe pkgs.ripdrag} -a -x "$fx"

        map <C-d> 5j
        map <C-u> 5k

        setlocal ~/Projects sortby time
        setlocal ~/Projects/* sortby time
        setlocal ~/Downloads/ sortby time
      '';
  in {
    packages.lf = inputs."wrapper-modules".lib.wrapPackage {
      inherit pkgs;
      package = pkgs.lf;
      flags = {
        "-config" = "${conf}";
      };
    };
  };
}
