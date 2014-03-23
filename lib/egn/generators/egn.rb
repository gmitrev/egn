module Egn
  module Generators
    module Egn

      PARITY_WEIGHTS = [2,4,8,5,10,9,7,3,6]

      def self.generate(options={})
        date = time_rand

        options = {
          year:  date.year,
          month: date.month,
          day:   date.day
        }.merge(options)

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

        return egn + egn_checksum(egn).to_s
      end

      def self.egn_checksum(egn)
        sum = egn.split('').map(&:to_i).zip(PARITY_WEIGHTS).map { |n| n.reduce(:*) }.reduce(:+)

        rest = sum % 11
        rest < 10 ? rest : 0
      end

      def self.time_rand(from = 0.0, to = Time.now)
        Time.at(from + rand * (to.to_f - from.to_f))
      end

    end
  end
end
