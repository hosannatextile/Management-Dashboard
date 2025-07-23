# Use the official Flutter image with web support
FROM cirrusci/flutter:stable-web

# Set working directory
WORKDIR /app

# Copy pubspec files and get dependencies

RUN flutter pub get

# Copy rest of the app
COPY . .

# Build Flutter web
RUN flutter build web --release

# Use a lightweight web server to serve the app (e.g., nginx or shelf_static)
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html



# Start nginx
CMD ["nginx", "-g", "daemon off;"]
