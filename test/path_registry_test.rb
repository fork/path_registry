require 'test_helper'

Expectations do

  expect [ 'foo', 'bar', *PathRegistry::RouteFilter.instance_methods ].sort do
    PathRegistry.name_route :foo, :bar
    PathRegistry::RouteFilter.instance_methods.sort
  end

  expect Consumer.new.to.be.routed_by_the_first_routing do |instance|
    PathRegistry.notify :update, instance
  end

  expect PathRegistry::Config do
    Provider.path_registry
  end

  expect Provider.path_registry do
    InhProvider.path_registry
  end

  expect 'CustomInhProvider' do
    provider = CustomInhProvider.new
    provider.build_registered_path :provider => provider

    provider.class.path_registry.scope provider.registered_path
  end

  expect(/\/providers\/show\/\d+/) do
    provider = Provider.create
    path = provider.registered_path
    provider.destroy

    path.to_s
  end

  expect '/slug' do
    provider = CustomInhProvider.create :slug => 'foo'
    provider.update_attribute :slug, 'slug'
    path = provider.registered_path
    provider.destroy

    path.to_s
  end

  expect CustomInhProvider.create(:slug => 'foo').registered_path do
    Provider.create
    result = Consumer.new.registered_paths.first
    Provider.destroy_all
    result
  end

end
