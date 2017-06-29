file = File.new("football.dat", "r")
onDataLines = false;
lowestSpreadTeam = "";
lowestSpread = 999;
while (line = file.gets)
  line.strip!

  onDataLines = true if(!onDataLines && line[0..1] == "1.")
  onDataLines = false if(onDataLines && line[0..2] == "---")

  if onDataLines
    data = line.gsub(/\s+/m, ' ').strip.split(" ")
    spread = (Integer(data[6]) - Integer(data[8])).abs
    if(spread < lowestSpread)
      lowestSpreadTeam = data[1]
      lowestSpread = spread;
    end
  end
end
file.close
puts "The lowest spread was team #{lowestSpreadTeam}: #{lowestSpread}"