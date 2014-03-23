module Egn
  class Egn
    attr_reader :number

    def initialize(args=nil)

      if args.nil?
        @number = Generators::Egn.generate
      end

    end

    def valid?
    end

    def birth_date

    end

    def sex

    end

    def region

    end

  end
end
