//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// This test relies on P0482 being fixed, which isn't in
// older Apple dylibs
//
// XFAIL: use_system_cxx_lib && target={{.+}}-apple-macosx10.{{9|10|11|12|13|14|15}}

// This test runs in C++20, but we have deprecated codecvt<char(16|32), char, mbstate_t> in C++20.
// ADDITIONAL_COMPILE_FLAGS: -D_LIBCPP_DISABLE_DEPRECATION_WARNINGS

// <locale>

// template <class Facet> locale combine(const locale& other) const;

#include <locale>
#include <stdexcept>
#include <cassert>

#include "count_new.h"

#include "test_macros.h"

void check(const std::locale& loc)
{
    assert(std::has_facet<std::collate<char> >(loc));
    assert(std::has_facet<std::collate<wchar_t> >(loc));

    assert(std::has_facet<std::ctype<char> >(loc));
    assert(std::has_facet<std::ctype<wchar_t> >(loc));
    assert((std::has_facet<std::codecvt<char, char, std::mbstate_t> >(loc)));
    assert((std::has_facet<std::codecvt<char16_t, char, std::mbstate_t> >(loc)));
    assert((std::has_facet<std::codecvt<char32_t, char, std::mbstate_t> >(loc)));
#if TEST_STD_VER > 17
    assert((std::has_facet<std::codecvt<char16_t, char8_t, std::mbstate_t> >(loc)));
    assert((std::has_facet<std::codecvt<char32_t, char8_t, std::mbstate_t> >(loc)));
#endif
    assert((std::has_facet<std::codecvt<wchar_t, char, std::mbstate_t> >(loc)));

    assert((std::has_facet<std::moneypunct<char> >(loc)));
    assert((std::has_facet<std::moneypunct<wchar_t> >(loc)));
    assert((std::has_facet<std::money_get<char> >(loc)));
    assert((std::has_facet<std::money_get<wchar_t> >(loc)));
    assert((std::has_facet<std::money_put<char> >(loc)));
    assert((std::has_facet<std::money_put<wchar_t> >(loc)));

    assert((std::has_facet<std::numpunct<char> >(loc)));
    assert((std::has_facet<std::numpunct<wchar_t> >(loc)));
    assert((std::has_facet<std::num_get<char> >(loc)));
    assert((std::has_facet<std::num_get<wchar_t> >(loc)));
    assert((std::has_facet<std::num_put<char> >(loc)));
    assert((std::has_facet<std::num_put<wchar_t> >(loc)));

    assert((std::has_facet<std::time_get<char> >(loc)));
    assert((std::has_facet<std::time_get<wchar_t> >(loc)));
    assert((std::has_facet<std::time_put<char> >(loc)));
    assert((std::has_facet<std::time_put<wchar_t> >(loc)));

    assert((std::has_facet<std::messages<char> >(loc)));
    assert((std::has_facet<std::messages<wchar_t> >(loc)));
}

struct my_facet
    : public std::locale::facet
{
    int test() const {return 5;}

    static std::locale::id id;
};

std::locale::id my_facet::id;

int main(int, char**)
{
{
    globalMemCounter.reset();
    {
        std::locale loc;
        std::locale loc2(loc, new my_facet);
        std::locale loc3 = loc.combine<my_facet>(loc2);
        check(loc3);
        assert(loc3.name() == "*");
        assert((std::has_facet<my_facet>(loc3)));
        const my_facet& f = std::use_facet<my_facet>(loc3);
        assert(f.test() == 5);
    }
    assert(globalMemCounter.checkOutstandingNewEq(0));
}
#ifndef TEST_HAS_NO_EXCEPTIONS
{
    {
        std::locale loc;
        std::locale loc2;
        try
        {
            std::locale loc3 = loc.combine<my_facet>(loc2);
            assert(false);
        }
        catch (std::runtime_error&)
        {
        }
    }
    assert(globalMemCounter.checkOutstandingNewEq(0));
}
#endif

  return 0;
}
