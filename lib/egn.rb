require "egn/version"

module Egn
  PARITY_WEIGHTS = [2,4,8,5,10,9,7,3,6]

  def self.generate
    year = Random.rand(1800..2000)
    mon = Random.rand(1..12)
    day = Random.rand(1..31)
    cent = year - (year % 100)
    sex = Random.rand(1..2)

    if cent == 1800
      mon += 20
    elsif cent == 2000
      mon += 40
    end

    region = Random.rand(0..999)

    if sex == 1 && (region %2 != 0)
      region -= 1
    elsif sex == 2 && (region % 2 == 0)
      region += 1
    end

    final_year = year - cent
    egn = final_year.to_s.rjust(2, '0') + mon.to_s.rjust(2, '0') + day.to_s.rjust(2,'0') + region.to_s.rjust(3,'0')

    return egn + gen_checksum(egn).to_s
  end

  def self.gen_checksum(egn)
    sum = egn.split('').map(&:to_i).zip(PARITY_WEIGHTS).map { |n| n.reduce(:*) }.reduce(:+)

    rest = sum % 11
    rest < 10 ? rest : 0
  end
end
