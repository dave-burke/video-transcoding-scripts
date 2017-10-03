#!/bin/bash

set -e

if [[ $# -eq 0 ]]; then
    cat <<EOF
Usage: $0 [TYPE] [transcode-video.sh options] [FILENAME]

Types:

    --animation = --tune animation --filter nlmeans=medium --filter nlmeans-tune=animation"
    --cgi       = --filter nlmeans=light"
    --film      = --tune film --filter nlmeans=light --filter nlmeans-tune=film"
    --grain     = --tune grain --filter nlmeans=light --filter nlmeans-tune=grain"
    --bsg       = --tune film --filter nlmeans=light --filter nlmeans-tune=highmotion"
    [default]   = --filter nlmeans=light"

Common transcode-video.sh options are:

    --title NUMBER  select numbered title in video media (default: 1)
                        (\`0\` to scan media, list title numbers and exit)
    --chapters NUMBER[-NUMBER]
                    select chapters, single or range (default: all)
    --mkv           output Matroska format instead of MP4
    --output        provide an alternative name for the output file.
    --burn TRACK    burn subtitle track (default: first forced track, if any)
    --add-audio TRACK[,NAME]
                    add audio track in AAC format with optional name
                        (can be used multiple times)
    --add-subtitle [forced,]TRACK
                    add subtitle track with optional forced playback flag
                        (can be used multiple times)
    --add-srt [ENCODING,][OFFSET,][LANGUAGE,][forced,]FILENAME
                    add subtitle track from SubRip-format \`.srt\` text file
                        with optional character set encoding (default: latin1)
                        with optional +/- offset in milliseconds (default: 0)
                        with optional ISO 639-2 language code (default: und)
                        with optional forced playback flag
                        (values before filename can appear in any order)
                        (can be used multiple times)

Check audo/subtitle track numbers with 'transcode --title 0 [FILENAME]'

EOF
fi

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
	--cgi)
		ARGS+="--filter nlmeans=light"
		shift
		;;
	--film)
		ARGS+="--tune film --filter nlmeans=light --filter nlmeans-tune=film"
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
		ARGS+="--filter nlmeans=light"
		#don't shift, $1 is still relevant
		;;
esac

echo "${COMMAND} ${ARGS} ${@}"
"${COMMAND}" ${ARGS} "${@}"

