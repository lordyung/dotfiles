function git-nuke
{
    # Nukes a branch locally and on the origin remote.
    #
    # $1 - Branch name.
    #
    # Examples
    #
    #   git nuke add-git-nuke

    git branch -D $1
    git push origin :$1
}
function git_promote
{
    #
    # Promotes a local topic branch to a remote tracking branch of the same name,
    # by pushing and then setting up the git config
    #
    # Thanks to ENTP:
    # http://hoth.entp.com/2008/11/10/improving-my-git-workflow

    curr_branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')

    remote_branch=$(git branch -r | grep "origin/${curr_branch}")
    [ -z "${remote_branch}" ] && ( git push origin "${curr_branch}" )

    origin=$(git config --get "branch.${curr_branch}.remote")
    [ -z "${origin}" ] && ( git config --add "branch.${curr_branch}.remote" origin )

    merge=$(git config --get "branch.${curr_branch}.merge")
    [ -z "${merge}" ] && ( git config --add "branch.${curr_branch}.merge" "refs/heads/${curr_branch}" )
}
function git_track
{
    # Sets up your branch to track a remote branch. Assumes you mean
    # `origin/$branch-name`.

    branch=$(git rev-parse --abbrev-ref HEAD)
    git branch $branch --set-upstream-to origin/$branch
}
function git_undo
{
    # Undo your last commit, but don't throw away your changes
    git reset --soft HEAD^
}
function git_unpushed
{
    #
    # Show the diff of everything you haven't pushed yet.

    branch=$(git rev-parse --abbrev-ref HEAD)
    git diff origin/$branch..HEAD
}
function git_unpushed_stat
{

    # Show the diffstat of everything you haven't pushed yet.

    branch=$(git rev-parse --abbrev-ref HEAD)
    count=$(git rev-list --count HEAD origin/$branch...HEAD)

    if [ "$count" -eq "1" ]
    then
        s=''
    else
        s='s'
    fi

    git diff --stat origin/$branch..HEAD
    echo " $count commit$s total"
}
