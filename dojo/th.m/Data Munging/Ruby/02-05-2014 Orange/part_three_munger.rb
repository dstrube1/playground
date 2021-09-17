class PartThreeMunger
  def munge(file, startToken, stopToken, keyIndex, data1Index, data2Index, useAbs = false)
    file = File.new(file, "r")
    onDataLines = false;
    lowestSpreadKey = "";
    lowestSpread = 999;
    while (line = file.gets)
      line.strip!
      line.gsub!("*", "")

      onDataLines = true if(!onDataLines && line[0..(startToken.length-1)] == startToken)
      onDataLines = false if(onDataLines && line[0..(stopToken.length-1)] == stopToken)

      if onDataLines
        data = line.gsub(/\s+/m, ' ').strip.split(" ");
        spread = Integer(data[data1Index]) - Integer(data[data2Index]);
        spread = spread.abs if useAbs

        if(spread < lowestSpread)
          lowestSpreadKey = data[keyIndex];
          lowestSpread = spread;
        end
      end
    end
    file.close

    return {"key"=>lowestSpreadKey, "spread"=>lowestSpread}
  end
end