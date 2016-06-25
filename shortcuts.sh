#!/bin/bash

if command -v realpath > /dev/null; then
	dir=$(dirname $(realpath ${0}))
else
	dir="$(cd $(dirname ${0}); pwd)"
fi

COMMAND="${dir}/transcode-video.sh"
ARGS="--small --filter decomb "

case $1 in
	--animation)
		ARGS+="--tune animation --filter nlmeans=medium --filter nlmeans-tune=animation"
		shift
		;;
	--film)
		ARGS+="--tune film"
		shift
		;;
	--grain)
		ARGS+="--tune grain --filter nlmeans=light --filter nlmeans-tune=grain"
		shift
		;;
	--bsg)
		ARGS+="--tune film --filter nlmeans=light --filter nlmeans-tune=highmotion"
		shift
		;;
	*)
		ARGS+="--tune film --filter nlmeans=light --filter nlmeans-tune=film"
		#don't shift, $1 is still relevant
		;;
esac

"${COMMAND}" ${ARGS} "${@}"

