//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14, c++17
// UNSUPPORTED: libcpp-no-concepts

// <utility>

// template<class T, class U>
//   constexpr bool cmp_less(T t, U u) noexcept;          // C++20

#include <utility>
#include <limits>
#include <numeric>
#include <tuple>
#include <cassert>

#include "test_macros.h"

template <typename T>
struct Tuple {
  T min;
  T max;
  T mid;
  constexpr Tuple() {
    min = std::numeric_limits<T>::min();
    max = std::numeric_limits<T>::max();
    mid = std::midpoint(min, max);
  }
};

template <typename T>
constexpr void test_cmp_less1() {
  constexpr Tuple<T> tup;
  assert(std::cmp_less(T(0), T(1)));
  assert(std::cmp_less(T(1), T(2)));
  assert(std::cmp_less(tup.min, tup.max));
  assert(std::cmp_less(tup.min, tup.mid));
  assert(std::cmp_less(tup.mid, tup.max));
  assert(!std::cmp_less(T(1), T(0)));
  assert(!std::cmp_less(T(10), T(5)));
  assert(!std::cmp_less(tup.max, tup.min));
  assert(!std::cmp_less(tup.mid, tup.min));
  assert(!std::cmp_less(tup.mid, tup.mid));
  assert(!std::cmp_less(tup.min, tup.min));
  assert(!std::cmp_less(tup.max, tup.max));
  assert(!std::cmp_less(tup.max, 1));
  assert(!std::cmp_less(1, tup.min));
  assert(!std::cmp_less(T(-1), T(-1)));
  assert(!std::cmp_less(-2, tup.min) == std::is_signed_v<T>);
  assert(std::cmp_less(tup.min, -2) == std::is_signed_v<T>);
  assert(std::cmp_less(-2, tup.max));
  assert(!std::cmp_less(tup.max, -2));
}

template <typename T, typename U>
constexpr void test_cmp_less2() {
  assert(std::cmp_less(T(0), U(1)));
  assert(!std::cmp_less(T(1), U(0)));
}

template <class... Ts>
constexpr void test1(const std::tuple<Ts...>&) {
  (test_cmp_less1<Ts>() , ...);
}

template <class T, class... Us>
constexpr void test2_impl(const std::tuple<Us...>&) {
  (test_cmp_less2<T, Us>() , ...);
}

template <class... Ts, class UTuple>
constexpr void test2(const std::tuple<Ts...>&, const UTuple& utuple) {
  (test2_impl<Ts>(utuple) , ...);
}

constexpr bool test() {
  std::tuple<
#ifndef TEST_HAS_NO_INT128
      __int128_t, __uint128_t,
#endif
      unsigned long long, long long, unsigned long, long, unsigned int, int,
      unsigned short, short, unsigned char, signed char> types;
  test1(types);
  test2(types, types);
  return true;
}

int main(int, char**) {
  ASSERT_NOEXCEPT(std::cmp_less(0, 1));
  test();
  static_assert(test());
  return 0;
}
