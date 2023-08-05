set -gx PATH {$HOME}/bin $PATH

for variable_pair in (cat {$HOME}/.env)
  set -x (string split '=' $variable_pair)
end

if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
else if test -e /usr/local/opt/asdf/asdf.fish
  source /usr/local/opt/asdf/asdf.fish
else if test -d /usr/local/share/chruby
  source /usr/local/share/chruby/chruby.fish
  source /usr/local/share/chruby/auto.fish
end


for util_file in $HOME/.config/fish/utilities/*.fish
  source $util_file
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
