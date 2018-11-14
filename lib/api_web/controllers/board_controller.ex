defmodule ApiWeb.BoardController do
  use ApiWeb, :controller

  def postBoard(conn, _params) do
    json conn, ["postBoard"]
  end

  def putBoard(conn, _params) do
    json conn, ["putBoard"]
  end

  def getBoard(conn, _params) do
    json conn, ["getBoard"]
  end

  def deleteBoard(conn, _params) do
    json conn, ["deleteBoard"]
  end

  def clearBoard(conn, _params) do
    json conn, ["clearBoard"]
  end

  def postBoardItem(conn, _params) do
    json conn, ["postBoardItem"]
  end
end
