module WhatsYourStyle
  module FixtureHelper

    def load_fixture(name)
      File.read(Application.root + "/spec/fixtures/replies/#{name}.json")
    end

  end
end