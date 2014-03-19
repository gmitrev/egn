module Egn
  module Validator

    def self.egn(egn)
      return false unless egn.length == 10

      year, month, day = egn.scan(/.{1,2}/)
      month = month.to_i
      day = day.to_i

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
      year = year.to_i

      return false unless Date.valid_date? year, month, day

      checksum = Generator.egn_checksum egn[0,9]

      checksum == egn[9].to_i
    end

  end
end
