module DemocracyInAction
  class Config
    def initialize(config_file = nil)
      @config = File.exists?(config_file) ? YAML.load_file(config_file) : {}
    end

    def [](key)
      @config[key]
    end
  end
end
