# project name
project (gissue)

# the oldest stable cmake version we support
cmake_minimum_required (VERSION 2.6)

# tell cmake where its modules can be found in our project directory
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# where we install data directory (if we have any)
set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

# what to call that directory where we install data too
set (PKGDATADIR "${DATADIR}/gissue")
set (EXEC_NAME "gissue")
set (RELEASE_NAME "A hello world.")
set (VERSION "0.1")
set (VERSION_INFO "whats up world")

# we're about to use pkgconfig to make sure dependencies are installed so let's find pkgconfig first
find_package(PkgConfig)

# now let's actually check for the required dependencies
pkg_check_modules (DEPS REQUIRED
    gobject-2.0
    glib-2.0
    gio-2.0
    gee-1.0
    gtk+-3.0>=3.11.6
    granite
    libsoup-2.4
)
pkg_check_modules(JSON REQUIRED json-glib-1.0>=0.14)

add_definitions(${DEPS_CFLAGS} ${JSON_CFLAGS} ${JSON_CFLAGS_OTHER} )
link_libraries(${DEPS_LIBRARIES} ${JSON_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS} ${JSON_DIRS})

# make sure we have vala
find_package(Vala REQUIRED)

# make sure we use vala
include(ValaVersion)

# make sure it's the desired version of vala
ensure_vala_version("0.16" MINIMUM)

# files we want to compile
include(ValaPrecompile)
vala_precompile(VALA_C ${EXEC_NAME}
    src/main.vala
    src/GitHubAPI.vala
    src/GitHubAPIIssue.vala
    src/GissueApplication.vala
    src/ui/UIMain.vala
    src/ui/UIIssueList.vala
    src/ui/UIIssueRow.vala
PACKAGES
    gtk+-3.0
    libsoup-2.4
    json-glib-1.0
    gee-0.8
    granite
)
# tell cmake what to call the executable we just made
add_executable(${EXEC_NAME} ${VALA_C})

# install the binaries we just made
install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

# install our .desktop file so the Applications menu will see it
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/hello.desktop DESTINATION ${DATADIR}/applications/)