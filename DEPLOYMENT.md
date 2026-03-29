# Deployment Guide for Project A

## 1. Prerequisites
- GitHub Account
- Vercel Account (for Frontend Web)
- Supabase Account (for PostgreSQL & Auth)
- Stripe / PayPal Developer Accounts (for Payments)

## 2. Backend Deployment (Supabase/Render)
- Create a new project in Supabase to get the PostgreSQL connection string.
- (Optional) Use Render.com's "Web Service" free tier to host the NestJS backend.
- Set the following environment variables in your hosting provider:
  ```
  DB_HOST=your-supabase-db-host
  DB_PORT=5432
  DB_USER=postgres
  DB_PASSWORD=your-password
  DB_NAME=postgres
  JWT_SECRET=your-secure-secret
  STRIPE_SECRET=sk_test_...
  PAYPAL_CLIENT_ID=...
  ```

## 3. Frontend Deployment (Vercel)
- Connect your GitHub repository to Vercel.
- Vercel will auto-detect the Flutter Web project.
- Set the `API_BASE_URL` to point to your backend.
- Build command: `flutter build web --release`
- Output directory: `build/web`

## 4. Android/iOS Deployment
- Use Codemagic or GitHub Actions for CI/CD.
- For Android: Generate a signed AAB/APK and upload to Google Play Console.
- For iOS: Use Xcode to archive and upload to App Store Connect (requires Apple Developer Program).
