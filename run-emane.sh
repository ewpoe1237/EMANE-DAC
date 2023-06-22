#!/usr/bin/env bash

CURR_EXP_RANGE=0-2

usage()
{
    echo
    echo " usage: run-emane build [BUILD OPTIONS]... EXPNUM"
    echo "        run-emane start [START OPTIONS]... EXPNUM"
    echo "        run-emane stop  [STOP OPTIONS]... EXPNUM "
    echo "        run-emane clean [STOP OPTIONS]... EXPNUM "
    echo "        run-emane help"
    echo
    echo " build options:"
    # echo "  -n NUMBER     Sample build option"
    echo
    echo " start options:"
    echo "  -s FILE       File to run systems experiment control"
    echo "  -f FILE       EMANE-ARGoS Manager log file"
    echo "  -l LEVEL      EMANE-ARGoS Manager log level [0-5]"
    echo
    echo " stop options:"
    # echo "  -n NUMBER     Sample stop option"
    echo
    echo " clean options:"
    # echo "  -n NUMBER     Sample stop option"
    echo
}

if [ $EUID -ne 0 ]; then
    echo "You must be root to run this script"
    exit 1
fi

case "$1" in
    build)
        OPTIND=2
        # build_opt=

        # # process options
        # while getopts ":n" opt; do
        #     case $opt in
        #         n)
        #             build_opt=0
        #         ;;
        #         \?)
        #             echo "Invalid option: -$OPTARG" >&2
        #             exit 1
        #         ;;
        #     esac
        # done

        # Shift mode keyword (in this case: build) out
        shift $((OPTIND - 1))

        if [ $# -ne 1 ]; then
            echo "Invalid number of parameters" >&2
            exit 1
        fi

        shopt -s extglob
        exp_id=$1

        if [[ $exp_id != +([$CURR_EXP_RANGE]) ]]; then
            echo "Invalid experiment ID: $exp_id"
            exit 1
        fi

        echo "Build EMANE"

        cd exp-0"$exp_id" || return
        make

    ;;
    start)
        OPTIND=2
        sys_file=
        log_file=
        log_level=

        # process options
        while getopts ":s:f:l" opt; do
            case $opt in
                s)
                    sys_file="-s $OPTARG"
                ;;
                f)
                    log_file="-f $OPTARG"
                ;;
                l)
                    log_level="-l $OPTARG"
                ;;
                \?)
                    echo "Invalid option: -$OPTARG" >&2
                    exit 1
                ;;
            esac
        done

        # Shift mode keyword (in this case: start) out
        shift $((OPTIND - 1))

        if [ $# -ne 1 ]; then
            echo "Invalid number of parameters" >&2
            exit 1
        fi

        shopt -s extglob
        exp_id=$1

        if [[ $exp_id != +([$CURR_EXP_RANGE]) ]]; then
            echo "Invalid experiment ID: $exp_id"
            exit 1
        fi

        echo "Start EMANE"

        cd exp-0"$exp_id" || return
        letce2 lxc start
        sleep 5

        echo "Start Manager"

        # Go to emane-argos.py
        echo emane-argos.py "$sys_file" "$log_file" "$log_level"
    ;;
    stop)
        OPTIND=2
        # stop_opt=

        # # process options
        # while getopts ":n" opt; do
        #     case $opt in
        #         n)
        #             stop_opt=0
        #         ;;
        #         \?)
        #             echo "Invalid option: -$OPTARG" >&2
        #             exit 1
        #         ;;
        #     esac
        # done

        # Shift mode keyword (in this case: stop) out
        shift $((OPTIND - 1))

        if [ $# -ne 1 ]; then
            echo "Invalid number of parameters" >&2
            exit 1
        fi

        shopt -s extglob
        exp_id=$1

        if [[ $exp_id != +([$CURR_EXP_RANGE]) ]]; then
            echo "Invalid experiment ID: $exp_id"
            exit 1
        fi

        echo "Stop Manager"
        # Assume this isn't getting called mid-experiment and ARGoS-EMANE has
        # already quit cleanly

        echo "Stop EMANE"
        cd exp-0"$exp_id" || return
        letce2 lxc stop

    ;;
    clean)
        OPTIND=2
        #clean_opt=

        # process options
        # while getopts ":n" opt; do
        #     case $opt in
        #         n)
        #             clean_opt=0
        #         ;;
        #         \?)
        #             echo "Invalid option: -$OPTARG" >&2
        #             exit 1
        #         ;;
        #     esac
        # done

        # Shift mode keyword (in this case: clean) out
        shift $((OPTIND - 1))

        if [ $# -ne 1 ]; then
            echo "Invalid number of parameters" >&2
            exit 1
        fi

        shopt -s extglob
        exp_id=$1

        if [[ $exp_id != +([$CURR_EXP_RANGE]) ]]; then
            echo "Invalid experiment ID: $exp_id"
            exit 1
        fi

        echo "Clean EMANE"

        cd exp-0"$exp_id" || return
        make clean
    ;;
    help)
        usage
        exit 0
    ;;
    *)
        usage
        exit 1
    ;;
esac