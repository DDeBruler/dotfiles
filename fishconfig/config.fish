set -gx PATH {$HOME}/bin {$HOME}/.local/bin $PATH
set -gx OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

for variable_pair in (cat {$HOME}/.env)
  set -x (string split '=' $variable_pair)
end

if test -e /usr/local/opt/postgresql@15
  set -gx PATH /usr/local/opt/postgresql@15/bin $PATH
  set -gx LDFLAGS "-L/usr/local/opt/postgresql@15/lib"
  set -gx CPPFLAGS "-I/usr/local/opt/postgresql@15/include"
end


if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
else if test -e /usr/local/opt/asdf/asdf.fish
  source /usr/local/opt/asdf/asdf.fish
else if test -e /usr/local/opt/asdf/libexec/asdf.fish
  source /usr/local/opt/asdf/libexec/asdf.fish
else if test -d /usr/local/share/chruby
  source /usr/local/share/chruby/chruby.fish
  source /usr/local/share/chruby/auto.fish
end


for util_file in $HOME/.config/fish/utilities/*.fish
  source $util_file
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
