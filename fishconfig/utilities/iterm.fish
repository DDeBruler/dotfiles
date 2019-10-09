# Taken from https://github.com/oh-my-fish/plugin-title/blob/master/functions/title.fish

function title -d "Change current terminal title"
  if [ (count $argv) -lt 1 ]
      echo "You need to specify a title to set"
      return 1
  end
  
  echo "function fish_title; echo \"$argv\"; end" | source -
end

function untitle -d "Reset terminal title to default behavior"
  functions -e fish_title
end

