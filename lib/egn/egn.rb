module Egn
  class Egn
    attr_reader :number, :year, :month, :day

    def initialize(args=nil)

      if args.nil?
        @number = Generators::Egn.generate
      end

    end

    def valid?
      @valid ||= Validators::Egn.validate(@number)
    end

    def birth_date

    end

  end
end
