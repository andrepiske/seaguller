require 'test_helper'

class PrintTest < Minitest::Test
  def test_basic_printing_sequence
    paper = mock(my_mock_object = Object.new)
    stub(paper).put_char 2, 3, 'x'
    stub(paper).put_line 3, 3, 'hi'
    stub(paper).put_char 5, 3, '!'

    printer = Printer.new(paper)
    printer.move_to 2, 3
    printer.print_char 'x'
    printer.print_line 'hi'
    printer.print_char '!'
  end

  def test_moving_around
    paper = mock(my_mock_object = Object.new)
    stub(paper).put_line 0, 0, 'hello'
    stub(paper).put_line 6, 1, 'world'
    stub(paper).put_line 1, 1, 'hello'

    printer = Printer.new(paper)
    printer.print_line 'hello'
    printer.move_by 1, 1
    printer.print_line 'world'
    printer.move_to 1, 1
    printer.print_line 'hello'
  end

  def test_line_breaking
    paper = mock(my_mock_object = Object.new)
    stub(paper).put_line 0, 0, 'hello'
    stub(paper).put_line 0, 1, 'world'
    stub(paper).put_char 5, 1, '!'

    printer = Printer.new(paper)
    printer.print_line 'hello'
    printer.break_line
    printer.print_line 'world'
    printer.print_char '!'
  end
end
