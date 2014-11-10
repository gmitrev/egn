# Generates a random valid EGN
module Egn
  class Generator
    attr_reader :options

    # Convinience method
    def self.generate(options={})
      Generator.new(options).generate
    end

    def initialize(options={})
      validate!(options)
      set_defaults!(options)
      process!
    end

    # The generated EGN will be completely random if no opitons are given.
    # options is a hash that may have the following keys: :year, :month, :day, :gender
    def generate
      egn = format(options[:year]) +
            format(options[:month]) +
            format(options[:day]) +
            format(options[:region], 3)

      egn + Util.egn_checksum(egn).to_s
    end

    private

    def set_defaults!(options)
      @options = {}

      until Date.valid_date?(@options[:year].to_i, @options[:month].to_i, @options[:day].to_i)
        @options = defaults.merge(options)
      end

    end

    # Little helper
    def format(val, pre=2)
      val.to_s.rjust(pre, '0')
    end

    # Check if the options contain a date that is valid and be turned into an EGN
    def validate!(options)
      raise ArgumentError, "Year out of bounds" if options[:year] && !(1800..2099).include?(options[:year])
      raise ArgumentError, "Month out of bounds" if options[:month] && !(1..12).include?(options[:month])
      raise ArgumentError, "Day out of bounds" if options[:day] && !(1..31).include?(options[:day])
      raise ArgumentError, "Gender should be one of #{genders}" if options[:gender] && !genders.include?(options[:gender])
    end

    # Random defaults
    def defaults
      date = -> { Util.time_rand }.call
      {
        year:    date.year,
        month:   date.month,
        day:     date.day,
        gender:  genders.sample,
        region:  Random.rand(0..999)
      }
    end

    def process!
      # Get random century, region and gender
      century = determine_century(options[:year])

      options[:month] += month_delta(century)

      options[:region] += region_delta(options[:gender], options[:region])

      options[:year] = options[:year] - century
    end

    # Recalculate region based on gender
    def region_delta(gender, region)
      if gender == :male && region.odd?
        -1
      elsif gender == :female && region.even?
        1
      else
        0
      end
    end

    def month_delta(century)
      if century == 1800
        20
      elsif century == 2000
        40
      else
        0
      end
    end

    def determine_century(year)
      year - (year % 100)
    end

    def genders
      [:male, :female]
    end

  end
end
