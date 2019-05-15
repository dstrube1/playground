class BowlingGame
  def initialize(frames)
    @score_string = frames
    @total_score=0

    @bonus_frames = 0
    if frames[frames.length-3] == "X"
      @bonus_frames = 2
    elsif frames[frames.length-2] == "/"
      @bonus_frames = 1
    end

    twoAgo = ""
    oneAgo = ""
    framesLeft = frames.length
    frames.split("").each do
      |frame|
      framesLeft -= 1
      point_value = self.point_value(frame, oneAgo)
      multiplier = 1

      multiplier += 1 if twoAgo == "X" && framesLeft >= @bonus_frames
      multiplier += 1 if ((oneAgo == "/" || oneAgo == "X") && framesLeft >= @bonus_frames) || (oneAgo == "X" && framesLeft == 1)

      @total_score += multiplier*point_value
      twoAgo = oneAgo
      oneAgo = frame
    end
  end

  def point_value(frame, lastFrame)
    if frame.to_s.match(/[0-9]/) && frame.length == 1
      Integer(frame)
    elsif frame == "/"
      10-Integer(lastFrame)
    elsif frame == "X"
      10
    else
      0
    end
  end

  def bonus_frames
    @bonus_frames
  end

  def score_string
    @score_string
  end

  def total_score
    @total_score
  end
end