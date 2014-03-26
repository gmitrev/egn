module Egn
  module Util
    PARITY_WEIGHTS = [2,4,8,5,10,9,7,3,6]

    def self.determine_date(year, month)
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

      [year.to_i, month]
    end

    def self.egn_checksum(egn)
      sum = egn.split('').map(&:to_i).zip(PARITY_WEIGHTS).map { |n| n.reduce(:*) }.reduce(:+)

      rest = sum % 11
      rest < 10 ? rest : 0
    end

    def self.time_rand(from = 0.0, to = Time.now)
      Time.at(from + rand * (to.to_f - from.to_f))
    end


  end
end
