import pandas as pd

# Read the data from the tables
customers = pd.read_csv('customers.csv')
invoices = pd.read_csv('invoices.csv')
invoice_lines = pd.read_csv('invoice_lines.csv')

# b. Show the number of customers purchasing more than 5 books
num_customers = (
    invoice_lines
    .groupby('customer_id')
    .size()
    .reset_index(name='count')
    .query('count > 5')
    .shape[0]
)
print(f'Number of customers purchasing more than 5 books: {num_customers}')

# c. Show a list of customers who never purchased anything
customers_who_never_purchased = customers.merge(
    invoices, how='left', on='id').query('invoice_id IS NULL')
print('List of customers who never purchased anything:')
print(customers_who_never_purchased[['name']])

# d. Show a list of book purchased with the users
book_purchases = customers.merge(
    invoices, how='inner', on='id').merge(invoice_lines, how='inner', on='invoice_id')
print('List of book purchased with the users:')
print(book_purchases[['name', 'description']])
