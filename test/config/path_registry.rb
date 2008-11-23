module PathRegistry

  registered_path do
    # load extensions here
    # on_whitelist
  end

  route 'Item' do |on|
    on.update { self.routed_by_the_first_routing = true if Consumer === self }
  end

  # this one is ignored
  route 'Item' do |on|
    on.update { self.routed_by_the_first_routing = false if Consumer === self }
  end

end
