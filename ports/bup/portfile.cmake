vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cnSchwarzer/BilibiliUp
    REF 11bb37bfc096a7480776b9b90c2d5d842c9d7e97
    SHA512 20a3c6d9aab866027ee809dfa4bca5b1476f2f459919be46319a5ca64413efe5c5bde277b1b434ebc6af13d222d959ced178697cef925cb8caf348b2af41efec
    HEAD_REF main
) 

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA 
    OPTIONS_DEBUG
        -DCMAKE_USE_FIDDLER_PROXY=ON 
)

vcpkg_install_cmake() 
 
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/bup)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)