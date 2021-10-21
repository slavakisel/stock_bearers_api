RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  FactoryBot.automatically_define_enum_traits = false
end
