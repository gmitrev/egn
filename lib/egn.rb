require "egn/version"
require "date"

module Egn
  PARITY_WEIGHTS = [2,4,8,5,10,9,7,3,6]

  module Generator
    def self.egn
      date = time_rand
      year = date.year
      mon = date.month
      day = date.day

      cent = year - (year % 100)
      sex = Random.rand(1..2)

      if cent == 1800
        mon += 20
      elsif cent == 2000
        mon += 40
      end

      region = Random.rand(0..999)

      if sex == 1 && (region %2 != 0)
        region -= 1
      elsif sex == 2 && (region % 2 == 0)
        region += 1
      end

      final_year = year - cent
      egn = final_year.to_s.rjust(2, '0') + mon.to_s.rjust(2, '0') + day.to_s.rjust(2,'0') + region.to_s.rjust(3,'0')

      return egn + egn_checksum(egn).to_s
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
        year = "20#{year}"
      when (41..52)
        month -= 40
        year = "18#{year}"
      end
      year = year.to_i

      return false unless Date.valid_date? year, month, day

      checksum = Generator.egn_checksum egn[0,9]

      checksum == egn[9].to_i
    end

  end

  class Parser

    def initialize(egn)
      return false unless egn.length == 10

      @year, @month, @day = egn.scan(/.{1,2}/)
      @month = @month.to_i
      @day = @day.to_i

      case @month
      when (1..12)
        @year = "19#{@year}"
      when (21..32)
        @month -= 20
        @year = "20#{@year}"
      when (41..52)
        @month -= 40
        @year = "18#{@year}"
      end
      @year = @year.to_i

      raise ArgumentError, "invalid date" unless Date.valid_date? @year, @month, @day
    end

    def birth_date
      Date.parse("#{@year}-#{@month}-#{@day}")
    end

  end

end
