{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [

        # ============================================================================
        # Monospace Fonts
        # ============================================================================
        maple-mono.variable
        anonymousPro
        cascadia-code
        nerd-fonts.caskaydia-cove
        dejavu_fonts
        nerd-fonts.dejavu-sans-mono
        fantasque-sans-mono
        nerd-fonts.fantasque-sans-mono
        fira-code
        fira-code-symbols
        nerd-fonts.fira-code
        fira-mono
        nerd-fonts.fira-mono
        hack-font
        nerd-fonts.hack
        ibm-plex
        nerd-fonts.blex-mono
        inconsolata
        nerd-fonts.inconsolata
        jetbrains-mono
        nerd-fonts.jetbrains-mono
        julia-mono
        office-code-pro
        paratype-pt-sans
        roboto-mono
        nerd-fonts.roboto-mono
        source-code-pro
        ubuntu-classic
        victor-mono

        # ============================================================================
        # Monospace Pro Fonts
        # ============================================================================
        commit-mono
        nerd-fonts.commit-mono
        geist-font
        nerd-fonts.geist-mono
        input-fonts
        iosevka
        nerd-fonts.iosevka
        nerd-fonts.iosevka-term
        nerd-fonts.iosevka-term-slab
        nerd-fonts.zed-mono
        monaspace
        nerd-fonts.monaspace
        recursive
        nerd-fonts.recursive-mono

        # ============================================================================
        # Sans-Serif Fonts
        # ============================================================================
        atkinson-hyperlegible
        cabin
        dosis
        fira
        inter
        lato
        liberation_ttf
        nerd-fonts.liberation
        montserrat
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        open-sans
        overpass
        poppins
        quicksand
        raleway
        roboto
        source-sans-pro
        work-sans

        # ============================================================================
        # Serif Fonts
        # ============================================================================
        alegreya
        cardo
        crimson
        eb-garamond
        garamond-libre
        gelasio
        lmodern
        libre-baskerville
        lora
        merriweather
        source-serif-pro
        vollkorn

        # ============================================================================
        # Display & Symbol Fonts
        # ============================================================================
        comfortaa
        dancing-script
        oswald
        unifont
        symbola
        quivira
      ];
    };
}
