# Project A: Pinduoduo-like E-commerce Architecture

## 1. System Overview
The system is a multi-terminal (Android, iOS, Web) e-commerce platform supporting C2C, B2C (Brand), and Platform Self-operated models. It supports global languages and mainstream cross-border payments.

## 2. Tech Stack
- **Frontend**: Flutter (Mobile + Web)
- **Backend**: Node.js (NestJS)
- **Database**: PostgreSQL (Relational data), Redis (Cache/Session)
- **Logistics Integration**: 17track / AfterShip API
- **Payment Integration**: Stripe, PayPal, Alipay, WeChat Pay
- **Hosting**: 
  - Web: Vercel (Free tier)
  - Backend/DB: Supabase / Render (Free tier)

## 3. Core Modules
- **Auth Module**: JWT-based authentication, Role-based Access Control (RBAC).
- **Product Module**: Handles multilingual content, inventory, and business model categorization (C2C/B2C/Self-op).
- **Order Module**: Transaction management, payment processing, and logistics linking.
- **Logistics Service**: Interface with external tracking platforms.
- **I18n Service**: Real-time language switching for all UI and data.

## 4. Multi-language Strategy
- **Static UI**: Flutter `intl` package + local JSON/ARB files.
- **Dynamic Content**: Database-driven translation table (`product_translations`).
- **Real-time API**: Language specified via `Accept-Language` header.

## 5. Model Logic
- **C2C**: Individual sellers list items; low verification barrier.
- **B2C (Brand)**: Verified companies with "Brand" (黑色品牌) badge.
- **Self-operated**: Platform's own inventory with "Self-operated" (金黄色自营) badge.
