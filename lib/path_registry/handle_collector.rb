module PathRegistry
  class HandleCollector
    instance_methods.each { |meth| undef_method(meth) unless meth =~ /\A__/ }
    
    def initialize
      @handles = {}
    end
    
    def method_missing(meth, &block)
      @handles[meth] = block
    end

    def to_hash
      @handles
    end

  end
end
