# Bundler handlers taken from https://github.com/oh-my-fish/plugin-bundler
# appends `bundle exec` to gem executable invocation if in a bundled context

function __is_a_bundled_executable
  if type -q bundle
    set -l bindir (command bundle exec ruby -e "puts Gem.bindir")
    test -f "$bindir/$argv"
  else
    return 1
  end
end

function __execute_as_bundler
  if __is_a_bundled_executable $argv[1]
    command bundle exec $argv
  else
    eval command $argv
  end
end

alias be="bundle exec"
alias bl="bundle list"
alias bp="bundle package"
alias bo="bundle open"
alias bout="bundle outdated"
alias bu="bundle update"
alias bi="bundle install"
alias bcn="bundle clean"

set -l execs annotate      \
             cap           \
             capify        \
             cucumber      \
             dashing       \
             guard         \
             kitchen       \
             middleman     \
             nanoc         \
             puma          \
             rackup        \
             rainbows      \
             rake          \
             rspec         \
             rubocop       \
             shotgun       \
             sidekiq       \
             spec          \
             spinach       \
             spork         \
             thin          \
             thor          \
             unicorn       \
             unicorn_rails

if set -q bundler_plugin_execs
  set execs $execs $bundler_plugin_execs
end

# Fish 2.1.1+ has support for --inherit-variable
set -l do_eval (echo $FISH_VERSION | grep 2.1.1-)

for executable in $execs
  if test -z "$do_eval"
    eval "function $executable; __execute_as_bundler $executable \$argv; end"
  else
    function $executable --inherit-variable executable
      __execute_as_bundler $executable $argv
    end
  end
end

