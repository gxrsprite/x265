if(NOT EXISTS "G:/Projects/x265-master/dest/install_manifest.txt")
    message(FATAL_ERROR "Cannot find install manifest: 'G:/Projects/x265-master/dest/install_manifest.txt'")
endif()

file(READ "G:/Projects/x265-master/dest/install_manifest.txt" files)
string(REGEX REPLACE "\n" ";" files "${files}")
foreach(file ${files})
    message(STATUS "Uninstalling $ENV{DESTDIR}${file}")
    if(EXISTS "$ENV{DESTDIR}${file}" OR IS_SYMLINK "$ENV{DESTDIR}${file}")
        exec_program("F:/Program Files/CMake/bin/cmake.exe" ARGS "-E remove \"$ENV{DESTDIR}${file}\""
                     OUTPUT_VARIABLE rm_out
                     RETURN_VALUE rm_retval)
        if(NOT "${rm_retval}" STREQUAL 0)
            message(FATAL_ERROR "Problem when removing '$ENV{DESTDIR}${file}'")
        endif(NOT "${rm_retval}" STREQUAL 0)
    else()
        message(STATUS "File '$ENV{DESTDIR}${file}' does not exist.")
    endif()
endforeach(file)

if(EXISTS "${CMAKE_CURRENT_BINARY_DIR}/install_manifest.txt")
    file(REMOVE "${CMAKE_CURRENT_BINARY_DIR}/install_manifest.txt")
endif()
