# Contains some utility methods that are used by the other classes
module Egn
  module Util
    WEIGHTS = [2, 4, 8, 5, 10, 9, 7, 3, 6]

    # The EGN can have three different formats depending on the century. It can
    # be determined by examining the month.
    # The rules are as follows:
    # * For people born in 1900..1999 the month does not change
    # * For people born in 1800..1899 the month is increased by 20 (e.g January is 21)
    # * For people born in 2000..2099 the month is increased by 40 (e.g December is 52)
    def self.determine_date(year, month)
      case month
      when (1..12)
        year = "19%02d" % [ year ]
      when (21..32)
        month -= 20
        year = "18%02d" % [ year ]
      when (41..52)
        month -= 40
        year = "20%02d" % [ year ]
      end

      [year.to_i, month]
    end

    # More information on the formula: http://www.grao.bg/esgraon.html#section2
    def self.egn_checksum(egn)
      sum = egn.chars.map(&:to_i).zip(WEIGHTS).map { |n| n.reduce(:*) }.reduce(:+)

      rest = sum % 11
      rest < 10 ? rest : 0
    end

    # Get a random date
    def self.time_rand(from = 0.0, to = Time.now)
      Time.at(from + rand * (to.to_f - from.to_f))
    end

    def self.year_in_range?(year)
      (1800..2099).include?(year)
    end
  end
end
