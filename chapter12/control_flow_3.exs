ExUnit.start

defmodule Test do
  use ExUnit.Case

  test "ok! normal" do
    assert Play.ok!(File.open("/usr/share/dict/words"))
  end

  test "ok! exception" do
    assert_raise RuntimeError, fn ->
      Play.ok!(File.open("/invalid/path"))
    end
  end
end

defmodule Play do
  def ok!({:ok, data}), do: data
  def ok!({error_type, error_msg}), do: raise "#{error_type}: #{error_msg}"
end
