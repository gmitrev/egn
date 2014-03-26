module Egn
  module Generator

    def self.generate(options={})
      date = Util.time_rand

      options = {
        year:  date.year,
        month: date.month,
        day:   date.day
      }.merge(options)

      validate!(options)

      cent = options[:year] - (options[:year] % 100)
      sex = Random.rand(1..2)

      if cent == 1800
        options[:month] += 20
      elsif cent == 2000
        options[:month] += 40
      end

      region = Random.rand(0..999)

      if sex == 1 && (region %2 != 0)
        region -= 1
      elsif sex == 2 && (region % 2 == 0)
        region += 1
      end

      final_year = options[:year] - cent
      egn = final_year.to_s.rjust(2, '0') + options[:month].to_s.rjust(2, '0') + options[:day].to_s.rjust(2,'0') + region.to_s.rjust(3,'0')

      return egn + Util.egn_checksum(egn).to_s
    end

    def self.validate!(options)
      raise ArgumentError, "Year out of bounds" unless (1800..2100).include?(options[:year])
      raise ArgumentError, "Month out of bounds" unless (1..12).include?(options[:month])
      raise ArgumentError, "Day out of bounds" unless (1..31).include?(options[:day])
    end

  end
end
