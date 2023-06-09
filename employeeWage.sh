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
#UC 2
echo "UC 2 - Part Time Employee & Wage Calculation"
workHours=$PART_TIME_HOUR
wage=$( calculateDailyWage $workHours )
echo "Daily Wage: $wage"
#UC 3
echo "UC 3 - Solving using Switch Case Statement"
workHours=$( getWorkHours $(( RANDOM%3 )) )
wage=$( calculateDailyWage $workHours )
echo "Daily Wage: $wage"
#UC 4
echo "UC 4 - Monthly Employee Wage Calculation"
calculateMonthlyWage
#UC 5
echo "UC 5 - Employee Wage Calculation till Condition is Reached"
calculateWagesTillCondition 20

#UC 6
echo "UC 6 - Refactoring using Function to get Work Hours"
calculateMonthlyWage
#UC 8
echo "UC 8 - Store the Daily Wage along with the Total Wage"
echo "Total Wage: $totalWage"
echo "Daily Wage: ${dailyWageDictionary[@]}"

#UC 9
echo "UC 9 - Store the Day and the Daily Wage along with the Total Wage"
for key in "${!dailyWageDictionary[@]}";
do
    echo "$key: ${dailyWageDictionary[$key]}"
done
