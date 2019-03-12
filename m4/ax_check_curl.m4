# ===========================================================================
#     https://www.gnu.org/software/autoconf-archive/ax_check_curl.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_CURL([action-if-found[, action-if-not-found]])
#
# DESCRIPTION
#
#   Look for curl in a number of default spots, or in a user-selected
#   spot (via --with-curl).  Sets
#
#     CURL_INCLUDES to the include directives required
#     CURL_LIBS to the -l directives required
#     CURL_LDFLAGS to the -L or -R flags required
#
#   and calls ACTION-IF-FOUND or ACTION-IF-NOT-FOUND appropriately
#
#   This macro sets CURL_INCLUDES such that source files should use the
#   curl/ directory in include directives:
#
#     #include <curl/curl.h>
#
# LICENSE
#
#   Copyright (c) 2019 Tomas Volf <wolf@wolfsden.cz>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.
#
# This script is based on AX_CHECK_OPENSSL, serial 10.

#serial 1

AU_ALIAS([CHECK_CURL], [AX_CHECK_CURL])
AC_DEFUN([AX_CHECK_CURL], [
    found=false
    AC_ARG_WITH([curl],
        [AS_HELP_STRING([--with-curl=DIR],
            [root of the curl directory])],
        [
            case "$withval" in
            "" | y | ye | yes | n | no)
            AC_MSG_ERROR([Invalid --with-curl value])
              ;;
            *) curldirs="$withval"
              ;;
            esac
        ], [
            # if pkg-config is installed and openssl has installed a .pc file,
            # then use that information and don't search curldirs
            AC_CHECK_TOOL([PKG_CONFIG], [pkg-config])
            if test x"$PKG_CONFIG" != x""; then
                CURL_LDFLAGS=`$PKG_CONFIG libcurl --libs-only-L 2>/dev/null`
                if test $? = 0; then
                    CURL_LIBS=`$PKG_CONFIG libcurl --libs-only-l 2>/dev/null`
                    CURL_INCLUDES=`$PKG_CONFIG libcurl --cflags-only-I 2>/dev/null`
                    found=true
                fi
            fi

            # no such luck; use some default curldirs
            if ! $found; then
                curldirs="/usr/local/curl /usr/lib/curl /usr/curl /usr/pkg"
                curldirs="${curldirs} /usr/local /usr"
            fi
        ]
        )


    # note that we #include <curl/foo.h>, so the curl headers have to be in
    # an 'curl' subdirectory

    if ! $found; then
        CURL_INCLUDES=
        for curldir in $curldirs; do
            AC_MSG_CHECKING([for curl/curl.h in $curldir])
            if test -f "$curldir/include/curl/curl.h"; then
                CURL_INCLUDES="-I$curldir/include"
                CURL_LDFLAGS="-L$curldir/lib"
                CURL_LIBS="-lcurl"
                found=true
                AC_MSG_RESULT([yes])
                break
            else
                AC_MSG_RESULT([no])
            fi
        done

        # if the file wasn't found, well, go ahead and try the link anyway -- maybe
        # it will just work!
    fi

    # try the preprocessor and linker with our new flags,
    # being careful not to pollute the global LIBS, LDFLAGS, and CPPFLAGS

    AC_MSG_CHECKING([whether compiling and linking against libcurl works])
    echo "Trying link with CURL_LDFLAGS=$CURL_LDFLAGS;" \
        "CURL_LIBS=$CURL_LIBS; CURL_INCLUDES=$CURL_INCLUDES" >&AS_MESSAGE_LOG_FD

    save_LIBS="$LIBS"
    save_LDFLAGS="$LDFLAGS"
    save_CPPFLAGS="$CPPFLAGS"
    LDFLAGS="$LDFLAGS $CURL_LDFLAGS"
    LIBS="$CURL_LIBS $LIBS"
    CPPFLAGS="$CURL_INCLUDES $CPPFLAGS"
    AC_LINK_IFELSE(
        [AC_LANG_PROGRAM([#include <curl/curl.h>], [curl_global_init(CURL_GLOBAL_ALL)])],
        [
            AC_MSG_RESULT([yes])
            $1
        ], [
            AC_MSG_RESULT([no])
            $2
        ])
    CPPFLAGS="$save_CPPFLAGS"
    LDFLAGS="$save_LDFLAGS"
    LIBS="$save_LIBS"

    AC_SUBST([CURL_INCLUDES])
    AC_SUBST([CURL_LIBS])
    AC_SUBST([CURL_LDFLAGS])
])
