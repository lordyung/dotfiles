" Vim syntax file
" Program:      CMake - Cross-Platform Makefile Generator
" Module:       after/syntax/cmake.vim
" Remark:	This is an after/syntax file. The default
"		syntax/cmake.vim is still needed to run this file.
" Language:     CMake
" Author:       Timothy Madden <terminatorul@gmail.com>
" Maintainer:   Timothy Madden <terminatorul@gmail.com>
" Last Change:  2014 May 15
" Version:      0.1

" Licence:      The CMake license applies to this file. See
"               http://www.cmake.org/HTML/Copyright.html
"               This implies that distribution with Vim is allowed

" GetLatestVimScripts: 1 1 :AutoInstall: after/syntax/cmake.vim


let s:keepcpo= &cpo
set cpo&vim

if !exists('b:current_syntax') || b:current_syntax != 'cmake'
    finish
endif

" generated from `cmake` command v2.8.12 with: `cmake --help-command-list | tr "\r\n" " "`
syntax keyword cmakeStatement
    \ add_compile_options add_custom_command add_custom_target add_definitions add_dependencies add_executable
    \ add_library add_subdirectory add_test aux_source_directory break build_command cmake_host_system_information
    \ cmake_minimum_required cmake_policy configure_file create_test_sourcelist define_property else elseif
    \ enable_language enable_testing endforeach endfunction endif endmacro endwhile execute_process export
    \ file find_file find_library find_package find_path find_program fltk_wrap_ui foreach function
    \ get_cmake_property get_directory_property get_filename_component get_property get_source_file_property
    \ get_target_property get_test_property if include include_directories include_external_msproject
    \ include_regular_expression install link_directories list load_cache load_command macro mark_as_advanced
    \ math message option project qt_wrap_cpp qt_wrap_ui remove_definitions return separate_arguments set
    \ set_directory_properties set_property set_source_files_properties set_target_properties set_tests_properties
    \ site_name source_group string target_compile_definitions target_compile_options target_include_directories 
    \ target_link_libraries try_compile try_run unset variable_watch while build_name exec_program
    \ export_library_dependencies install_files install_programs install_targets link_libraries make_directory 
    \ output_required_files remove subdir_depends subdirs use_mangled_mesa utility_source variable_requires 
    \ write_file

