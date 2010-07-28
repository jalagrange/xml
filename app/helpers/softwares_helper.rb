module SoftwaresHelper

  def jobs_chart_series(jobs)
    jobs_by_day = jobs.
                  group("day").
                  select("walltime, day, SUM(jobs.walltime as walltime)")
  end
end
