import os
import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

# 1. Підключення до бази даних MySQL

load_dotenv()

db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_name = os.getenv("DB_NAME")
 
engine = create_engine(f"mysql+pymysql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}?charset=utf8mb4")

try:
    with engine.connect() as conn:
        print("✅ Підключення до MySQL успішне! Дата сервера:", conn.execute(text("SELECT NOW()")).scalar())
except Exception as e:
    print(f"❌ Помилка підключення: {e}")
    exit()

# --- Задача 1. Імпорт таблиць у pandas ---
books = pd.read_sql("SELECT * FROM Books", engine)
orders = pd.read_sql("SELECT * FROM Orders", engine)
orderitem = pd.read_sql("SELECT * FROM OrderItem", engine)

print(f"\n📊 Розмірність завантажених таблиць:")
print(f"Книги: {books.shape}, Замовлення: {orders.shape}, Позиції замовлень: {orderitem.shape}")

# Збереження сирих даних (Raw Data)
books.to_csv("data/raw/books_raw.csv", index=False)
orders.to_csv("data/raw/orders_raw.csv", index=False)
orderitem.to_csv("data/raw/orderitem_raw.csv", index=False)

# --- Задача 2. Об'єднання таблиць (Трансформація) ---
df = orderitem.merge(orders, on='OrderID', how='left').merge(books, on='BookID', how='left')

# Очищення та розрахунок розрахункових колонок
df["Revenue"] = df["Quantity"] * df["UnitPrice"]
df["OrderDate"] = pd.to_datetime(df["OrderDate"])

print("\n📋 Перші 3 рядки об’єднаного аналітичного датасету:")
print(df.head(3))

# Збереження оброблених даних (Processed Data)
df.to_csv('data/processed/sales_data.csv', index=False, encoding='utf-8')
print("💾 Оброблений файл збережено: data/processed/sales_data.csv")

# --- Задача 5. Розрахунок ключових показників (KPI) ---
kpi = {
    "total_orders": int(df["OrderID"].nunique()),
    "total_units": int(df["Quantity"].sum()),
    "total_revenue": float(df["Revenue"].sum()),
    "avg_order_value": float(df.groupby("OrderID")["Revenue"].sum().mean())
}

kpi_series = pd.Series(kpi, name="Value")
kpi_series.to_csv("data/processed/kpi.csv")

print("\n📈 Ключові показники ефективності (KPI):")
print(kpi_series)