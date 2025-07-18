# What LSF Job ID to track?
lsfJobId=$1

# Give a name to the logfile
logName=$2

# Period between job monitor samples
monitorPeriodSeconds=$3

# Begin monitoring...
logfile=$logName_$lsfJobId.log
echo "Starting to track Job ID $lsfJobId..."

# Initial check of the Job ID
jobStatusLineCount=`bjobs $lsfJobId 2>&1 | wc -l`

# Keep monitoring if the job is returning run information
while [ "$jobStatusLineCount" != "1" ]; do
  date;
  echo "Job $lsfJobId is still running...";
  echo "****************************************************************" >> $logfile;
  date >> $logfile;
  bjobs -l $lsfJobId >> $logfile;
  sleep "${monitorPeriodSeconds}s";
  jobStatusLineCount=`bjobs $lsfJobId 2>&1 | wc -l`
done

date;
echo "Job $lsfJobId is complete."
