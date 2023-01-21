Import-Module .\GitInspectorModule.psm1

$team = "team3"
$repofolder = "..\\repos\\internship-desktoptool-v2-2223-team3"
$destination ="..\\reports"

$branch = "development"
$extensions = "cs,xaml"
$platform = "dotnet"

$startdate = "12-12-2022"
$enddate = "15-01-2023"

New-Report -repofolder $repofolder -branch $branch -team $team -destination $destination -extensions $extensions -platform $platform -startdate $startdate -enddate $enddate
