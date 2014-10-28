module Egn
  class Validator
    attr_reader :egn

    # Convinience method
    def self.validate(egn)
      Validator.new(egn).validate
    end

    def initialize(egn)
      @egn = egn

      @year, @month, @day = explode_date(egn)
    end

    # Checks if a given EGN is valid
    def validate
      return false unless @egn.length == 10
      return false unless Date.valid_date?(@year, @month, @day)

      # Calculate the checksum and check if the given one is correct
      checksum = Util.egn_checksum(@egn[0,9])
      checksum == @egn[9].to_i
    end

    private

    def explode_date(egn)
      year, month, day = egn.scan(/.{1,2}/).map(&:to_i)
      year, month = Util.determine_date(year, month)
      [year, month, day]
    end

  end
end
