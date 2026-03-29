-- Project A: Pinduoduo-like E-commerce Platform Database Schema

-- 1. Users table (Supports Buyers, Sellers, Admins)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) DEFAULT 'BUYER', -- BUYER, SELLER, ADMIN
    preferred_language VARCHAR(10) DEFAULT 'en',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Categories table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    parent_id INTEGER REFERENCES categories(id),
    name_key VARCHAR(100) NOT NULL -- Points to multilingual translation
);

-- 3. Products table (The heart of the system)
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    seller_id UUID REFERENCES users(id),
    category_id INTEGER REFERENCES categories(id),
    type VARCHAR(20) NOT NULL, -- 'C2C', 'B2C', 'SELF_OPERATED'
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INTEGER DEFAULT 0,
    base_image_url TEXT,
    brand_name VARCHAR(100), -- Used for B2C
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Product Translations (Multilingual Support)
CREATE TABLE product_translations (
    id SERIAL PRIMARY KEY,
    product_id UUID REFERENCES products(id),
    language_code VARCHAR(10) NOT NULL, -- 'en', 'zh', 'es', etc.
    name VARCHAR(255) NOT NULL,
    description TEXT,
    UNIQUE(product_id, language_code)
);

-- 5. Orders table
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    buyer_id UUID REFERENCES users(id),
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING', -- PENDING, PAID, SHIPPED, DELIVERED, CANCELLED
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 6. Order Items
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id UUID REFERENCES orders(id),
    product_id UUID REFERENCES products(id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

-- 7. Logistics tracking
CREATE TABLE logistics (
    id SERIAL PRIMARY KEY,
    order_id UUID REFERENCES orders(id),
    tracking_number VARCHAR(100) UNIQUE,
    carrier VARCHAR(50), -- e.g., 'FedEx', 'DHL', 'UPS'
    status VARCHAR(50) DEFAULT 'PREPARING',
    last_update TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    tracking_history JSONB -- Stores raw tracking events
);

-- 8. Payments
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders(id),
    amount DECIMAL(10, 2) NOT NULL,
    method VARCHAR(50), -- 'STRIPE', 'PAYPAL', 'ALIPAY', 'WECHAT'
    transaction_id VARCHAR(255),
    status VARCHAR(20) DEFAULT 'PENDING', -- PENDING, COMPLETED, FAILED
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 9. General Multilingual Key-Value (For UI elements)
CREATE TABLE translations (
    key VARCHAR(255) PRIMARY KEY,
    en TEXT,
    zh TEXT,
    es TEXT,
    fr TEXT,
    ru TEXT
    -- Scalable for more languages
);
