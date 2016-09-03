require 'singleton'
require 'yaml'

class Config
   include Singleton

   def initialize
    @vk_settings = YAML.load_file("#{__dir__}/config.yml") 

   end

   def vk_settings
    @vk_settings
   end
end