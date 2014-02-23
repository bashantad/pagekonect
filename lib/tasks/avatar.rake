namespace :avatar do
  desc 'Create user avatar temporary directory to store snapped images.'
  task :create do
    FileUtils.mkdir_p "#{Rails.root}/tmp/user/avatar"
    puts "Directory created: #{Rails.root}/tmp/user/avatar"
  end

  desc 'Clear all files from user avatar directory.'
  task :clear do
    FileUtils.rm_rf "#{Rails.root}/tmp/user/avatar"
    puts "Directory cleared: #{Rails.root}/tmp/user/avatar"
  end
end