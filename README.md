### Installation and Setup

1. Install dependencies:
   bundle install

2. Create the .env.development.local and .env.test.local files.
   Add the DB_USERNAME, DB_PASSWORD variables.
   Add DB_HOST variable if different from localhost.
   Add DB_PORT variable if different from 5432.

3. Create the production and test databases with the following command:
   rails db:create

4. Generate the application schema:
   rails db:migrate

5. Start the server:
   bin/dev

### Testing

The app includes RSpec tests for the key components. To run the tests, execute the following command:

bundle exec rspec

### Endpoints

### 1. Add Item to Cart

Add a new item to the shopping cart. The system automatically calculates and applies the best available promotion.

**Endpoint:** `POST /api/v1/cart/add_item?cart_id=:cart_id`

**Parameters:**
- `cart_id`: ID of the cart to add the item. If the cart_id is not provided a new Cart object will be created.

**Request Body:**
```json
{
  "item_id": "integer",
  "quantity": "decimal"
}
```

**Response:** `200 OK`
```json
{
    "data": {
        "id": "integer",
        "type": "string",
        "attributes": {
            "total_price": "decimal",
            "total_savings": "decimal",
            "cart_items": {
                "data": [
                    {
                        "id": "integer",
                        "type": "string",
                        "attributes": {
                            "cart_id": "integer",
                            "item_id": "integer",
                            "created_at": "datetime",
                            "updated_at": "datetime",
                            "quantity": "decimal",
                            "discounted_price": "decimal",
                            "applied_promotion_id": "integer",
                            "original_price": "decimal"
                        }
                    }
                ]
            }
        }
    }
}
```

### 2. Remove Item from Cart

Remove an item from the shopping cart. The system recalculates the best promotions for remaining items.

**Endpoint:** `DELETE api/v1/cart/remove_item?cart_id=:cart_id`

**Parameters:**
- `cart_id`: ID of the cart to remove the item.

**Request Body:**
```json
{
  "item_id": "integer",
  "quantity": "decimal"
}
```

**Response:** `200 OK`
```json
{
    "data": {
        "id": "integer",
        "type": "string",
        "attributes": {
            "total_price": "decimal",
            "total_savings": "decimal",
            "cart_items": {
                "data": [
                    {
                        "id": "integer",
                        "type": "string",
                        "attributes": {
                            "cart_id": "integer",
                            "item_id": "integer",
                            "created_at": "datetime",
                            "updated_at": "datetime",
                            "quantity": "decimal",
                            "discounted_price": "decimal",
                            "applied_promotion_id": "integer",
                            "original_price": "decimal"
                        }
                    }
                ]
            }
        }
    }
}
```

### 3. View Cart

Retrieve the current cart with all items and applied promotions.

**Endpoint:** `GET api/v1/cart?cart_id=:cart_id`

**Parameters:**
- `cart_id`: ID of the cart to view.

**Response:** `200 OK`
```json
{
    "data": {
        "id": "integer",
        "type": "string",
        "attributes": {
            "total_price": "decimal",
            "total_savings": "decimal",
            "cart_items": {
                "data": [
                    {
                        "id": "integer",
                        "type": "string",
                        "attributes": {
                            "cart_id": "integer",
                            "item_id": "integer",
                            "created_at": "datetime",
                            "updated_at": "datetime",
                            "quantity": "decimal",
                            "discounted_price": "decimal",
                            "applied_promotion_id": "integer",
                            "original_price": "decimal"
                        }
                    }
                ]
            }
        }
    }
}
```
