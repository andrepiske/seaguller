require 'test_helper'

class BlockTest < Seaguller::Test
  def test_basic_rendering
    block = Block.new(15, 3)
    block.paper.put_line(1, 1, 'hello world')

    expected_text =
      "               \n" +
      " hello world   \n" +
      "               "

    assert_equal expected_text, block.to_s
  end

  def test_cropped_rendering
    block = Block.new(10, 3)
    block.paper.put_line(1, 1, 'hello world')

    expected_text =
      "          \n" +
      " hello wor\n" +
      "          "

    assert_equal expected_text, block.to_s
  end

  def test_margin_rendering
    block = Block.new(4, 1, 0, [1, 2, 3, 4])
    block.paper.put_line(1, 0, 'oi')

    expected_text =
      "          \n" +
      "     oi   \n" +
      "          \n" +
      "          \n" +
      "          "

    assert_equal expected_text, block.to_s
  end

  def test_value_normalization_3
    block = Block.new(3, 1, 1, 1, [1, 3, 2])
    block.paper.put_line(0, 0, 'hey')

    expected_text =
      "             \n" +
      " +---------+ \n" +
      " |         | \n" +
      " |   hey   | \n" +
      " |         | \n" +
      " |         | \n" +
      " +---------+ \n" +
      "             "

    assert_equal expected_text, block.to_s
  end

  def test_value_normalization_nil
    block = Block.new(3, 1, 1, 1, nil)
    block.paper.put_line(0, 0, 'hey')

    expected_text =
      "       \n" +
      " +---+ \n" +
      " |hey| \n" +
      " +---+ \n" +
      "       "

    assert_equal expected_text, block.to_s
  end

  def test_value_normalization_true
    block = Block.new(3, 1, 1, 1, true)
    block.paper.put_line(0, 0, 'hey')

    expected_text =
      "         \n" +
      " +-----+ \n" +
      " |     | \n" +
      " | hey | \n" +
      " |     | \n" +
      " +-----+ \n" +
      "         "

    assert_equal expected_text, block.to_s
  end

  def test_full_render
    block = Block.new(3, 1, 1, [1, 2], [2, 1])
    block.paper.put_line(0, 0, 'hi!')

    expected_text =
      "           \n" +
      "  +-----+  \n" +
      "  |     |  \n" +
      "  |     |  \n" +
      "  | hi! |  \n" +
      "  |     |  \n" +
      "  |     |  \n" +
      "  +-----+  \n" +
      "           "

    assert_equal expected_text, block.to_s
  end
end
