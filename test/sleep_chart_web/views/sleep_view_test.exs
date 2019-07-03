defmodule SleepChartWeb.SleepViewTest do
  use SleepChartWeb.ConnCase, async: true
  alias SleepChartWeb.SleepView

  describe "friendly_date/2" do
    test "today" do
      assert SleepView.friendly_date(~D[2019-04-06], ~D[2019-04-06]) == "Today"
    end

    test "not today" do
      assert SleepView.friendly_date(~D[2019-04-06], ~D[2019-04-05]) == "Saturday, 6 April"
    end
  end

end
