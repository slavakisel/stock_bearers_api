module Bearers
  class FindOrInitialize
    attr_reader :bearer_name

    def initialize(bearer_name)
      @bearer_name = bearer_name
    end

    def run
      find_bearer || Bearer.new(name: bearer_name)
    end

    def find_bearer
      Bearer.where("lower(name) = ?", bearer_name&.downcase).first
    end
  end
end
