gem "minitest"
require "minitest/autorun"
require "seaguller"

class TestSeaguller < Minitest::Test
  def test_it
    paper = BufferedPaper.new(72, 60)
    printer = Printer.new paper
    printer.move_to 0, 0
    printer.print_line 'Hello World!'

    blk = Block.new(40, 1, 1, 0, 1)
    blk_printer = Printer.new(blk.paper)
    blk_printer.print_line('hey there.')

    printer.move_to 3, 20
    printer.print_block blk

    File.write('/tmp/ff1.txt', paper.to_s)
  end
end
