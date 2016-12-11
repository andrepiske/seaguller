require 'seaguller/buffered_paper'
require 'seaguller/block/border_render'

class Block
  attr_reader :width, :height
  attr_reader :paper

  attr_accessor :border
  attr_accessor :margin
  attr_accessor :padding

  def initialize(width, height, border=0, margin=0, padding=0)
    @border = border
    @margin = margin
    @padding = padding

    @width = width
    @height = height

    @final_width = width + cborder[1] + cborder[3] + cpadding[1] + cpadding[3] + cmargin[1] + cmargin[3]
    @final_height = height + cborder[0] + cborder[2] + cpadding[0] + cpadding[2] + cmargin[0] + cmargin[2]

    @paper = BufferedPaper.new(width, height)
  end

  def to_s
    render_paper = BufferedPaper.new(@final_width, @final_height)

    offset_y = cmargin[0] + cborder[0] + cpadding[0]
    @paper.to_s.split("\n").each do |line|
      render_paper.put_line(cmargin[3] + cborder[3] + cpadding[3], offset_y, line)
      offset_y += 1
    end

    draw_borders render_paper
    render_paper.to_s
  end

  def canonical_border
    @canonical_border ||= normalize_value(border)
  end
  alias :cborder :canonical_border

  def canonical_padding
    @canonical_padding ||= normalize_value(padding)
  end
  alias :cpadding :canonical_padding

  def canonical_margin
    @canonical_margin ||= normalize_value(margin)
  end
  alias :cmargin :canonical_margin

  protected

  # [ top, right, bottom, left ]
  def normalize_value(x)
    if x.is_a?(Fixnum)
      [x] * 4
    elsif x.respond_to?(:length) && x.length == 2
      [x[0], x[1], x[0], x[1]]
    elsif x.respond_to?(:length) && x.length == 3
      [x[0], x[1], x[2], x[1]]
    elsif x.respond_to?(:length) && x.length == 4
      x.dup
    elsif x == true
      [1] * 4
    else
      [0] * 4
    end
  end

  include BlockBorderRender
end
