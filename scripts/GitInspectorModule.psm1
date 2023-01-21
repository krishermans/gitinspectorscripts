function New-Report ([string] $repofolder, [string] $branch, [string] $team,
                     [string] $destination, [string] $extensions, [string] $platform,
                     [string] $startdate, [string] $enddate)
{
    if (!(Test-Path -Path $repofolder)) {
        Write-Error "Repository folder does not exist: $repofolder" -ErrorAction Stop
    }
    
    Start-Process `
        -FilePath "git" `
        -WorkingDirectory $repofolder `
        -ArgumentList "checkout $branch" `
        -Wait -NoNewWindow

    Start-Process `
        -FilePath "git" `
        -WorkingDirectory $repofolder `
        -ArgumentList "pull" `
        -Wait -NoNewWindow

    $absRepoFolder = Resolve-Path -Path $repofolder

    Start-Process `
        -FilePath "docker" `
        -ArgumentList "run --rm -v ${absRepoFolder}:/repo felix/gitinspector:0.4.4 --format=html --file=$extensions --grading=true --metrics=true --responsibilities=true --timeline=true --since=$startdate --until=$enddate" `
        -Wait -NoNewWindow `
        -RedirectStandardOutput "$destination\\$team-$platform.html"
    # docker run --rm -v ${absRepoFolder}:/repo felix/gitinspector:0.4.4 --format=html --file=$extensions --grading=true --metrics=true --responsibilities=true --timeline=true --since=$startdate --until=$enddate > "$destination\\$team-$platform.html"
}