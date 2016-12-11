require 'test_helper'

class Seaguller::ParserTest < Seaguller::Test
  def test_parse
    pipe = Object.new
    mock(pipe).print_char 'h'
    mock(pipe).print_char '{'
    mock(pipe).print_char 'e'

    parser = Parser.new pipe
    parser.feed 'h\\{e'
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
