defmodule YaegeTest do
  use ExUnit.Case
  doctest Yaege

  test "greets the world" do
    assert Yaege.hello() == :world
  end
end
