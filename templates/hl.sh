#!/bin/bash

usage_exit() {
	echo "Usage: $0 [rRnNxX] lock_file program [ arg ... ]" 1>&2
	echo "-r : notify only error end. (default)" 1>&2
	echo "-R : notify always." 1>&2
	echo "-n : do not wait if can't get lockfile. (default)" 1>&2
	echo "-N : wait if can't get lockfile." 1>&2
	echo "-x : normal end if can't get lockfile." 1>&2
	echo "-X : error end if can't get lockfile. (default)" 1>&2
	exit 1
}

# for slack_reporter.pl
# see also https://gist.github.com/acidlemon/f8faacd20e575fff05cf67a254ab6bc7
export SLACK_ENDPOINT="{{ slack_endpoint }}"
export SLACK_USERNAME="horenso"

# if not defined ${SLACK_CHANNEL} 
if [ -z "${SLACK_CHANNEL+x}" ] ; then
	export SLACK_CHANNEL="{{ slack_channel }}"
fi

# default values
export SLACK_MUTE_ON_NORMAL=1
LOCK_WAIT="-n"
LOCK_END="-X"

while getopts "rRnNxXh" OPT
do
	case $OPT in
		r)  export SLACK_MUTE_ON_NORMAL=1
			;;
		R)  export SLACK_MUTE_ON_NORMAL=0
			;;
		n)  LOCK_WAIT="-n"
			;;
		N)  LOCK_WAIT="-N"
			;;
		x)  LOCK_END="-x"
			;;
		X)  LOCK_END="-X"
			;;
		h)  usage_exit
			;;
		\?) usage_exit
			;;
	esac
done

shift $((OPTIND - 1))

LOCK_FILE="$1"
shift

/bin/horenso -r /bin/slack_reporter.pl -- \
/bin/setlock ${LOCK_WAIT} ${LOCK_END} ${LOCK_FILE} \
$@
