echo "Welcome to Employee Wage Computation Program on Master Branch"

#Constants
WAGE_PER_HOUR=20
FULL_DAY_HOUR=8
PART_TIME_HOUR=4
WORKING_DAYS_PER_MONTH=20
MAX_WORKING_HOURS=100

#Variables
totalWorkingDays=0
totalWorkingHours=0
totalWage=0

declare -A dailyWageDictionary

function getWorkHours(){
case $1 in
1) workHours=$FULL_DAY_HOUR;;
2) workHours=$PART_TIME_HOUR;;
*) workHours=0;;
esac
echo $workHours
}

function calculateDailyWage(){
local workHours=$1
wage=$(( workHours * WAGE_PER_HOUR ))
echo $wage
}

function calculateMonthlyWage(){
while [[ $totalWorkingDays -lt $WORKING_DAYS_PER_MONTH && $totalWorkingHours -lt $MAX_WORKING_HOURS ]]
do
((totalWorkingDays++))
workHours=$( getWorkHours $(( RANDOM%3 )) )
totalWorkingHours=$(( totalWorkingHours + workHours ))
dailyWage=$( calculateDailyWage $workHours )
totalWage=$(( totalWage + dailyWage ))
dailyWageDictionary["Day $totalWorkingDays"]=$dailyWage
done
echo "Total Wage for a month: $totalWage"
echo "Daily Wage: ${dailyWageDictionary[@]}"
}

function calculateWagesTillCondition(){
local condition=$1
while [[ $totalWorkingDays -lt $condition && $totalWorkingHours -lt $MAX_WORKING_HOURS ]]
do
((totalWorkingDays++))
workHours=$( getWorkHours $(( RANDOM%3 )) )
totalWorkingHours=$(( totalWorkingHours + workHours ))
dailyWage=$( calculateDailyWage $workHours )
totalWage=$(( totalWage + dailyWage ))
dailyWageDictionary["Day $totalWorkingDays"]=$dailyWage
done
echo "Total Wage till $condition days or $MAX_WORKING_HOURS hours: $totalWage"
echo "Daily Wage: ${dailyWageDictionary[@]}"
}


#UC 1
echo "UC 1 - Daily Employee Wage Calculation"
workHours=$( getWorkHours $(( RANDOM%3 )) )
wage=$( calculateDailyWage $workHours )
echo "Daily Wage: $wage"
