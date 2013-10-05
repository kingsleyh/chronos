# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Chronos::Application.load_tasks

require 'rake'
require 'yaml'
require 'fileutils'
require 'rappa'

namespace :thin do

  desc "Start The Application"
  task :start do
    config = YAML::load_file(File.dirname(__FILE__) + '/config.yml')
    port = config[:port]
    puts "Restarting The Application..."
    system("thin start -e production -p #{port} -s 1 -d")
  end

  desc "Stop The Application"
  task :stop do
    puts "Stopping The Application..."
    Dir.new(File.dirname(__FILE__) + '/tmp/pids').each do |file|
      prefix = file.to_s
      if prefix[0, 4] == 'thin'
        str = "thin stop -P#{File.dirname(__FILE__)}/tmp/pids/#{file}"
        puts "Stopping server on port #{file[/\d+/]}..."
        system(str)
      end
    end
  end

  desc "Deploy"
  task :deploy do
    puts 'incrementing version'
    rap_file = File.open(File.dirname(__FILE__) + '/rap.yml')
    rap = YAML::load(rap_file)
    digit = rap[:version].split('.')[-1].to_i + 1
    rap[:version] = '0.0.' + digit.to_s
    File.open(rap_file, 'w') { |f| f.puts rap.to_yaml }

    puts 'generating rap file'
    FileUtils.rm_rf(File.dirname(__FILE__) + '/../chronos.rap')
    Rappa.new(:input_directory => File.dirname(__FILE__) + '/../chronos', :output_directory => File.dirname(__FILE__) + '/../').package

    puts 'Deploying to timesheet.masterthought.net'
    Rappa.new(:input_rap => File.dirname(__FILE__) + '/../chronos.rap', :url => 'http://kings-001.vm.brightbox.net/api/deploy', :api_key => 'kings_key').deploy
  end

end

