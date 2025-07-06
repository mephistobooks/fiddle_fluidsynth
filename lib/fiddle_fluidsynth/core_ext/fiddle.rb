#
#
#
require 'fiddle'

# `'-'*Fiddle::SIZEOF_INT` is bad when string is frozen literal.
# So we introduce this Fiddle helper.
#

#
#
#
def Fiddle.SIZEOF_INT
  Fiddle::SIZEOF_INT
end
def Fiddle.sizeof_int
  self.SIZEOF_INT()
end

def Fiddle.SIZEOF_DOUBLE
  Fiddle::SIZEOF_DOUBLE
end
def Fiddle.sizeof_dbl
  self.SIZEOF_DOUBLE()
end

def Fiddle.SIZEOF_FLOAT
  Fiddle::SIZEOF_FLOAT
end
def Fiddle.sizeof_flt
  self.SIZEOF_FLOAT()
end

def Fiddle.SIZEOF_VOIDP
  Fiddle::SIZEOF_VOIDP
end
def Fiddle.sizeof_voidp
  self.SIZEOF_VOIDP()
end


#
class Fiddle::Pointer
  def self.malloc_n( sz: )
    Fiddle::Pointer.malloc(sz)
  end

  #
  def self.malloc_int
    self.malloc_n(sz: Fiddle.sizeof_int)
  end
  def self.malloc_i; self.malloc_int; end

  #
  def self.malloc_dbl
    self.malloc_n(sz: Fiddle.sizeof_dbl)
  end

  #
  def self.malloc_flt
    self.malloc_n(sz: Fiddle.sizeof_flt)
  end

  #
  def self.malloc_voidp
    self.malloc_n(sz: Fiddle.sizeof_voidp)
  end

  #
  def self.malloc_char_ptr2( str_ary )
    ary_size = str_ary.size
    self.malloc_n(sz: Fiddle.sizeof_voidp*ary_size)
  end

end

#
class Fiddle::Pointer

  def self.set_int(ptr, v)
    ptr[0, Fiddle.sizeof_int] = [v].pack("i")
  end

  def self.set_dbl(ptr, v)
    ptr[0, Fiddle.sizeof_dbl] = [v].pack("E")
  end

  def self.set_flt(ptr, v)
    ptr[0, Fiddle.sizeof_flt] = [v].pack("f")
  end

  def self.set_voidp(ptr, v)
    ptr[0, Fiddle.sizeof_voidp] = [v].pack("J")
  end

  def self.set_char_ptr2(ptr2, str_ary)
    atr_ary.each_with_index do |str, index|
      tmp_ptr = Fiddle::Pointer.malloc(str.bytesize + 1)
      tmp_ptr[0, str.bytesize+1] = "#{str}\0"

      ptr2[index*Fiddle.sizeof_voidp,
           Fiddle.sizeof_voidp] = [tmp_ptr.to_i].pack("Q")
    end

    ptr2
  end

end


#
class Fiddle::Pointer
  def self.unpack1( val: , fmt: )
    val[0, val.size].unpack1(fmt)
  end

  #
  def self.decode1_int( val )
    self.unpack1(val: val, fmt: 'i')
  end
  def self.decode1_i(val); decode1_int(val); end
  def decode1_int
    self.class.decode1_i(self)
  end
  alias decode1_i decode1_int

  #
  def self.decode1_dbl( val )
    self.unpack1(val: val, fmt: 'E')
  end
  def decode1_dbl
    self.class.decode1_dbl(self)
  end

  #
  def self.decode_char_ptr2( ptr2 )
  end

end


####
