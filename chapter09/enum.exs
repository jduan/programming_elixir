require Integer

ExUnit.start

defmodule MyTest do
  use ExUnit.Case

  def lst do
    Enum.to_list 1..5
  end

  test "MyList.concat" do
    assert Enum.concat([1,2,3], [4,5,6]) == [1,2,3,4,5,6]
    assert Enum.concat([1,2,3], 'abc') == [1,2,3,97,98,99]
  end

  test "MyList.map" do
    assert Enum.join(lst) == "12345"
    assert Enum.join(lst, ",") == "1,2,3,4,5"
  end

  test "MyList.at" do
    assert Enum.at(10..20, 3) == 13
    assert Enum.at(10..20, 20) == nil
    assert Enum.at(10..20, 20, :no_one_here) == :no_one_here
  end

  test "MyList.filter" do
    assert Enum.filter(lst, &(&1 > 2)) == [3,4,5]
    assert Enum.filter(lst, &Integer.even?/1) == [2,4]
  end

  test "MyList.sort" do
    assert Enum.sort(["there", "was", "a", "crooked", "man"]) ==
    ["a", "crooked", "man", "there", "was"]
    assert Enum.sort(["there", "was", "a", "crooked", "man"],
    &(String.length(&1) <= String.length(&2))) ==
    ["a", "was", "man", "there", "crooked"]
  end

  test "MyList.max" do
    assert Enum.max(["there", "was", "a", "crooked", "man"]) == "was"
    assert Enum.max_by(["there", "was", "a", "crooked", "man"],
    &String.length/1) == "crooked"
  end

  test "MyList.take" do
    assert Enum.take(lst, 3) == [1,2,3]
    assert Enum.take_every(lst, 2) == [1,3,5]
    assert Enum.take_while(lst, &(&1 < 4)) == [1,2,3]
  end

  test "MyList.split" do
    assert Enum.split(lst, 3) == {[1,2,3], [4,5]}
    assert Enum.split_while(lst, &(&1 < 4)) == {[1,2,3], [4,5]}
  end

  test "MyList.join" do
    assert Enum.join(lst) == "12345"
    assert Enum.join(lst, ",") == "1,2,3,4,5"
  end
end
