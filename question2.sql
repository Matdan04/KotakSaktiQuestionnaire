/* a. Show schema generation query */

CREATE TABLE customers (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NULL,
  tel INT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE TABLE invoices (
  id INT NOT NULL AUTO_INCREMENT,
  number VARCHAR(255) NOT NULL,
  sub_total DECIMAL(10,2) NOT NULL,
  tax_total DECIMAL(10,2) NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  customer_id INT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE invoice_lines (
  id INT NOT NULL AUTO_INCREMENT,
  description VARCHAR(255) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  quantity INT NOT NULL,
  sub_total DECIMAL(10,2) NOT NULL,
  sub_total DECIMAL(10,2) NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  tax_id INT NULL,
  sku_id INT NOT NULL,
  invoice_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (tax_id) REFERENCES taxes(id),
  FOREIGN KEY (sku_id) REFERENCES products(id),
  FOREIGN KEY (invoice_id) REFERENCES invoices(id)
);

/* b. Show the SQL query for number of customers purchasing more than 5 books:*/

SELECT COUNT(*) AS num_customers
FROM (
  SELECT customer_id
  FROM invoice_lines
  GROUP BY customer_id
  HAVING COUNT(*) > 5
) AS customer_ids;

/* c. Show the SQL query for a list of customers who never purchased anything:*/

SELECT *
FROM customers
LEFT JOIN invoices ON customers.id = invoices.customer_id
WHERE invoices.id IS NULL;

/*d. Show the SQL query for list of book purchased with the users:*/

SELECT customers.name, invoice_lines.description
FROM customers
INNER JOIN invoices ON customers.id = invoices.customer_id
INNER JOIN invoice_lines ON invoices.id = invoice_lines.invoice_id;





