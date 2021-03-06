class Player
  attr_reader :first_name, :last_name, :batting_contact, :batting_power, :throwing_velocity, :throwing_accuracy, :fielding, :speed

  def initialize(first_name, last_name, batting_contact, batting_power,
                throwing_velocity, throwing_accuracy, fielding, speed)
    @first_name = first_name
    @last_name = last_name
    @batting_contact = batting_contact
    @batting_power = batting_power
    @throwing_velocity = throwing_velocity
    @throwing_accuracy = throwing_accuracy
    @fielding = fielding
    @speed = speed
  end

################# PITCHER ######################

  def pitch_placement
    placed = nil
    #MLB pitchers average 62% strikes
    if rand(throwing_accuracy + 50) > throwing_accuracy
      placed = :ball
    else
      placed = :strike
    end
    placed
  end

################# BATTER ######################

  def swing?(placement)
    roll = rand(100)
    if placement == :strike
      #MLB batters swing at 65% of strikes
      if roll > 35
        swing = true
      else
        swing = false
      end
    elsif placement == :ball
      #MLB batters swing at 30% of balls
      if roll > 70
        swing = true
      else
        swing = false
      end
    # else raise "batter_swing error!"
    end
    swing
  end

  def contact?(placement, pitcher_velocity)
    #MLB batters make contact with swung-at strikes 88% of the time
    if placement == :strike
      if rand < log_five((batting_contact + 2 / 3 * (100 - batting_contact)), pitcher_velocity)
        contact = true
      else
        contact = false
      end
    elsif placement == :ball
    #MLB batters make contact with strikes 68% of the time
      if rand < log_five((batting_contact + 1 / 3 * (100 - batting_contact)), pitcher_velocity)
      contact = true
      else
      contact = false
      end
    # else raise "batter_contact error!"
    end
    contact
  end

  def fair_ball?(pitcher_velocity)
    #batters foul of 40.5% of balls they make contact with (does not count foulouts)
    if rand < log_five((batting_contact + 1 / 6 * (100 - batting_contact)), pitcher_velocity)
      ball = :fair
    else
      if rand(10) > 1
        ball = :foul
      else
        ball = :foulout
      end
    end
    ball
  end

  def hit?
    if rand(100 + batting_contact) > batting_contact
      ball = :fielded
    else
      ball = :hit
    end
    ball
  end

  def extra_bases?
    #hits are: 67.6% singles, 19.5% doubles, 1.9% triples, 11.0% homeruns
    roll = rand(280 + batting_power + speed)
    if roll < (batting_power / 2)
      hit = :homerun
    elsif roll < ((batting_power / 2) + (speed / 8))
      hit = :triple
    elsif roll < (batting_power + speed)
      hit = :double
    else hit = :single
    end
    hit
  end

################# FIELDER ######################

  def field_ball
    fielded = nil
    if rand(500) > (400 + fielding)
      fielded = false
    else fielded = true
    end
    fielded
  end

end
