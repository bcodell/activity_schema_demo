import pandas as pd
import os
import datetime
import random

if __name__=="__main__":
    seed_path = os.path.abspath(os.path.join("..", "seeds"))
    cur_path = os.getcwd()

    customers = pd.read_csv(os.path.join(cur_path, "raw_customers.csv"))
    orders = pd.read_csv(os.path.join(cur_path, "raw_orders.csv"))
    payments = pd.read_csv(os.path.join(cur_path, "raw_payments.csv"))

    orders["order_date"] = pd.to_datetime(orders["order_date"])


    random.seed(234)
    # define customer created_at timestamp as some point in time before first order
    customers["created_at"] = customers["id"].apply(
        lambda x: orders.loc[orders["user_id"]==x]["order_date"].min() - datetime.timedelta(hours=random.randint(1,36)*random.random())
    )


    # fill nulls for customers with no orders placed
    first_created = customers.created_at.min()
    last_created = customers.created_at.max()
    created_diff = (last_created - first_created).total_seconds()
    customers["created_at"].fillna(
        first_created + datetime.timedelta(seconds=random.randint(1, int(created_diff)) + random.random()),
        inplace=True
    )

    # add transaction timestamps for payments
    payments["created_at"] = payments["order_id"].apply(
        lambda x: orders.loc[orders["id"]==x]["order_date"].min() + datetime.timedelta(days=random.randint(0,60)+random.random())
    )



    customers.to_csv(os.path.join(seed_path, "raw_customers.csv"), index=False)
    orders.to_csv(os.path.join(seed_path, "raw_orders.csv"), index=False)
    payments.to_csv(os.path.join(seed_path, "raw_payments.csv"), index=False)


