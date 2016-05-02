defmodule Cuandoesquincena.Calculator do
  use Timex

  def is_today? do
    Date.today == next_real_paydate
  end

  def seconds_until do
    next_real_paydate |> Timex.diff(Date.today, :seconds)
  end

  def next_real_paydate do
    Date.today |> next_canonical_paydate |> fix_workday
  end


  def fix_workday(%Timex.Date{day: day} = canonical) do
    %{canonical | day: Timex.weekday(canonical) |> weekday(day) }
  end

  def next_canonical_paydate(%Timex.Date{year: year, month: month, day: day} = payday)  do
    canonical_payday = if day > 15, do: :calendar.last_day_of_the_month(year, month), else: 15
    %{payday | day: canonical_payday}
  end

  def weekday(weekday_number, day), do: (day + (%{6 => -1, 7 => -2}[weekday_number])) || 0
end
