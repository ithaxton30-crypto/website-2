library(tidyverse)

```{r}
#| message: false
billboard_long <- tidyr::billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE
  ) |>
  mutate(week = readr::parse_number(week)) |>
  group_by(track, artist) |>
  mutate(weeks_on_chart = n()) |>
  ungroup()

longest_running <- billboard_long |>
  distinct(track, artist, weeks_on_chart) |>
  slice_max(weeks_on_chart, n = 12, with_ties = FALSE)

billboard_long |>
  semi_join(longest_running, by = c("track", "artist", "weeks_on_chart")) |>
```
write_rds(top_songs, file = "clean_data.rds")
