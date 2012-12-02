require "minitest-descriptive/version"

module MiniTest
  module Descriptive
    class DescriptiveValue < Struct.new(:name, :value)
      def inspect
        "#{value.inspect} (#{name})"
      end
    end

    def diff(exp, act)
      exp_name = ivar_value(exp)
      act_name = ivar_value(act)

      if defined?(Rubinius)
        test_frame = Rubinius::VM.backtrace(0, true).detect do |loc|
          loc.name =~ /^test_/
        end

        vs, cc, cs = test_frame.variables,
                     test_frame.method,
                     test_frame.constant_scope
        exp_name ||= local_value(exp, vs, cc, cs)
        act_name ||= local_value(act, vs, cc, cs)
      end

      super(exp_name || exp, act_name || act)
    end

    private

    def local_value(value, vs, cc, cs)
      binding = ::Binding.setup(vs, cc, cs)

      cc.local_names.map do |local|
        DescriptiveValue.new(local, (eval(local.to_s, binding) rescue nil))
      end.detect { |value| value.value }
    end

    def ivar_value(value)
      ivar_values.detect { |val| val.value == value }
    end

    def ivar_values
      ivars.map { |iv| DescriptiveValue.new(iv, instance_variable_get(iv)) }
    end

    def ivars
      example_case = MiniTest::Unit::TestCase.new(nil)
      instance_variables - example_case.instance_variables - [:@_assertions]
    end
  end
end
