#!/bin/bash

echo Starting job service...

runner_pid=

kill_runner() {
	kill $runner_pid 2> /dev/null
}

trap kill_runner SIGTERM

while true; do
	if [ -e LocalSettings.php ]; then
		# Limit the number of jobs on each batch.  The --wait parameter
		# will pause the execution here until new jobs are added, to
		# avoid running the loop without anything to do:
		php maintenance/runJobs.php --wait --maxjobs=1 &
		runner_pid=$!
		wait $runner_pid
	else
		echo "No LocalSettings.php - trying again in 10 seconds."
		sleep 10
        fi
done
