#!/usr/bin/env bash

MERLIN_ROOT=$(realpath ..)

GPL_ROOT=${1}
MODEL=${2}
SDK=${3}

PREBUILD_DIRS=$(find "${MERLIN_ROOT}/release/src/router" -name 'prebuil*' -type d)

for prebuild_dir in ${PREBUILD_DIRS}; do
    if [ -e "${prebuild_dir}/${SDK}" ]; then
        echo "INFO: creating symlink from ${MODEL} to ${SDK} in ${prebuild_dir}"
        pushd "${prebuild_dir}" 1>/dev/null
        rm -rf "${MODEL}"
        ln -sf "${SDK}" "${MODEL}"
        popd 1>/dev/null
    elif ls ${prebuild_dir}/RT* ${prebuild_dir}/GT* 1>/dev/null 2>&1; then
        prebuild_relative_path=$(realpath --relative-to="${MERLIN_ROOT}" "${prebuild_dir}")
        gpl_prebuild_dir="${GPL_ROOT}/${prebuild_relative_path}"
        if [ -e "${gpl_prebuild_dir}" ]; then
            echo "INFO: copying ${prebuild_relative_path} from GPL to MERLIN"
            mkdir -p "${prebuild_dir}/${MODEL}"
            cp -r "${gpl_prebuild_dir}"/* "${prebuild_dir}/${MODEL}"
        else
            echo "WARNING: no ${prebuild_relative_path} in GPL"
        fi
    fi
done
