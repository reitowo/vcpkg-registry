vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cnSchwarzer/k1ee
    REF 9839810013b1c40b570e60f1c763b28ce2b4d8ca
    SHA512 47fdd1edae3671963e4d299cc5be60fd9f42f97247b583d1bc3496903ae26aa647978e876c4a037eb3ff3063f2db913dadec7b249c1e328733a20503b58abd12
    HEAD_REF main
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 
        -DBUILD_K1EE_TESTS=OFF   
)

vcpkg_install_cmake() 
 
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/k1ee)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)