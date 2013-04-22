module WhatsYourStyle
  class Application

    CONFIG = %w{app database}

    class << self

      def load
        CONFIG.each do |name|
          instance_variable_set("@#{name}_config",YAML::load_file(File.join(File.dirname(__FILE__),"config", "#{name}.yml")))
        end
      end

      def root
        File.dirname(__FILE__)
      end

      def weka_root
        File.join(File.dirname(__FILE__), "app", "classification", "weka")
      end

      def app_config
        @app_config 
      end

      def database_config
        @database_config
      end

    end

    load

  end
end