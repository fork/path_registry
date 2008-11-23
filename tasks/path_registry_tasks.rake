namespace :path_registry do
  desc 'List all registered paths.'
  task :list => :environment do
    printf "%44s | %20s | %8i\n" % [ 'PATH', '_TYPE', '_ID' ]

    paths = RegisteredPath.find :all, :order => 'path', :include => :provider
    for path in paths
      printf "%44s | %20s | %8i\n" % [
        path,
        path.provider.class.name,
        path.provider_id
      ]
    end
  end
end
