file = File.new("weather.dat", "r")
onDataLines = false;
lowestSpreadDay = "";
lowestSpread = 999;
while (line = file.gets)
  line.strip!
  line.gsub!("*", "")

  onDataLines = true if(!onDataLines && line[0..3] == "1  8")
  onDataLines = false if(onDataLines && line[0..1] == "mo")

  if onDataLines
    data = line.gsub(/\s+/m, ' ').strip.split(" ");
    spread = Integer(data[1]) - Integer(data[2]);
    if(spread < lowestSpread)
      lowestSpreadDay = data[0];
      lowestSpread = spread;
    end
  end
end
file.close
puts "The lowest spread was on day #{lowestSpreadDay}: #{lowestSpread}"