" generated from `cmake` command v2.8.12.1 with `cmake --help-variable-list | tr "\r\n" " "`
syntax keyword cmakeSystemVariables 
    \ CMAKE_AR CMAKE_ARGC CMAKE_ARGV0 CMAKE_BINARY_DIR CMAKE_BUILD_TOOL CMAKE_CACHEFILE_DIR CMAKE_CACHE_MAJOR_VERSION CMAKE_CACHE_MINOR_VERSION
    \ CMAKE_CACHE_PATCH_VERSION CMAKE_CFG_INTDIR CMAKE_COMMAND CMAKE_CROSSCOMPILING CMAKE_CTEST_COMMAND CMAKE_CURRENT_BINARY_DIR CMAKE_CURRENT_LIST_DIR
    \ CMAKE_CURRENT_LIST_FILE CMAKE_CURRENT_LIST_LINE CMAKE_CURRENT_SOURCE_DIR CMAKE_DL_LIBS CMAKE_EDIT_COMMAND CMAKE_EXECUTABLE_SUFFIX 
    \ CMAKE_EXTRA_GENERATOR CMAKE_EXTRA_SHARED_LIBRARY_SUFFIXES CMAKE_GENERATOR CMAKE_GENERATOR_TOOLSET CMAKE_HOME_DIRECTORY CMAKE_IMPORT_LIBRARY_PREFIX
    \ CMAKE_IMPORT_LIBRARY_SUFFIX CMAKE_LINK_LIBRARY_SUFFIX CMAKE_MAJOR_VERSION CMAKE_MAKE_PROGRAM CMAKE_MINIMUM_REQUIRED_VERSION CMAKE_MINOR_VERSION
    \ CMAKE_PARENT_LIST_FILE CMAKE_PATCH_VERSION CMAKE_PROJECT_NAME CMAKE_RANLIB CMAKE_ROOT CMAKE_SCRIPT_MODE_FILE CMAKE_SHARED_LIBRARY_PREFIX
    \ CMAKE_SHARED_LIBRARY_SUFFIX CMAKE_SHARED_MODULE_PREFIX CMAKE_SHARED_MODULE_SUFFIX CMAKE_SIZEOF_VOID_P CMAKE_SKIP_RPATH CMAKE_SOURCE_DIR
    \ CMAKE_STANDARD_LIBRARIES CMAKE_STATIC_LIBRARY_PREFIX CMAKE_STATIC_LIBRARY_SUFFIX CMAKE_TWEAK_VERSION CMAKE_VERBOSE_MAKEFILE CMAKE_VERSION
    \ CMAKE_VS_PLATFORM_TOOLSET CMAKE_XCODE_PLATFORM_TOOLSET PROJECT_BINARY_DIR PROJECT_NAME PROJECT_SOURCE_DIR
    \ BUILD_SHARED_LIBS CMAKE_ABSOLUTE_DESTINATION_FILES CMAKE_AUTOMOC_RELAXED_MODE CMAKE_BACKWARDS_COMPATIBILITY CMAKE_BUILD_TYPE CMAKE_COLOR_MAKEFILE
    \ CMAKE_CONFIGURATION_TYPES CMAKE_DEBUG_TARGET_PROPERTIES
    \ CMAKE_ERROR_DEPRECATED CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION CMAKE_FIND_LIBRARY_PREFIXES CMAKE_FIND_LIBRARY_SUFFIXES
    \ CMAKE_FIND_PACKAGE_WARN_NO_MODULE CMAKE_IGNORE_PATH CMAKE_INCLUDE_PATH CMAKE_INSTALL_DEFAULT_COMPONENT_NAME CMAKE_INSTALL_PREFIX
    \ CMAKE_LIBRARY_PATH CMAKE_MFC_FLAG CMAKE_MODULE_PATH CMAKE_NOT_USING_CONFIG_FLAGS CMAKE_PREFIX_PATH
    \ CMAKE_PROGRAM_PATH CMAKE_SKIP_INSTALL_ALL_DEPENDENCY CMAKE_SYSTEM_IGNORE_PATH CMAKE_SYSTEM_INCLUDE_PATH CMAKE_SYSTEM_LIBRARY_PATH
    \ CMAKE_SYSTEM_PREFIX_PATH CMAKE_SYSTEM_PROGRAM_PATH CMAKE_USER_MAKE_RULES_OVERRIDE CMAKE_WARN_DEPRECATED CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION
    \ APPLE BORLAND CMAKE_CL_64 CMAKE_COMPILER_2005 CMAKE_HOST_APPLE CMAKE_HOST_SYSTEM CMAKE_HOST_SYSTEM_NAME CMAKE_HOST_SYSTEM_PROCESSOR
    \ CMAKE_HOST_SYSTEM_VERSION CMAKE_HOST_UNIX CMAKE_HOST_WIN32 CMAKE_LIBRARY_ARCHITECTURE CMAKE_LIBRARY_ARCHITECTURE_REGEX CMAKE_OBJECT_PATH_MAX
    \ CMAKE_SYSTEM CMAKE_SYSTEM_NAME CMAKE_SYSTEM_PROCESSOR CMAKE_SYSTEM_VERSION CYGWIN ENV MSVC MSVC10 MSVC11 MSVC12 MSVC60 MSVC70 MSVC71
    \ MSVC80 MSVC90 MSVC_IDE MSVC_VERSION UNIX WIN32 XCODE_VERSION 
    \ CMAKE_ARCHIVE_OUTPUT_DIRECTORY CMAKE_AUTOMOC CMAKE_AUTOMOC_MOC_OPTIONS CMAKE_BUILD_WITH_INSTALL_RPATH CMAKE_DEBUG_POSTFIX CMAKE_EXE_LINKER_FLAGS
    \ CMAKE_Fortran_FORMAT CMAKE_Fortran_MODULE_DIRECTORY CMAKE_GNUtoMS CMAKE_INCLUDE_CURRENT_DIR
    \ CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE CMAKE_INSTALL_NAME_DIR CMAKE_INSTALL_RPATH CMAKE_INSTALL_RPATH_USE_LINK_PATH CMAKE_LIBRARY_OUTPUT_DIRECTORY
    \ CMAKE_LIBRARY_PATH_FLAG CMAKE_LINK_DEF_FILE_FLAG  CMAKE_LINK_DEPENDS_NO_SHARED CMAKE_LINK_INTERFACE_LIBRARIES CMAKE_LINK_LIBRARY_FILE_FLAG
    \ CMAKE_LINK_LIBRARY_FLAG CMAKE_MACOSX_BUNDLE CMAKE_MODULE_LINKER_FLAGS  CMAKE_NO_BUILTIN_CHRPATH
    \ CMAKE_PDB_OUTPUT_DIRECTORY CMAKE_POSITION_INDEPENDENT_CODE CMAKE_RUNTIME_OUTPUT_DIRECTORY CMAKE_SHARED_LINKER_FLAGS
    \ CMAKE_SKIP_BUILD_RPATH CMAKE_SKIP_INSTALL_RPATH CMAKE_STATIC_LINKER_FLAGS CMAKE_TRY_COMPILE_CONFIGURATION CMAKE_USE_RELATIVE_PATHS
    \ CMAKE_VISIBILITY_INLINES_HIDDEN CMAKE_WIN32_EXECUTABLE EXECUTABLE_OUTPUT_PATH LIBRARY_OUTPUT_PATH
    \ CMAKE_Fortran_MODOUT_FLAG CMAKE_INTERNAL_PLATFORM_ABI CMAKE_Fortran_MODDIR_DEFAULT CMAKE_Fortran_MODDIR_FLAG
    \ containedin=cmakeVariableValue contained

