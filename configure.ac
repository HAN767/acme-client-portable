AC_PREREQ([2.69])

AC_INIT([acme-client], [0.1.0], [wolf@wolfsden.cz])

AC_CONFIG_SRCDIR([main.c])
AC_CONFIG_SRCDIR([acctproc.c])
AC_CONFIG_SRCDIR([fileproc.c])

AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_HEADERS([config.h])

AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_PROG_CC
AC_PROG_CC_STDC
if test "$ac_cv_prog_cc_stdc" == "no"; then
	AC_MSG_ERROR([C compiler does not support std mode.])
fi
AC_PROG_CPP
AC_PROG_CPP_WERROR
AC_PROG_YACC

AC_CONFIG_MACRO_DIRS([m4])

AC_FUNC_FORK

AX_CHECK_OPENSSL([], [AC_MSG_ERROR([Openssl not found.])])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
