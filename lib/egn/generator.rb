# Generates a random valid EGN
module Egn
  module Generator

    # The generated EGN will be completely random if no opitons are given.
    # options is a hash that may have the following keys: :year, :month and :date
    def self.generate(options={})
      options = defaults.merge(options)

      validate!(options)

      century = options[:year] - (options[:year] % 100)
      sex = Random.rand(1..2)

      options[:month] += 20 if century == 1800
      options[:month] += 40 if century == 2000

      region = Random.rand(0..999)

      if sex == 1 && region.odd?
        region -= 1
      elsif sex == 2 && region.even?
        region += 1
      end

      final_year = options[:year] - century
      egn = final_year.to_s.rjust(2, '0') +
            options[:month].to_s.rjust(2, '0') +
            options[:day].to_s.rjust(2,'0') +
            region.to_s.rjust(3,'0')

      return egn + Util.egn_checksum(egn).to_s
    end

    # Check if the options contain a date that is valid and be turned into an EGN
    def self.validate!(options)
      raise ArgumentError, "Year out of bounds" unless (1800..2099).include?(options[:year])
      raise ArgumentError, "Month out of bounds" unless (1..12).include?(options[:month])
      raise ArgumentError, "Day out of bounds" unless (1..31).include?(options[:day])
    end

    def self.defaults
      date = Util.time_rand
      {
        year:  date.year,
        month: date.month,
        day:   date.day
      }
    end

  end
end