syntax match cmakeSystemVariables /\v<CMAKE_MODULE_LINKER_FLAGS_\i*>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_EXE_LINKER_FLAGS_\i*>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_POSTFIX>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_VISIBILITY_PRESET>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_POLICY_DEFAULT_CMP\d+>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_USER_MAKE_RULES_OVERRIDE_\i*>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_DISABLE_FIND_PACKAGE_\i*>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_SHARED_LINKER_FLAGS_\i*>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_STATIC_LINKER_FLAGS_\i*>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_ARCHIVE_APPEND>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_ARCHIVE_CREATE>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_ARCHIVE_FINISH>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_COMPILER>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_COMPILER_ABI>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_COMPILER_ID>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_COMPILER_LOADED>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_COMPILER_VERSION>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_COMPILE_OBJECT>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_CREATE_SHARED_LIBRARY>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_CREATE_SHARED_MODULE>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_CREATE_STATIC_LIBRARY>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_FLAGS>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_FLAGS_DEBUG>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_FLAGS_MINSIZEREL>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_FLAGS_RELEASE>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_FLAGS_RELWITHDEBINFO>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_IGNORE_EXTENSIONS>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_IMPLICIT_INCLUDE_DIRECTORIES>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_IMPLICIT_LINK_DIRECTORIES>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_IMPLICIT_LINK_LIBRARIES>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_LIBRARY_ARCHITECTURE>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_LINKER_PREFERENCE>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_LINKER_PREFERENCE_PROPAGATES>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_LINK_EXECUTABLE>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_OUTPUT_EXTENSION>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_PLATFORM_ID>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_SIZEOF_DATA_PTR>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_\i*_SOURCE_FILE_EXTENSIONS>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<CMAKE_COMPILER_IS_GNU\i*>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<\i*_BINARY_DIR>/ containedin=cmakeVariableValue contained
syntax match cmakeSystemVariables /\v<\i*_SOURCE_DIR>/ containedin=cmakeVariableValue contained

