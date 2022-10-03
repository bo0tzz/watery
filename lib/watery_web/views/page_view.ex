defmodule WateryWeb.PageView do
  use WateryWeb, :view

  def pretty_frequency(days) do
    Timex.Duration.from_days(days)
    |> Timex.Format.Duration.Formatters.Humanized.format()
  end

  def pretty_days_since(moment) do
    Timex.Interval.new(from: moment, until: DateTime.utc_now())
    |> Timex.Interval.duration(:days)
    |> case do
      0 -> "Today"
      days -> pretty_frequency(days) <> " ago"
    end
  end

  def color(plant) do
    IO.inspect(plant)

    Timex.diff(DateTime.utc_now(), plant.last_watered, :days)
    |> IO.inspect()
    |> case do
      days when days > plant.frequency -> "color: red"
      _ -> "color: green"
    end
  end
end
