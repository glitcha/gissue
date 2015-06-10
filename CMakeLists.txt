# project name
project (gissue)

# the oldest stable cmake version we support
cmake_minimum_required (VERSION 2.6)

# build the markdown lib
include(ExternalProject)
set(DISCOUNT_DEP_PATH ${CMAKE_SOURCE_DIR}/deps/discount)
set(DISCOUNT_LIB_PATH ${CMAKE_BINARY_DIR}/libmarkdown.a)
set(DISCOUNT_INCLUDE_PATH ${DISCOUNT_DEP_PATH})

ExternalProject_Add(discount
  PREFIX ${DISCOUNT_DEP_PATH}
  SOURCE_DIR ${DISCOUNT_DEP_PATH}
  CONFIGURE_COMMAND
      ${DISCOUNT_DEP_PATH}/configure.sh --src=${DISCOUNT_DEP_PATH}
                                        --prefix=${CMAKE_BINARY_DIR}
                                        --libdir=${CMAKE_BINARY_DIR}
                                        --with-fenced-code
  BUILD_COMMAND make install
  BUILD_IN_SOURCE 1
)

include_directories(${DISCOUNT_INCLUDE_PATH})

# disable C compiler warnings
add_definitions(-w)

# tell cmake where its modules can be found in our project directory
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# where we install data directory (if we have any)
set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

# what to call that directory where we install data too
set (PKGDATADIR "${DATADIR}/gissue")
set (EXEC_NAME "gissue")
set (RELEASE_NAME "Release")
set (VERSION "0.1")
set (VERSION_INFO "Github issue reader.")
set (CMAKE_C_FLAGS "-ggdb")
set (PREFIX ${CMAKE_INSTALL_PREFIX})
set (DOLLAR "$")

# we're about to use pkgconfig to make sure dependencies are installed so let's find pkgconfig first
find_package(PkgConfig)

# now let's actually check for the required dependencies
pkg_check_modules (DEPS REQUIRED
    gobject-2.0
    glib-2.0
    gio-2.0
    gee-0.8
    gtk+-3.0>=3.11.6
    granite
    libsoup-2.4
    webkitgtk-3.0>=1.4.3
)
pkg_check_modules(JSON REQUIRED json-glib-1.0>=0.14)

add_definitions(${DEPS_CFLAGS} ${JSON_CFLAGS} ${JSON_CFLAGS_OTHER} )
add_definitions(-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")

link_libraries(${DEPS_LIBRARIES} ${JSON_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS} ${JSON_DIRS})

# make sure we have vala
find_package(Vala REQUIRED)

# make sure we use vala
include(ValaVersion)

# make sure it's the desired version of vala
ensure_vala_version("0.29" MINIMUM)


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
    src/ui/UIIssueViewer.vala
PACKAGES
    gtk+-3.0
    libsoup-2.4
    json-glib-1.0
    gee-0.8
    granite
    webkitgtk-3.0
    discount
OPTIONS
    --vapidir=${CMAKE_SOURCE_DIR}/vapi
)
# tell cmake what to call the executable we just made
add_executable(${EXEC_NAME} ${VALA_C} ${generated_resources})

add_dependencies(gissue discount)

target_link_libraries(${EXEC_NAME} ${DISCOUNT_LIB_PATH})

# install the binaries we just made
install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

# install our .desktop file so the Applications menu will see it
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/hello.desktop DESTINATION ${DATADIR}/applications/)