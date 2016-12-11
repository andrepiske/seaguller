require 'test_helper'

class Seaguller::ParserTest < Seaguller::Test
  def test_parse
    pipe = Object.new
    mock(pipe).print_char 'h'
    mock(pipe).print_char '{'
    mock(pipe).break_line
    mock(pipe).print_char 'e'

    parser = Parser.new pipe
    parser.feed "h\\{\ne"
    parser.feed nil
  end

  def test_closed_buffer
    pipe = Object.new
    stub(pipe).print_char

    parser = Parser.new pipe
    parser.feed 'a'
    parser.feed nil
    assert_raises(Parser::BufferAlreadyClosedError) { parser.feed 'b' }
  end

  def test_parse_simple_test
    pipe = Object.new
    mock(pipe).print_char 'a'
    mock(pipe).print_char 'b'
    mock(pipe).print_char 'c'
    mock(pipe).print_char '1'
    mock(pipe).print_char '2'
    mock(pipe).print_char '3'
    mock(pipe).print_char 'x'
    mock(pipe).print_char 'y'
    mock(pipe).print_char 'z'

    parser = Parser.new pipe

    parser.feed 'abc'
    parser.feed '123'
    parser.feed 'xyz'
  end
end
