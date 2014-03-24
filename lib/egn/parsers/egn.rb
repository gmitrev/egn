module Egn
  module Parsers
    class Egn

      def initialize(egn)
        return ArgumentError, 'invalid length (should == 10)' unless egn.length == 10

        @year, @month, @day = egn.scan(/.{1,2}/)
        @month = @month.to_i
        @day = @day.to_i

        case @month
        when (1..12)
          @year = "19#{@year}"
        when (21..32)
          @month -= 20
          @year = "18#{@year}"
        when (41..52)
          @month -= 40
          @year = "20#{@year}"
        end
        @year = @year.to_i

        raise ArgumentError, "invalid date" unless Date.valid_date? @year, @month, @day
      end

      def birth_date
        Date.parse("#{@year}-#{@month}-#{@day}")
      end

    end
  end
end
