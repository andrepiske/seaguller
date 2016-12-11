require 'test_helper'

class Parser
  attr_accessor :pipe

  class BufferAlreadyClosedError < StandardError; end;

  def initialize(pipe)
    @pipe = pipe
    @started = false
    @buffer = []
    @buffer_is_closed = false
  end

  def feed(content)
    raise BufferAlreadyClosedError.new if @buffer_is_closed

    if content == nil
      @buffer << nil
      @buffer_is_closed = true
    else
      @buffer += content.split('')
    end
    if !@started
      @started = true
      @feed_fiber = Fiber.new &tokenizer_block
    end

    @feed_fiber.resume
  end

  private

  def lookahead(n = 1)
    fill_up_buffer(n)
    return nil if @buffer.first == nil
    @buffer.take(n).join('')
  end

  def consume(n = 1)
    fill_up_buffer(n)
    return nil if @buffer.first == nil
    @buffer.shift(n).join('')
  end

  def fill_up_buffer(n)
    while @buffer.length < n
      return if @buffer_is_closed
      Fiber.yield
    end
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
