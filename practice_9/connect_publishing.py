from sqlalchemy import create_engine
import os
import pandas as pd
import matplotlib.pyplot as plt
from dotenv import load_dotenv
import seaborn as sns  # для heatmap

# створюємо з’єднання з базою MySQL
# замініть user, password та port на власні параметри


from sqlalchemy import create_engine, text

load_dotenv()

db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_name = os.getenv("DB_NAME")

engine = create_engine(f"mysql+pymysql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}?charset=utf8mb4")


with engine.connect() as conn:
    res = conn.execute(text("SELECT NOW()"))
    print("OK:", res.scalar())  # або list(res)

books = pd.read_sql("SELECT * FROM Books", engine)
orders = pd.read_sql("SELECT * FROM Orders", engine)
orderitem = pd.read_sql("SELECT * FROM OrderItem", engine)


print("Книги:", books.shape)
print("Замовлення:", orders.shape)
print("Позиції замовлень:", orderitem.shape)

df = (orderitem
      .merge(orders, on='OrderID', how='left')
      .merge(books, on='BookID', how='left'))


df['Revenue'] = df['Quantity'] * df['UnitPrice']

print("\nПерші рядки аналітичної таблиці:")
print(df.head())


# === 5. Агрегація за жанром і роком видання ===
pivot = (df.groupby(["Genre", "PublishYear"])["Revenue"]
           .sum()
           .unstack(fill_value=0))


print("\nЗведена таблиця жанр × рік видання:")
print(pivot)


# === 6. Побудова теплової карти ===
plt.figure(figsize=(8,5))
sns.heatmap(pivot, annot=True, fmt=".0f", cmap="YlGnBu")
plt.title("Жанр × Рік видання (виручка)", fontsize=14)
plt.xlabel("Рік видання")
plt.ylabel("Жанр")
plt.tight_layout()
plt.show()


# === 7. Збереження Результату ===
pivot.to_csv("genre_year_heatmap.csv")
print("\nРезультати збережено у файл genre_year_heatmap.csv")