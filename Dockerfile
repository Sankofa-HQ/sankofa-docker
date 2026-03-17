# --- Stage 1: Build Dashboard ---
FROM node:20-alpine AS dashboard-builder
WORKDIR /app/dashboard
COPY dashboard/package*.json ./
RUN npm install --legacy-peer-deps
COPY dashboard/ .
ENV NEXT_PUBLIC_API_URL="http://localhost:8080"
RUN npm run build

# --- Stage 2: Build Engine ---
FROM golang:1.24-alpine AS engine-builder
WORKDIR /app
COPY server/ ./server/
WORKDIR /app/server/engine
RUN go mod download
RUN go build -o /app/sankofa ./cmd/sankofa

# --- Stage 3: Final Runtime ---
FROM node:20-alpine
WORKDIR /app

# Install dependencies for healthchecks or debugging
RUN apk add --no-cache ca-certificates

# Copy engine binary
COPY --from=engine-builder /app/sankofa .

# Copy Next.js standalone build
# Next.js standalone output includes:
# .next/standalone -> containing essential files
# .next/static -> needs to be copied to standalone/.next/static
# public -> needs to be copied to standalone/public
COPY --from=dashboard-builder /app/dashboard/.next/standalone ./dashboard
COPY --from=dashboard-builder /app/dashboard/.next/static ./dashboard/.next/static
COPY --from=dashboard-builder /app/dashboard/public ./dashboard/public

# Copy default env
COPY server/engine/.env.example .env

# Copy and prepare startup script
COPY start.sh .
RUN chmod +x start.sh

# Create uploads directory
RUN mkdir -p uploads

# Expose API and Dashboard ports
EXPOSE 8080 3000

# Run both processes
CMD ["./start.sh"]
