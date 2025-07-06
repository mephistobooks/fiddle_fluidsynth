# frozen_string_literal: true

require "test_helper"


#
class FiddleFluidsynth

  module CoreExt; end

end


class FiddleFluidsynth::CoreExt::ModuleTest < Test::Unit::TestCase

  #
  enum(
    THIS_IS: nil,
    A_TEST:  nil,
  )

  enum(
    :fluid_test_t,
    FLUID_TEST_1: nil,
    FLUID_TEST_2: nil,
  )

  #
  test "enum" do

    ret = THIS_IS
    exp = 0
    assert_equal exp, ret

    ret = A_TEST
    exp = 1
    assert_equal exp, ret

    #
    ret = Enum_fluid_test_t
    exp = Enum_fluid_test_t
    assert_equal exp, ret

    ret = FLUID_TEST_2
    exp = 1
    assert_equal exp, ret

    ret = Enum_fluid_test_t::FLUID_TEST_2
    exp = FLUID_TEST_2
    assert_equal exp, ret

  end

end
