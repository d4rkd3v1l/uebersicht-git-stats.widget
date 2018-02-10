#!/bin/sh
source "git-stats.widget/config.sh"

cd "$repoPath"

firstCommitTimeStamp=$(git log --pretty=%at | tail -1)
currentTimeStamp=$(date +%s)
totalDays=$(((currentTimeStamp-firstCommitTimeStamp)/86400))

function getRepoAge
{
	if [ "$totalDays" -gt "365" ]; then
    	years=$((totalDays/365))
    	days=$((totalDays%365))
    	months=$((days/30))
    	age="$years years, $months months"
	elif [ "$totalDays" -gt "30" ]; then
		months=$(($totalDays/30))
		days=$((totalDays%30))
		age="$months months, $days days"
    else
    	age="$totalDays days"
	fi

	echo $age
}

commitCount=$(git rev-list HEAD --count)
fileCount=$(git ls-files | wc -l)

results="{
	\"repoName\":\"$(basename "$repoPath")\",
	\"commitCount\":\"$commitCount\",
	\"commitsPerDay\":\"$(echo "scale=2; $commitCount/$totalDays" | bc | sed 's/^\./0./')\",
	\"commitCountByDev\":\"<table>$(git shortlog -s -n HEAD | head -5 | tr '\t' ' ' | awk '{printf "<tr><td>%s.&nbsp;</td><td>%-2s&nbsp;%2s&nbsp;</td><td>%d&nbsp;</td><td>(%.2f%s)</td></tr>", NR,$2,$3,$1,$1/'"$commitCount"'*100,"%"}')</table>\",
	\"repoAge\":\"$(getRepoAge)\",
	\"fileCount\":\"$fileCount\",
	\"fileCountByType\":\"<table>$(git ls-files | awk -F . '{print $NF}' | sort | uniq -c | sort -n -r  | head -5 | awk '{printf "<tr><td>%s.&nbsp;</td><td>%s&nbsp;</td><td>%d&nbsp;</td><td>(%.2f%s)</td></tr>", NR,$2,$1,$1/'"$fileCount"'*100,"%"}')</table>\"
}"

echo "$results"
