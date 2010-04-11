module BoardsHelper

  def board_link(board)
    link_to board.name, board_url(board)
  end

end
