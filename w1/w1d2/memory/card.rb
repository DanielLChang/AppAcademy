class Card

  FACEDOWN_APPEARANCE = "-"

  attr_reader :faceup, :value

  def initialize(value)
    @value = value
    @faceup = false
  end

  def hide
    @faceup = false
  end

  def reveal
    @faceup = true
  end

  def to_s
    faceup ? value : FACEDOWN_APPEARANCE
  end

  def ==(other)
    return false unless other.is_a?(Card)
    self.value == other.value
  end

end
