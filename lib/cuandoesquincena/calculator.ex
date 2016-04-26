defmodule Cuandoesquincena.Calculator do
  use Timex

  def seconds_until do
    DateTime.today |> next_canonical_paydate |> real_paydate |> Timex.diff(DateTime.today, :seconds)
  end

  defp real_paydate(%Timex.DateTime{day: day} = canonical) do
    weekday = Timex.weekday canonical
    %{canonical | day: (day + (%{6 => -1, 7 => -2}[weekday] || 0 )) }
  end

  defp next_canonical_paydate(%Timex.DateTime{year: year, month: month, day: day} = payday)  do
    canonical_payday = if day > 15, do: :calendar.last_day_of_the_month(year, month), else: 15
    %{payday | day: canonical_payday}
  end

end
