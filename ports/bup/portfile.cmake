vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cnSchwarzer/BilibiliUp
    REF 0025e66cc2b6dcbbfcd13aeb2455048f0f3ef371
    SHA512 fb6d1ae48db70512ff1be7f4676a049697fd57d5a8aca639ad088959df7dcfb8dd48145360c55d0de3673db94e8cab3e63f6869ab97157fee7c42de4314b5d79
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