" generated from `cmake` command v2.8.12.1 with `cmake --help-property-list | tr "\r\n" " "`
syntax keyword cmakeProperties
    \ ALLOW_DUPLICATE_CUSTOM_TARGETS  AUTOMOC_TARGETS_FOLDER  DEBUG_CONFIGURATIONS  DISABLED_FEATURES  ENABLED_FEATURES  ENABLED_LANGUAGES
    \ FIND_LIBRARY_USE_LIB64_PATHS  FIND_LIBRARY_USE_OPENBSD_VERSIONING  GLOBAL_DEPENDS_DEBUG_MODE  GLOBAL_DEPENDS_NO_CYCLES  IN_TRY_COMPILE
    \ PACKAGES_FOUND  PACKAGES_NOT_FOUND  PREDEFINED_TARGETS_FOLDER  REPORT_UNDEFINED_PROPERTIES  RULE_LAUNCH_COMPILE  RULE_LAUNCH_CUSTOM
    \ RULE_LAUNCH_LINK  RULE_MESSAGES TARGET_ARCHIVES_MAY_BE_SHARED_LIBS  TARGET_SUPPORTS_SHARED_LIBS  USE_FOLDERS
    \ __CMAKE_DELETE_CACHE_CHANGE_VARS_  ADDITIONAL_MAKE_CLEAN_FILES  CACHE_VARIABLES  CLEAN_NO_CUSTOM  COMPILE_DEFINITIONS 
    \ COMPILE_OPTIONS  DEFINITIONS  EXCLUDE_FROM_ALL  IMPLICIT_DEPENDS_INCLUDE_TRANSFORM  INCLUDE_DIRECTORIES  INCLUDE_REGULAR_EXPRESSION
    \ INTERPROCEDURAL_OPTIMIZATION   LINK_DIRECTORIES  LISTFILE_STACK  MACROS  PARENT_DIRECTORY 
    \ RULE_LAUNCH_COMPILE  RULE_LAUNCH_CUSTOM  RULE_LAUNCH_LINK  TEST_INCLUDE_FILE  VARIABLES 
    \ ALIASED_TARGET  ARCHIVE_OUTPUT_DIRECTORY 
    \ ARCHIVE_OUTPUT_NAME
    \ AUTOMOC  AUTOMOC_MOC_OPTIONS  BUILD_WITH_INSTALL_RPATH  BUNDLE  BUNDLE_EXTENSION COMPATIBLE_INTERFACE_BOOL
    \ COMPATIBLE_INTERFACE_STRING  COMPILE_DEFINITIONS    COMPILE_FLAGS  COMPILE_OPTIONS  DEBUG_POSTFIX
    \ DEFINE_SYMBOL  ENABLE_EXPORTS  EXCLUDE_FROM_ALL  EXCLUDE_FROM_DEFAULT_BUILD
    \ EXPORT_NAME  EchoString  FOLDER  FRAMEWORK  Fortran_FORMAT  Fortran_MODULE_DIRECTORY  GENERATOR_FILE_NAME  GNUtoMS  HAS_CXX
    \ IMPLICIT_DEPENDS_INCLUDE_TRANSFORM  IMPORTED  IMPORTED_CONFIGURATIONS  IMPORTED_IMPLIB  
    \ IMPORTED_LINK_DEPENDENT_LIBRARIES    IMPORTED_LINK_INTERFACE_LANGUAGES 
    \ IMPORTED_LINK_INTERFACE_LIBRARIES IMPORTED_NO_SONAME 
    \ IMPORTED_SONAME  IMPORT_PREFIX  IMPORT_SUFFIX  INCLUDE_DIRECTORIES  INSTALL_NAME_DIR  INSTALL_RPATH  INSTALL_RPATH_USE_LINK_PATH
    \ INTERFACE_COMPILE_DEFINITIONS  INTERFACE_COMPILE_OPTIONS  INTERFACE_INCLUDE_DIRECTORIES  INTERFACE_LINK_LIBRARIES
    \ INTERFACE_POSITION_INDEPENDENT_CODE  INTERFACE_SYSTEM_INCLUDE_DIRECTORIES  INTERPROCEDURAL_OPTIMIZATION  LABELS
    \ LIBRARY_OUTPUT_DIRECTORY  LIBRARY_OUTPUT_NAME  LINKER_LANGUAGE  LINK_DEPENDS  LINK_DEPENDS_NO_SHARED   LINK_INTERFACE_LIBRARIES  
    \ LINK_INTERFACE_MULTIPLICITY  LINK_LIBRARIES  LINK_SEARCH_END_STATIC  LINK_SEARCH_START_STATIC  LOCATION  MACOSX_BUNDLE 
    \ MACOSX_BUNDLE_INFO_PLIST  MACOSX_FRAMEWORK_INFO_PLIST PDB_NAME  MACOSX_RPATH    NAME  NO_SONAME  OSX_ARCHITECTURES   OUTPUT_NAME
    \ PDB_OUTPUT_DIRECTORY  POSITION_INDEPENDENT_CODE  POST_INSTALL_SCRIPT  PREFIX  PRE_INSTALL_SCRIPT  PRIVATE_HEADER  PROJECT_LABEL
    \ PUBLIC_HEADER  RESOURCE  RULE_LAUNCH_COMPILE  RULE_LAUNCH_CUSTOM  RULE_LAUNCH_LINK  RUNTIME_OUTPUT_DIRECTORY   RUNTIME_OUTPUT_NAME
    \ SKIP_BUILD_RPATH  SOURCES  SOVERSION  STATIC_LIBRARY_FLAGS  SUFFIX  TYPE  VERSION 
    \ VISIBILITY_INLINES_HIDDEN  VS_DOTNET_REFERENCES  VS_DOTNET_TARGET_FRAMEWORK_VERSION    VS_GLOBAL_KEYWORD  VS_GLOBAL_PROJECT_TYPES
    \ VS_GLOBAL_ROOTNAMESPACE  VS_KEYWORD  VS_SCC_AUXPATH  VS_SCC_LOCALPATH  VS_SCC_PROJECTNAME  VS_SCC_PROVIDER  VS_WINRT_EXTENSIONS
    \ VS_WINRT_REFERENCES  WIN32_EXECUTABLE ATTACHED_FILES  ATTACHED_FILES_ON_FAIL  COST  DEPENDS  ENVIRONMENT
    \ FAIL_REGULAR_EXPRESSION  LABELS  MEASUREMENT PASS_REGULAR_EXPRESSION  PROCESSORS  REQUIRED_FILES  RESOURCE_LOCK  RUN_SERIAL
    \ TIMEOUT  WILL_FAIL  WORKING_DIRECTORY  ABSTRACT COMPILE_DEFINITIONS COMPILE_FLAGS  EXTERNAL_OBJECT  Fortran_FORMAT  GENERATED 
    \ HEADER_FILE_ONLY  KEEP_EXTENSION LABELS  LANGUAGE  LOCATION  MACOSX_PACKAGE_LOCATION  OBJECT_DEPENDS  OBJECT_OUTPUTS  SYMBOLIC
    \ WRAP_EXCLUDE ADVANCED HELPSTRING MODIFIED STRINGS TYPE VALUE LINK_FLAGS IMPORTED_LINK_INTERFACE_MULTIPLICITY IMPORTED_LOCATION

