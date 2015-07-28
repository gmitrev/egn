module Egn
  class Parser
    attr_reader :date, :sex

    # Parses the given EGN and returns all information that can be
    # extracted from it: date, sex and region
    def initialize(egn)
      raise ArgumentError, 'Invalid EGN' unless Validator.validate(egn)

      # Extract the correct date
      year, month, day = egn.scan(/.{1,2}/).map(&:to_i)
      year, month = Util.determine_date(year, month)

      @date = Date.new(year.to_i, month, day)
    end
  end
end
