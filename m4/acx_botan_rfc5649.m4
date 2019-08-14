AC_DEFUN([ACX_BOTAN_RFC5649],[
	AC_MSG_CHECKING(for Botan RFC5649 support)

	tmp_CPPFLAGS=$CPPFLAGS
	tmp_LIBS=$LIBS

	CPPFLAGS="$CPPFLAGS $CRYPTO_INCLUDES"
	LIBS="$CRYPTO_LIBS $LIBS"

	AC_DEFINE([HAVE_AES_KEY_WRAP], [1],
		  [Define if advanced AES key wrap without pad is supported])
	AC_LANG_PUSH([C++])
	AC_LINK_IFELSE([
		AC_LANG_SOURCE([[
			#include <botan/rfc3394.h>
			#include <botan/version.h>
			int main()
			{
				using namespace Botan;

				secure_vector<byte> key(10);
				SymmetricKey kek("AABB");
				secure_vector<byte> x = rfc5649_keywrap(key, kek);
				return 1;
			}
		]])
	],[
		AC_MSG_RESULT([Found AES key wrap with pad])
		AC_DEFINE([HAVE_AES_KEY_WRAP_PAD], [1],
			  [Define if advanced AES key wrap with pad is supported])
	],[
		AC_MSG_RESULT([Cannot find AES key wrap with pad])

	])
	AC_LANG_POP([C++])

	CPPFLAGS=$tmp_CPPFLAGS
	LIBS=$tmp_LIBS
])
