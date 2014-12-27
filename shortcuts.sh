#!/bin/bash

COMMAND="transcode-video.sh"

case $1 in
	--animation)
		ARGS="--small --tune animation --filter denoise=medium"
		shift
		;;
	--film)
		ARGS="--small --tune film"
		shift
		;;
	--grain)
		ARGS="--small --tune grain --filter nlmeans=light --filter nlmeans-tune=grain"
		shift
		;;
	--bsg)
		ARGS="--small --tune film --filter nlmeans=light --filter nlmeans-tune=highmotion"
		shift
		;;
	--sw)
		ARGS="--crop 58:58:0:0 --tune film"
		shift
		;;
	*)
		ARGS="--small"
		#don't shift, $1 is still relevant
		;;
esac

"${COMMAND}" ${ARGS} "${@}"
