defmodule SleepChartWeb.Helpers.DateTest do
    alias SleepChartWeb.Helpers.Date, as: DateHelper
    use ExUnit.Case, async: true
  
    describe "format_slug/1" do
        test "valid date" do
            actual = DateHelper.format_slug ~D[2019-01-01]
            assert actual == "2019-01-01"
        end
    end

    describe "parse_slug/1" do
        test "valid date" do
            actual = DateHelper.parse_slug "2019-01-01"
            assert actual == {:ok, ~D[2019-01-01]}
        end

        test "invalid date" do
            actual = DateHelper.parse_slug "2019-01-40"
            assert {:error, _} = actual
        end

        test "valid date in wrong format" do
            actual = DateHelper.parse_slug "2019-4-1"
            assert {:error, _} = actual
        end

        test "not a date" do
            actual = DateHelper.parse_slug "foobar"
            assert {:error, _} = actual
        end
    end
  end
  