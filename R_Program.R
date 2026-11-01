# Student Data ######
students <- data.frame(
  Student = c("Alice", "BOb", "Charlie", "Diana", "Eve", "Frank", "Grace", "Henry", "Jack"),
  Math = c(88, 73, 76, 87, 98, 79, 67, 93, 94),
  Science = c(97, 95, 90, 87, 85, 75, 63, 79, 76),
  English = c(87, 76, 56, 74, 97, 96, 56, 78, 98),
  Study_Hours = c(5.0, 4.0, 5.0, 2.0, 3.0, 4.0, 1.0, 2.0, 4.0)
)
head(students)


###BAR CHART #####

avgs <- colMeans(
  students[, c("Math", "Science", "English")]
)
print(avgs)
barplot(
  avgs,
  main = "Average Subject Scores",
  xlab = "Subject",
  ylab = "Average Score",
  col = c("#3498DB", "#2ECC71", "#E74C3C"),
  ylim = c(0, 100),
  border = "black"
)
abline(
  h = mean(avgs),
  col = "darkgray",
  lty = 2
)
legend(
  "topright",
  legend = paste("Overall Avg:", round(mean(avgs), 1)),
  lty = 2,
  col = "darkgray"
)


####LINE CHART######
long_df <- pivot_longer(
  students,
  cols = c(Math, Science, English),
  names_to = "Subject",
  values_to = "Score"
)
print(long_df)
ggplot(
  long_df,
  aes(
    x = Student,
    y = Score,
    color = Subject,
    group = Subject
  )
) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  theme_minimal() +
  labs(
    title = "Student Score Trends",
    x = "Student",
    y = "Marks",
    color = "Subject"
  ) +
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    )
  )


#####HISTOGRAM####

ggplot(
  students,
  aes(x = Math)
) +
  geom_histogram(
    binwidth = 8,
    fill = "#9B59B6",
    color = "black",
    alpha = 0.8
  ) +
  geom_vline(
    aes(xintercept = mean(Math)),
    color = "red",
    linetype = "dashed",
    linewidth = 1
  ) +
  labs(
    title = "Distribution of Math Scores",
    x = "Score",
    y = "Count"
  ) +
  theme_classic()

####BOX PLOT#####
ggplot(
  long_df,
  aes(
    x = Subject,
    y = Score,
    fill = Subject
  )
) +
  geom_boxplot(
    alpha = 0.7,
    outlier.color = "red"
  ) +
  geom_jitter(
    width = 0.2,
    alpha = 0.5
  ) +
  scale_fill_brewer(
    palette = "Set2"
  ) +
  labs(
    title = "Score Distribution by Subject",
    x = "Subject",
    y = "Score"
  ) +
  theme_light() +
  theme(
    legend.position = "none"
  )

#### PLOT WITH REGRESSION LINE ####
library(ggplot2)

p1 <- ggplot(
  students,
  aes(x = Study_Hours, y = Math, label = Student)
) +
  geom_point(aes(color = Math), size = 4) +
  geom_smooth(
    method = "lm",
    se = TRUE,
    color = "steelblue",
    linetype = "dashed"
  ) +
  geom_text(vjust = -1, size = 3) +
  scale_color_gradient(
    low = "orange",
    high = "darkblue"
  ) +
  labs(
    title = "Study Hours vs Math Score",
    x = "Study Hours",
    y = "Math Score"
  ) +
  theme_minimal()

print(p1)

#### GROUPED BAR CHART ####

library(ggplot2)
library(tidyr)

long_df <- pivot_longer(
  students,
  cols = c(Math, Science, English),
  names_to = "Subject",
  values_to = "Score"
)

ggplot(
  long_df,
  aes(x = Student, y = Score, fill = Subject)
) +
  geom_bar(
    stat = "identity",
    position = "dodge"
  ) +
  scale_fill_brewer(palette = "Set1") +
  labs(
    title = "Scores by Student and Subject",
    x = "Student",
    y = "Score"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    )
  )


# Count A-grades (85 or above) per subject

a_grades <- c(
  Math = sum(students$Math >= 85),
  Science = sum(students$Science >= 85),
  English = sum(students$English >= 85)
)

pie(
  a_grades,
  main = "A-Grade Distribution by Subject",
  col = c("#3498db", "#2ecc71", "#e74c3c"),
  labels = paste(
    names(a_grades),
    "\n",
    a_grades,
    "students"
  )
)
 
