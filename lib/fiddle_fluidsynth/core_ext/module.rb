#
# filename: module.rb
#

#
#
#
class Module

  #
  #
  # ==== Example
  # ```
  # class Aclass
  #   define_module(:Foo) do |mod|
  #     mod.const_set(...)
  #     :
  #   end
  # end
  # ```
  def define_module(name, &block)
    # mod = Module.new(&block)
    # const_set(name, mod)
    unless const_defined?(name)
      mod = Module.new
      const_set(name, mod)
    end

    block.call(const_get(name))
  end

  # define enum constants and its module.
  # ==== Args
  # name:: name of the enumerator.
  # debug_f:: debug mode.
  # defs:: pairs of key and value of hash.
  #
  # ==== Example
  # ```
  # class AClass
  #   enum(:fluid_t,
  #     Foo: nil,
  #     Bar: 5,
  #     Car: nil,
  #   )
  # end
  # puts "AClass::Car: #{AClass::Foo}" => 0
  # puts AClass::Enum_fluid_t::Car =>6
  # puts AClass.Enum_fluid_t =>{Foo: 0, Bar: 5, Car: 6,}
  # ```
  #

  #
  #
  #
  def enum( name = "", debug_f: false, **defs )
    # preprocess.
    if name.is_a? Hash
      defs = name
      name = ""
    end

    #
    if !(defs[:debug_f].nil?)
      debug_f = defs[:debug_f]
      defs.delete(:debug_f)
    else
      # $stderr.puts "(**) {#{__method__}} no options."
    end
    $stderr.puts "(**) defs: #{defs}" if debug_f
    $stderr.puts "(**) name: #{name}, debug_f: #{debug_f}," +
      " defs: #{defs}" if debug_f

    # create a module when name is specified.
    m_name = ""
    if name.to_s != ""
      m_name = "Enum_#{name}"
      define_module(m_name){|_mod| } unless const_defined?(m_name)
    end

    #
    _cnt = 0
    defs.each do |_k, _v|
      #
      raise "The head of `#{_k}' must be in Capital or you misspelled" +
        " for an option...?" unless _k =~ /^[A-Z]/

      #
      if _v.is_a? Integer
        puts "_k: #{_k} = #{_v}" if debug_f
        const_set(_k, _v)
        const_get(m_name).const_set(_k,_v) if m_name != ""

        _cnt = _v
      elsif _v.is_a? Symbol
        __v = const_get(_v)
        puts "_k: #{_k} = #{_v}, __v: #{__v}" if debug_f
        const_set(_k, __v)
        const_get(m_name).const_set(_k,__v) if m_name != ""

        _cnt = __v
      elsif _v.nil?
        _v = _cnt
        puts "_k: #{_k} = #{_v}" if debug_f
        const_set(_k, _v)
        const_get(m_name).const_set(_k,_v) if m_name != ""

        defs[_k] = _v
      else
        raise "value:#{_v} must be an Integer."
      end

      _cnt += 1
    end


    defs
  end

end


#### endof filename: module.rb
