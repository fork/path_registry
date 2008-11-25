module PathRegistry

  registered_path do
    # load extensions here
    # on_whitelist
  end

  notifies 'Item' do |on|
    on.update { self.routed_by_the_first_routing = true if Consumer === self }
  end

  # this one is ignored
  notifies 'Item' do |on|
    on.update { self.routed_by_the_first_routing = false if Consumer === self }
  end

end
