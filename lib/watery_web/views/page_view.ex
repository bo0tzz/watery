defmodule WateryWeb.PageView do
  use WateryWeb, :view

  def pretty_frequency(days) do
    Timex.Duration.from_days(days)
    |> Timex.Format.Duration.Formatters.Humanized.format()
  end

  def pretty_days_since_watered(plant) do
    days_since_watered(plant)
    |> case do
      0 -> "Today"
      days -> pretty_frequency(days) <> " ago"
    end
    |> dbg()
  end

  def color(plant) do
    days_since_watered(plant)
    |> case do
      days when days > plant.frequency -> "color: red"
      days when days == plant.frequency -> "color: orange"
      _ -> "color: green"
    end
    |> dbg()
  end

  def days_since_watered(plant) do
    plant.last_watered
    |> DateTime.to_date()
    |> Date.diff(Date.utc_today())
    |> Kernel.*(-1)
  end
end