syntax match cmakeProperties /\v<STATIC_LIBRARY_FLAGS_\i*>/  
syntax match cmakeProperties /\v<INTERPROCEDURAL_OPTIMIZATION_\i*>/
syntax match cmakeProperties /\v<COMPILE_DEFINITIONS_\i*>/
syntax match cmakeProperties /\v<IMPORTED_LINK_DEPENDENT_LIBRARIES_\i*>/
syntax match cmakeProperties /\v<IMPORTED_IMPLIB_\i*>/
syntax match cmakeProperties /\v<COMPILE_DEFINITIONS_\i*>/
syntax match cmakeProperties /\v<VS_GLOBAL_SECTION_POST_\i*>/
syntax match cmakeProperties /\v<VS_GLOBAL_SECTION_PRE_\i*>/
syntax match cmakeProperties /\v<\i*_OUTPUT_NAME>/
syntax match cmakeProperties /\v<\i*_POSTFIX>/
syntax match cmakeProperties /\v<\i*_VISIBILITY_PRESET>/
syntax match cmakeProperties /\v<ARCHIVE_OUTPUT_DIRECTORY_\i*>/
syntax match cmakeProperties /\v<ARCHIVE_OUTPUT_NAME_\i*>/
syntax match cmakeProperties /\v<EXCLUDE_FROM_DEFAULT_BUILD_\i*>/
syntax match cmakeProperties /\v<IMPORTED_LINK_INTERFACE_LANGUAGES_\i*>/
syntax match cmakeProperties /\v<IMPORTED_LINK_INTERFACE_LIBRARIES_\i*>/
syntax match cmakeProperties /\v<IMPORTED_LINK_INTERFACE_MULTIPLICITY_\i*>/
syntax match cmakeProperties /\v<IMPORTED_LOCATION_\i*>/
syntax match cmakeProperties /\v<IMPORTED_NO_SONAME_\i*>/
syntax match cmakeProperties /\v<IMPORTED_SONAME_\i*>/
syntax match cmakeProperties /\v<INTERPROCEDURAL_OPTIMIZATION_\i*>/
syntax match cmakeProperties /\v<LOCATION_\i*>/
syntax match cmakeProperties /\v<LINK_FLAGS_\i*>/
syntax match cmakeProperties /\v<LIBRARY_OUTPUT_DIRECTORY_\i*>/
syntax match cmakeProperties /\v<LIBRARY_OUTPUT_NAME_\i*>/
syntax match cmakeProperties /\v<OSX_ARCHITECTURES_\i*>/
syntax match cmakeProperties /\v<LINK_INTERFACE_LIBRARIES_\i*>/
syntax match cmakeProperties /\v<PDB_OUTPUT_DIRECTORY_\i*>/
syntax match cmakeProperties /\v<OUTPUT_NAME_\i*>/
syntax match cmakeProperties /\v<RUNTIME_OUTPUT_NAME_\i*>/
syntax match cmakeProperties /\v<VS_GLOBAL_\i*>/
syntax match cmakeProperties /\v<XCODE_ATTRIBUTE_\i*>/
syntax match cmakeProperties /\v<LINK_INTERFACE_MULTIPLICITY_\i*>/
syntax match cmakeProperties /\v<PDB_NAME_\i*>/
syntax match cmakeProperties /\v<COMPILE_DEFINITIONS_\i*>/
syntax match cmakeProperties /\v<MAP_IMPORTED_CONFIG_\i*>/
syntax match cmakeProperties /\v<RUNTIME_OUTPUT_DIRECTORY_\i*>/

