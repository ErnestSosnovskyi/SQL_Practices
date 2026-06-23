import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Завантажуємо раніше підготовлені аналітичні дані
try:
    df = pd.read_csv('data/processed/sales_data.csv')
    df["OrderDate"] = pd.to_datetime(df["OrderDate"])
except FileNotFoundError:
    print("❌ Спочатку запустіть скрипт analytics_base.py для створення sales_data.csv")
    exit()

# Налаштування стилю графіків
plt.style.use('seaborn-v0_8-whitegrid' if 'seaborn-v0_8-whitegrid' in plt.style.available else 'default')

# --- Задача 3 & 4. Динаміка продажів за датами ---
sales_by_date = df.groupby("OrderDate")["Revenue"].sum().reset_index().sort_values("OrderDate")

plt.figure(figsize=(9, 5))
plt.plot(sales_by_date["OrderDate"], sales_by_date["Revenue"], marker="o", color="teal", linewidth=2)
plt.title("Динаміка продажів за датами", fontsize=14, fontweight='bold')
plt.xlabel("Дата замовлення")
plt.ylabel("Виручка (CHF)")
plt.grid(True, linestyle="--", alpha=0.6)
plt.tight_layout()
plt.savefig('figs/revenue_dynamics.png', dpi=200)
print("📸 Графік збережено: figs/revenue_dynamics.png")
plt.close()

# --- Задача 6. Топ-жанри за виручкою ---
genre_revenue = df.groupby("Genre")["Revenue"].sum().sort_values(ascending=False).reset_index()
genre_revenue.to_csv("data/processed/genre_revenue.csv", index=False)

plt.figure(figsize=(9, 5))
plt.barh(genre_revenue["Genre"], genre_revenue["Revenue"], color="cornflowerblue")
plt.title("Топ-жанри за виручкою", fontsize=14, fontweight='bold')
plt.xlabel("Виручка (CHF)")
plt.ylabel("Жанр")
plt.gca().invert_yaxis()  # Найбільші жанри зверху
plt.grid(axis='x', linestyle="--", alpha=0.6)
plt.tight_layout()
plt.savefig('figs/top_genres.png', dpi=200)
print("📸 Графік збережено: figs/top_genres.png")
plt.close()

# --- Задача 7. Аналіз топ-книг (Pareto 80/20) ---
book_revenue = df.groupby("Title")["Revenue"].sum().sort_values(ascending=False).reset_index()
book_revenue["CumulativePercent"] = 100 * book_revenue["Revenue"].cumsum() / book_revenue["Revenue"].sum()
book_revenue.to_csv("data/processed/book_pareto.csv", index=False)

fig, ax1 = plt.subplots(figsize=(9, 5))
ax1.bar(book_revenue["Title"], book_revenue["Revenue"], color="skyblue")
ax1.set_xlabel("Назва книги")
ax1.set_ylabel("Виручка (CHF)", color="navy")
ax1.tick_params(axis='x', rotation=30, labelsize=9)

ax2 = ax1.twinx()
ax2.plot(book_revenue["Title"], book_revenue["CumulativePercent"], color="orange", marker="o", linewidth=2)
ax2.set_ylabel("Накопичувальний відсоток (%)", color="darkorange")
ax2.axhline(80, color="red", linestyle="--", linewidth=1.5, label="Межа 80%")

plt.title("Аналіз топ-книг (Pareto 80/20)", fontsize=14, fontweight='bold')
ax1.grid(axis='y', linestyle="--", alpha=0.6)
plt.tight_layout()
plt.savefig('figs/book_pareto.png', dpi=200)
print("📸 Графік збережено: figs/book_pareto.png")
plt.close()

# --- Задача 8. Heatmap «Жанр × Рік видання» ---
pivot = df.groupby(["Genre", "PublishYear"])["Revenue"].sum().unstack(fill_value=0)
pivot.to_csv("data/processed/genre_year_heatmap.csv")

plt.figure(figsize=(9, 5))
sns.heatmap(pivot, annot=True, fmt=".0f", cmap="YlGnBu", cbar_kws={'label': 'Виручка (CHF)'})
plt.title("Теплова карта: Жанр × Рік видання (Виручка)", fontsize=14, fontweight='bold')
plt.xlabel("Рік видання книги")
plt.ylabel("Жанр")
plt.tight_layout()
plt.savefig('figs/genre_year_heatmap.png', dpi=200)
print("📸 Графік збережено: figs/genre_year_heatmap.png")
plt.close()