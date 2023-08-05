################
# Automatic virtualenv activation

function __vfsupport_auto_activate --on-variable PWD
    if not status --is-interactive
        return
    end

    if status --is-command-substitution
        return
    end

    if test -e $PWD/.venv/bin/activate.fish
      source $PWD/.venv/bin/activate.fish
    end
end

#automatically activate if started in a directory with a virtualenv in it
__vfsupport_auto_activate
################
