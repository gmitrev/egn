module Egn
  class Parser
    attr_reader :date, :sex

    def initialize(egn)
      raise ArgumentError, "Invalid EGN" unless Validator.validate(egn)

      year, month, day = egn.scan(/.{1,2}/).map(&:to_i)

      case month
      when (1..12)
        year = "19#{year}"
      when (21..32)
        month -= 20
        year = "18#{year}"
      when (41..52)
        month -= 40
        year = "20#{year}"
      end

      @date = Date.new(year.to_i, month, day)
    end

  end
end
