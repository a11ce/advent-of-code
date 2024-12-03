class Part1 
  def initialize
   total = 0
   inp = File.read("input.txt")
   m_re = /mul\(\d+,\d+\)/
   matched = inp.scan(m_re)
   matched.each{|m| 
    s = m.split(/\(|,|\)/)
    total += Integer(s[1]) * Integer(s[2])
   }
  puts total
  end
end

class Part2
  def initialize
   total = 0
   enabled = TRUE
   inp = File.read("input.txt")
   m_re = /mul\(\d+,\d+\)|do\(\)|don't\(\)/#'
   matched = inp.scan(m_re)
   matched.each{|m|
    if m == "do()"
      enabled = TRUE
    elsif m == "don't()"
      enabled = FALSE
    elsif enabled
        s = m.split(/\(|,|\)/)
        total += Integer(s[1]) * Integer(s[2])
    end
   }
  puts total
  end
end

Part1.new
Part2.new
