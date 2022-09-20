ALTER TABLE products
ADD CONSTRAINT `fk__products_id__categories_id`
FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`);