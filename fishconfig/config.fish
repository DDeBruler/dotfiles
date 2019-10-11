set -gx PATH {$HOME}/bin $PATH

for variable_pair in (cat {$HOME}/.env)
  set -x (string split '=' $variable_pair)
end

if test -d /usr/local/share/chruby
  source /usr/local/share/chruby/chruby.fish
  source /usr/local/share/chruby/auto.fish
end

for util_file in $HOME/.config/fish/utilities/*.fish
  source $util_file
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/dan/Work/patient-registration/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/dan/Work/patient-registration/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/dan/Work/patient-registration/node_modules/tabtab/.completions/sls.fish ]; and . /Users/dan/Work/patient-registration/node_modules/tabtab/.completions/sls.fish
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/dan/Work/patient-registration/node_modules/tabtab/.completions/slss.fish ]; and . /Users/dan/Work/patient-registration/node_modules/tabtab/.completions/slss.fish
