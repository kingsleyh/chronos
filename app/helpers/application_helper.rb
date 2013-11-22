module ApplicationHelper

  def show_version
    rap_file = File.open(File.dirname(__FILE__) + '/../../rap.yml')
    rap = YAML::load(rap_file)
    rap[:version]
  end

end
