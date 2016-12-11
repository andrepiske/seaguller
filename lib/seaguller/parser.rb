require 'test_helper'

class Parser
  attr_accessor :pipe

  def initialize(pipe)
    @pipe = pipe
    @started = false
    @buffer = []
  end

  def feed(content)
    @buffer += content.split('')
    if !@started
      @started = true
      @feed_fiber = Fiber.new &tokenizer_block
    end

    @feed_fiber.resume
  end

  private

  def lookahead(n = 1)
    while @buffer.length < n
      Fiber.yield
    end
    @buffer.take(n).join ''
  end

  def consume(n = 1)
    while @buffer.length < n
      Fiber.yield
    end
    @buffer.shift(n).join ''
  end

  def tokenizer_run
    loop do
      chr = consume
      if chr == nil
        break
      elsif chr == "\n"
        pipe.break_line
      elsif chr == '\\'
        x = lookahead
        if x == '{'
          pipe.print_char consume
        end
      else
          pipe.print_char chr
      end
    end
  end

  def tokenizer_block
    Proc.new do
      tokenizer_run
    end
  end
end
