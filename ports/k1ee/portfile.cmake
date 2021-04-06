vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cnSchwarzer/k1ee
    REF 6b757267682b72020958cae334b1d07a0c5b12f2
    SHA512 c3590c0af6ba4dc9f9646061ab027717c6b9e3118a415fd7b9013c3d253f03b551f7f074269283d685ea51b26c848a8a10644a3d24d2f646371e9fd5da4d4092
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