abbr -a gco git checkout
abbr -a gg git grep -n
abbr -a gcam git commit -a -m

function gdbr -d "Deletes all branches beginning with the specified string"
  for branchname in (git branch | string trim)
    set match_pattern {$argv}"*"
    switch $branchname
    case $match_pattern
      git branch -D $branchname
    end
  end
  git fetch --prune
end

function gddbr -d "Deletes all git branches beginning with 'dd_'"
  gdbr dd_
end

function gfr -d "Find and replace all occurrences of a string in all tracked files"
  set original_text $argv[1]
  set new_text $argv[2]
  for affected_file in (git grep -l $original_text)
    sed -i '' -e "s/$original_text/$new_text/g" $affected_file
  end
end

