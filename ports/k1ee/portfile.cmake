vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cnSchwarzer/k1ee
    REF 83f1f19e88e1074fdb9e688721cac55af55791f1
    SHA512 e34af619b60bbb0f1171102d39dafe69edd0e170bf83eaa49a1021c94142d9f1ec57fa4ee5e6e6eaaa45cba86b75033155fe2ee9f1021c70b0fbc79747650213
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