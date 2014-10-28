# The main data class
module Egn
  class Egn
    attr_reader :number, :birth_date

    # Creates a new EGN object. Has different effects depending on the argument.
    # When no arguments are given, it generates a new random EGN
    # When a String is given, it is assumed that it is an EGN and is parsed
    # When a hash is given, a new EGN is generated with the provided options
    def initialize(args=nil)

      if args.nil?
        @number = Generator.generate
      else
        case args
        when Hash
          @number = Generator.generate(args)
        when String
          @number = args
          raise ArgumentError, "Invalid EGN" unless self.valid?
        else
          raise ArgumentError, "Egn#new should be called either with an EGN or with an options hash"
        end
      end

      parse!
    end

    # Is the number valid?
    def valid?
      @valid ||= Validator.validate(@number)
    end

    def day
      @birth_date.day
    end

    def month
      @birth_date.month
    end

    def year
      @birth_date.year
    end

    def sex
      number[8,1].to_i.even? ? :male : :female
    end

    def to_s
      @number
    end

    private

    # Extract the birth_date, sex and region
    def parse!
      info = Parser.new(@number)

      @birth_date = info.date
    end

  end
end
