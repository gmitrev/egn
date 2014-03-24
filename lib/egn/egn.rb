module Egn
  class Egn
    attr_reader :number, :year, :month, :day, :birth_date

    def initialize(args=nil)

      if args.nil?
        @number = Generators::Egn.generate
      else
        case args
        when Hash
          @number = Generators::Egn.generate(args)
        when String
          @number = args
          raise ArgumentError, "Invalid EGN" unless self.valid?
        else
          raise ArgumentError, "Egn#new should be called either with an EGN or with an options hash"
        end
      end

      parse!
    end

    def valid?
      @valid ||= Validators::Egn.validate(@number)
    end

    private

    def parse
      parser = Parser::Egn.new(@number)


    end

  end
end
