module Egn
  class Parser
    attr_reader :date, :sex

    def initialize(egn)
      raise ArgumentError, "Invalid EGN" unless Validator.validate(egn)

      year, month, day = egn.scan(/.{1,2}/).map(&:to_i)
      year, month = ::Egn.determine_date(year, month)

      @date = Date.new(year.to_i, month, day)
    end

  end
end
