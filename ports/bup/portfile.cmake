vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cnSchwarzer/BilibiliUp
    REF 11bb37bfc096a7480776b9b90c2d5d842c9d7e97
    SHA512 b50315957a685938ef2abbdea8a64bcd7c2d1e605da46094243dbfea5e6904bfdce6dd4b913060709c9bfb5761c029ccf8ddfa48d6e30abd93386f5f06df0291
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