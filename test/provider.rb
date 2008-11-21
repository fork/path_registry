Provider = Class.new ActiveRecord::Base do
  registers_path

  attr_accessor :label
  alias_method :to_s, :label

end

InhProvider = Class.new Provider

CustomInhProvider = Class.new Provider do

  registers_path :scope => proc { |r| owner.name } do |provider|
    "/#{ provider.slug }"
  end
  
end
