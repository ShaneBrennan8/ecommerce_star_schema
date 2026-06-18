-- Create the raw landing dataset if it doesn't exist
CREATE SCHEMA IF NOT EXISTS `evocative-depot-427007-m8.online_ecommerce_star_schema`;


CREATE OR REPLACE EXTERNAL TABLE `evocative-depot-427007-m8.online_ecommerce_star_schema.raw_customers`
OPTIONS (
  format = 'CSV',
  uris = ['gs://evocative-depot-ecommerce-raw/online_ecommerce_star_schema/customers.csv'],
  skip_leading_rows = 1,
  null_marker = ''
);


CREATE OR REPLACE EXTERNAL TABLE `evocative-depot-427007-m8.online_ecommerce_star_schema.raw_events`
OPTIONS (
  format = 'CSV',
  uris = ['gs://evocative-depot-ecommerce-raw/online_ecommerce_star_schema/events.csv'],
  skip_leading_rows = 1,
  null_marker = ''
);


CREATE OR REPLACE EXTERNAL TABLE `evocative-depot-427007-m8.online_ecommerce_star_schema.raw_order_items`
OPTIONS (
  format = 'CSV',
  uris = ['gs://evocative-depot-ecommerce-raw/online_ecommerce_star_schema/order_items.csv'],
  skip_leading_rows = 1,
  null_marker = ''
);


CREATE OR REPLACE EXTERNAL TABLE `evocative-depot-427007-m8.online_ecommerce_star_schema.raw_orders`
OPTIONS (
  format = 'CSV',
  uris = ['gs://evocative-depot-ecommerce-raw/online_ecommerce_star_schema/orders.csv'],
  skip_leading_rows = 1,
  null_marker = ''
);


CREATE OR REPLACE EXTERNAL TABLE `evocative-depot-427007-m8.online_ecommerce_star_schema.raw_products`
OPTIONS (
  format = 'CSV',
  uris = ['gs://evocative-depot-ecommerce-raw/online_ecommerce_star_schema/products.csv'],
  skip_leading_rows = 1,
  null_marker = ''
);

CREATE OR REPLACE EXTERNAL TABLE `evocative-depot-427007-m8.online_ecommerce_star_schema.raw_reviews`
OPTIONS (
  format = 'CSV',
  uris = ['gs://evocative-depot-ecommerce-raw/online_ecommerce_star_schema/reviews.csv'],
  skip_leading_rows = 1,
  null_marker = ''
);


CREATE OR REPLACE EXTERNAL TABLE `evocative-depot-427007-m8.online_ecommerce_star_schema.raw_sessions`
OPTIONS (
  format = 'CSV',
  uris = ['gs://evocative-depot-ecommerce-raw/online_ecommerce_star_schema/sessions.csv'],
  skip_leading_rows = 1,
  null_marker = ''
);