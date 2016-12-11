require 'seaguller/buffered_paper'

class Printer
  def initialize(paper)
    @paper = paper
    @x, @y = 0, 0
  end

  def move_to(x, y)
    @x, @y = x, y
  end

  def move_by(x, y)
    @x, @y = @x+x, @y+y
  end

  def break_line
    @x, @y = 0, @y+1
  end

  def print_block(block)
    lines = block.to_s.split("\n")
    height = lines.length
    width = (height == 0) ? 0 : lines[0].length
    return if width == 0
    lines.zip(height.times) do |line, offset|
      @paper.put_line(@x, @y + offset, line)
    end
    @y += height - 1
    @x += width
  end


  def print_char(char)
    @paper.put_char @x, @y, char
    @x += 1
  end

  def print_line(text)
    @paper.put_line @x, @y, text
    @x += text.length
  end
end
