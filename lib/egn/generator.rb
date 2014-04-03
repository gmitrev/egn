# Generates a random valid EGN
module Egn
  class Generator
    attr_reader :options

    # Convinience method
    def self.generate(options={})
      Generator.new(options).generate
    end

    def initialize(options={})
      @options = defaults.merge(options)

      validate!(@options)
    end

    # The generated EGN will be completely random if no opitons are given.
    # options is a hash that may have the following keys: :year, :month and :date
    def generate
      randomize_options

      egn = options[:year].to_s.rjust(2, '0') +
            options[:month].to_s.rjust(2, '0') +
            options[:day].to_s.rjust(2,'0') +
            options[:region].to_s.rjust(3,'0')

      return egn + Util.egn_checksum(egn).to_s
    end

    # Check if the options contain a date that is valid and be turned into an EGN
    def validate!(options)
      raise ArgumentError, "Year out of bounds" unless (1800..2099).include?(options[:year])
      raise ArgumentError, "Month out of bounds" unless (1..12).include?(options[:month])
      raise ArgumentError, "Day out of bounds" unless (1..31).include?(options[:day])
    end

    def defaults
      date = Util.time_rand
      {
        year:  date.year,
        month: date.month,
        day:   date.day
      }
    end

    def randomize_options
      # Get random century, region and sex
      options[:century] = options[:year] - (options[:year] % 100)
      options[:region] = Random.rand(0..999)
      options[:sex] = Random.rand(1..2)

      # Recalculate month based on the century
      options[:month] += 20 if options[:century] == 1800
      options[:month] += 40 if options[:century] == 2000

      # Recalculate region based on sex
      if options[:sex] == 1 && options[:region].odd?
        options[:region] -= 1
      elsif options[:sex] == 2 && options[:region].even?
        options[:region] += 1
      end

      options[:year] = options[:year] - options[:century]
    end


  end
end
