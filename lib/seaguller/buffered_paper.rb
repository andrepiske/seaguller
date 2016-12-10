class BufferedPaper
  # attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    init_buffer
  end

  def put_char(x, y, chr)
    return false unless ((0...@width) === x && (0...@height) === y)
    chr = '?' if (chr == "\n" || chr == "\r")
    @buffer[y][x] = chr
  end

  def put_line(x, y, string)
    string.split('').zip(string.length.times).each do |c, offset|
      put_char(x + offset, y, c)
    end
  end

  def to_s
    @buffer.map(&:join).join("\n")
  end

  # alias :render :to_s

  private

  def init_buffer
    @buffer = @height.times.map do
      @width.times.map { ' ' }
    end
  end
end
