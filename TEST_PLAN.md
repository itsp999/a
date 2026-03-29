# Test Cases for Project A

## 1. Authentication & Security
- **TC01**: User registration with valid data (Expected: 201 Created).
- **TC02**: Login with valid credentials (Expected: 200 OK + JWT).
- **TC03**: Access protected route without JWT (Expected: 401 Unauthorized).

## 2. Product Management (Three-tier logic)
- **TC04**: Create a C2C product (Expected: Type=C2C).
- **TC05**: Create a B2C product with brand name (Expected: Black "Brand" badge shown on UI).
- **TC06**: Create a Self-operated product (Expected: Golden "Self-operated" badge shown on UI).

## 3. Internationalization (I18n)
- **TC07**: Request product list with `Accept-Language: zh` (Expected: Names/Descriptions in Chinese).
- **TC08**: Switch UI language in Flutter app (Expected: All labels change immediately).

## 4. Payment & Order Workflow
- **TC09**: Create order with Stripe (Expected: Stripe Intent secret returned).
- **TC10**: Verify PayPal webhook (Expected: Order status updated to PAID).

## 5. Logistics Tracking
- **TC11**: Fetch tracking info for valid number (Expected: Correct events from LogisticsService).
- **TC12**: Invalid tracking number handling (Expected: Clear error message).

## 6. Performance & Scale
- **TC13**: Simulated load with 100 concurrent requests (Expected: Latency < 200ms).
- **TC14**: Large volume product list search (Expected: Pagination working correctly).
