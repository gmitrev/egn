# The main data class
module Egn
  class Egn
    attr_reader :number, :birth_date

    # Creates a new EGN object. Has different effects depending on the arguments:
    # when no arguments are given, it generates a new random EGN;
    # when a String is given, it is parsed as an EGN;
    # when a hash is given, a new EGN is generated with the provided options.
    def initialize(args = nil)
      if args.nil?
        @number = Generator.generate
      else
        case args
        when Hash
          @number = Generator.generate(args)
        when String
          @number = args
          raise ArgumentError, 'Invalid EGN' unless self.valid?
        else
          raise ArgumentError, 'Egn#new should be called either with an EGN or with an options hash'
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

    def age
      @birth_date
      ((Date.today - @birth_date) / 365).floor
    end

    # Formats
    # default: :male | :female
    # number:      1 | 2
    # char:      'm' | 'f'
    def sex(options = {})
      options = {
        format: :default
      }.merge(options)

      male = number[8, 1].to_i.even?

      case options[:format]
      when :default
        male ? :male : :female
      when :number
        male ? 1 : 2
      when :char
        male ? 'm' : 'f'
      end
    end
    alias_method :gender, :sex

    def to_s
      "#{@number} | Gender: #{gender} | Birthdate: #{@birth_date} | Valid: #{valid?}"
    end

    private

    # Extract the birth_date, sex and region
    def parse!
      info = Parser.new(@number)

      @birth_date = info.date
    end
  end
end