" "Generator expressions" syntax is used for arguments to:
"   add_compile_options()
"   add_custom_command( ... COMMAND $<...> )
"   add_test( ... COMMAND $<...> )
"   file(GENERATE ...)
"   target_compile_definitions()
"   target_compile_options()
"   target_include_directories()
"   target_link_libraries()

" and the arguments to the functions:
"   set_target_properties()
"   set_property(TARGET ...)

" for the following properties:
"   COMPILE_OPTIONS
"   COMPILE_DEFINITIONS
"   INCLUDE_DIRECTORIES
"   INTERFACE_COMPILE_DEFINITIONS
"   INTERFACE_COMPILE_OPTIONS
"   INTERFACE_INCLUDE_DIRECTORIES
"   INTERFACE_LINK_LIBRARIES
"   INTERFACE_SYSTEM_INCLUDE_DIRECTORIES
"   LINK_LIBRARIES
syntax region cmakeGeneratorExpression start=+\V$<+ end=+\V>+ contained containedin=cmakeArguments
    \ contains=cmakeString,cmakeGeneratorExpression,cmakeVariableValue,cmakeSystemVariables

syntax match cmakeGeneratorExpressionOperator "\V," contained containedin=cmakeGeneratorExpression
syntax match cmakeGeneratorExpressionSimple /\v(\$\<)@<=(CONFIGURATION|ANGLE-R|COMMA|SEMICOLON|C(XX)?_COMPILER_ID|C(XX)?_COMPILER_VERSION|INSTALL_PREFIX)\>@=/ contained containedin=cmakeGeneratorExpression
syntax match cmakeGeneratorExpressionCommand /\v(\$\<)@<=(0|1|CONFIG|BOOL|STREQUAL|JOIN|TARGET_NAME|INSTALL_INTERFACE|BUILD_INTERFACE|C(XX)?_COMPILER_ID):/ contained containedin=cmakeGeneratorExpression
syntax match cmakeGeneratorExpressionCommand /\v(\$\<)@<=(VERSION_(GREATER|LESS|EQUAL)|C(XX)?_COMPILER_VERSION|TARGET_(((LINKER|SONAME)_)?FILE(_DIR)?|PROPERTY|POLICY)|AND|OR|NOT):/ contained containedin=cmakeGeneratorExpression
syntax region cmakeGeneratorExpressionTargetProperty start=/\v(\$\<TARGET_PROPERTY:)@<=/ end=+\v\>@=+ transparent contained containedin=cmakeGeneratorExpression 
    \ contains=cmakeString,cmakeGeneratorExpression,cmakeVariableValue,cmakeGeneratorExpressionOperator,cmakeProperties

syntax sync minlines=150

highlight default link cmakeGeneratorExpressionOperator Operator
highlight default link cmakeGeneratorExpressionSimple Statement
highlight default link cmakeGeneratorExpressionCommand Statement
highlight default link cmakeGeneratorExpression Special
highlight default link cmakeSystemVariables PreProc
highlight default link cmakeProperties Statement

" could make a cluster out of these
" contained list: cmakeEscaped cmakeRegistry cmakeVariableValue cmakeEnvironment cmakeOperators cmakeTodo
" containers: cmakeRegistry cmakeVariableValue cmakeEnvironment cmakeString

let &cpo = s:keepcpo
unlet s:keepcpo
