vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cnSchwarzer/BilibiliUp
    REF b733c472f117de1403a849bb9597cad19514940a
    SHA512 348788e95fdece78da6f8955154d5735d4b2e15f7ff898106a7e401640392ca3178ef8f5097041c7dc0cf96d12bdc538d27c940045dfdf6182cb1696ed2f2825
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