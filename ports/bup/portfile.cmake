vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cnSchwarzer/BilibiliUp
    REF 1b027df6ef92974aa7d7b288fb84fe78e73133ef
    SHA512 6465396d21331e46c8074c5b546816f97900c992916027c566b73f18d2c7d274ef325151f175dc7ef8db279c00adc24f77794922a5819227ea1a2f2121563a54
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