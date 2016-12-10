require 'seaguller/block'
require 'seaguller/printer'

class Seaguller
  VERSION = "1.0.0"

  attr_accessor :page_width
  attr_accessor :page_height
  attr_accessor :lines

  def initialize(content)
    # lines = content.split("\n")
  end

  def produce
  end
end
