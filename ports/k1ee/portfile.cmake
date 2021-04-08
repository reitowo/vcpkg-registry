vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cnSchwarzer/k1ee
    REF 116a04cfddcf08b90d9a372ab0b025f1bb83b178
    SHA512 089890fc942019686a53fd474d7c7703d5c03cbd3722b214fa2b9bbce8edf0d5da2d1d727b77aaea37e72e99b11cff329fece5c6015d9d5d85c950bef523e38e
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