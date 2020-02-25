function mutasync
    set -l command "$argv[1]"
    if contains $command 'monitor' 'flush' 'pause' 'resume'
    else
        mutagen sync list | grep -E '^(Name|Status|----)' | cat
        return 0
    end

    set -l select (mutagen sync list | grep 'Name: ' | cut -d ' ' -f 2 | fzf)
    if test -n "$select"
        mutagen sync "$command" "$select"
    end
end
