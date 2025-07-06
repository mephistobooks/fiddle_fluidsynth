# frozen_string_literal: true

require "test_helper"


#
class FiddleFluidsynth

  module CoreExt; end

end

#
class FiddleFluidsynth::CoreExt::FiddleTest < Test::Unit::TestCase
  #
  test "sizeof" do

    #
    ret = Fiddle.sizeof_int
    exp = Fiddle::SIZEOF_INT
    assert_equal exp, ret

    #
    ret = Fiddle.sizeof_dbl
    exp = Fiddle::SIZEOF_DOUBLE
    assert_equal exp, ret

    ret = Fiddle.sizeof_flt
    exp = Fiddle::SIZEOF_FLOAT
    assert_equal exp, ret

    #
    ret = Fiddle.sizeof_voidp
    exp = Fiddle::SIZEOF_VOIDP
    assert_equal exp, ret

  end

  #
  #
  #
  test "malloc" do

    ### int
    int_p = Fiddle::Pointer.malloc_dbl
    Fiddle::Pointer.set_int(int_p, 114514)
    val = Fiddle::Pointer.decode1_int(int_p)

    #
    ret = val
    exp = 114514
    assert_equal exp, ret

    ### double.
    dbl_p = Fiddle::Pointer.malloc_dbl
    Fiddle::Pointer.set_dbl(dbl_p, 3.14159265)
    val = Fiddle::Pointer.decode1_dbl(dbl_p)

    #
    ret = val
    exp = 3.14159265
    assert_equal exp, ret

  end

end
