module Egn
  class Validator

    def self.validate(egn)
      return false unless egn.length == 10

      year, month, day = egn.scan(/.{1,2}/).map(&:to_i)

      year, month = ::Egn.determine_date(year, month)

      return false unless Date.valid_date? year, month, day

      checksum = Generator.egn_checksum egn[0,9]

      checksum == egn[9].to_i
    end

  end
end
