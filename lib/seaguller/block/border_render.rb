module BlockBorderRender
  def draw_border(canvas, start, stop, line='-', corner='+')
    (start[0]..stop[0]).to_a.product((start[1]..stop[1]).to_a).each do |coord|
      canvas.put_char(coord[0], coord[1], line)
    end
    canvas.put_char(start[0], start[1], corner)
    canvas.put_char(start[0], stop[1], corner)
    canvas.put_char(stop[0], start[1], corner)
    canvas.put_char(stop[0], stop[1], corner)
  end

  def draw_borders(render_paper)
    cborder[0].times do |offset_y|
      y = offset_y + cmargin[0]
      draw_border(render_paper, [ cmargin[3], y ], [ @final_width-cmargin[1]-1, y ])
    end
    cborder[2].times do |offset_y|
      y = @final_height - (cmargin[2] + offset_y) - 1
      draw_border(render_paper, [ cmargin[3], y ], [ @final_width-cmargin[1]-1, y ])
    end
    cborder[3].times do |offset_x|
      x = cmargin[3] + offset_x
      draw_border(render_paper, [ x, cmargin[0] ], [ x, @final_height-cmargin[2]-1 ], '|')
    end
    cborder[1].times do |offset_x|
      x = @final_width - (cmargin[1] + offset_x) - 1
      draw_border(render_paper, [ x, cmargin[0] ], [ x, @final_height-cmargin[2]-1 ], '|')
    end
  end
end
