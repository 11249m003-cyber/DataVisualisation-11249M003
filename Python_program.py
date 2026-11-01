import pandas as pd
import matplotlib.pyplot as plt

# Student data
data = {
    "Student": ["Ara", "Rahul", "Naman", "Maha", "Arsh", "Mala", "Geeta"],
    "Math": [51, 31, 42, 45, 65, 78, 65],
    "Science": [45, 67, 87, 67, 89, 77, 54],
    "English": [78, 56, 78, 34, 68, 89, 98],
    "Hour_studies": [3, 4, 3, 5, 2, 5, 3]
    
}

# Create DataFrame
df = pd.DataFrame(data)

# Display DataFrame
print("Student Marks Data")
print(df)

# ---------------- Line Chart ----------------
plt.figure(figsize=(10, 5))

plt.plot(df["Student"], df["Math"], marker="o", color="blue", label="Math")
plt.plot(df["Student"], df["Science"], marker="s", color="green", label="Science")
plt.plot(df["Student"], df["English"], marker="^", color="red", label="English")

plt.title("Students Score Trends")
plt.xlabel("Students")
plt.ylabel("Marks")
plt.xticks(rotation=45)
plt.legend()
plt.grid(True)
plt.tight_layout()

plt.savefig("line_chart.png")
plt.show()

# ---- Bar Chart Average Score per subject--------------
subjects = ["Math", "Science", "English"]
average_marks = [
    df["Math"].mean(),
    df["Science"].mean(),
    df["English"].mean()
]

plt.figure(figsize=(7, 5))

bars = plt.bar(
    subjects,
    average_marks,
    color=["blue", "green", "red"],
    edgecolor="black"
)

# Display average values on bars
for bar in bars:
    height = bar.get_height()
    plt.text(
        bar.get_x() + bar.get_width() / 2,
        height + 1,
        f"{height:.1f}",
        ha="center"
    )

plt.title("Average Marks by Subject")
plt.xlabel("Subjects")
plt.ylabel("Average Marks")
plt.ylim(0, 100)
plt.tight_layout()

plt.savefig("bar_chart.png")
plt.show()

#-----Histogram Distribution of Math Score------------------


plt.figure(figsize=(7, 5))
plt.hist(df["Math"], bins=5, color="#9b59b6", edgecolor="black", alpha=0.8)

plt.title("Distribution of Math Scores")
plt.xlabel("Score Range")
plt.ylabel("Number of Students")

plt.axvline(df["Math"].mean(),
            color="red",
            linestyle="--",
            label=f'Mean: {df["Math"].mean():.1f}')

plt.legend()
plt.tight_layout()
plt.savefig("histogram.png", dpi=150)
plt.show()


# Scatter Plot - Hours Studied vs Math Score-----------------
plt.figure(figsize=(8, 5))

plt.scatter(
    df["Hour_studies"],
    df["Math"],
    c=df["Math"],
    cmap="viridis",
    s=100,
    edgecolors="black"
)

for i, name in enumerate(df["Student"]):
    plt.annotate(
        name,
        (df["Hour_studies"][i], df["Math"][i]),
        textcoords="offset points",
        xytext=(5, 5),
        fontsize=8
    )

plt.colorbar(label="Math Score")
plt.title("Hours Studied vs Math Score")
plt.xlabel("Hours Studied per Day")
plt.ylabel("Math Score")

plt.tight_layout()
plt.savefig("scatter.png", dpi=150)
plt.show()



# Seaborn- heatmap of Correlation--------------


import seaborn as sns

numeric_df = df[["Math", "Science", "English", "Hour_studies"]]

corr = numeric_df.corr()

plt.figure(figsize=(7, 5))

sns.heatmap(
    corr,
    annot=True,
    fmt=".2f",
    cmap="coolwarm",
    linewidths=0.5,
    vmin=-1,
    vmax=1
)
 
plt.title("Correlation Heatmap")
plt.tight_layout()
plt.savefig("Heatmap.png", dpi=150)
plt.show()

# Seaborn - Box Plot-----------------

melted = df.melt(
    id_vars="Student",
    value_vars=["Math", "Science", "English"],
    var_name="Subject",
    value_name="Score"
)

plt.figure(figsize=(8, 5))

sns.boxplot(
    x="Subject",
    y="Score",
    data=melted,
    palette=["#3498db", "#2ecc71", "#e743c3"]
)

plt.title("Score Distribution by Subject (Box Plot)")
plt.tight_layout()
plt.savefig("boxplot.png", dpi=150)
plt.show()

