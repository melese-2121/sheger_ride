# 🚍 Sheger Ride

**Your smart city transportation companion!** Track buses, trains, and taxis in real-time, plan optimal routes, and never miss a ride again. Built with Flutter, Sheger Ride makes city commuting fast, reliable, and intelligent.  

---

## 🎯 Goal

Sheger Ride empowers urban commuters to:  

- Track buses, trains, and taxis live on a map.  
- Plan routes efficiently (shortest or cheapest).  
- Receive timely notifications for arrivals or delays.  

---

## 📱 Core Features

### 1️⃣ Real-time Tracking
- View buses, trains, and taxis live on an interactive map.  
- Drivers share GPS coordinates every few seconds → map updates instantly.  
- Different icons for different vehicle types for easy recognition.  

### 2️⃣ Route Planning
- Enter start and destination points.  
- Get route suggestions: shortest route (time-based) or cheapest route (fare-based).  
- Powered by Google Directions API for accurate pathing and ETA.  

### 3️⃣ Push Notifications
- Alerts when your ride is about to arrive.  
- Notifications for delays reported by drivers.  
- Built using Firebase Cloud Messaging (FCM).  

### 4️⃣ Extra Features (Coming Soon)
- QR-based ticket booking & payments (Stripe, Telebirr, Chapa).  
- Bus schedules & operating hours.  
- Save favorite routes (Home ↔ Work).  
- Multi-language support (English, Amharic, Afaan Oromo).  

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Frontend | Flutter (iOS & Android) |
| Backend | Node.js / Golang + Firebase / Supabase |
| Database | Firestore / PostgreSQL |
| Maps | Google Maps SDK / Mapbox SDK |
| Notifications | Firebase Cloud Messaging (FCM) |
| Real-time Location | WebSockets / Firebase Realtime DB |

---

## 🗂️ Data Flow

**Driver App (mini-version)**  
1. Logs in → shares GPS every 3–5 seconds.  
2. Sends updates to backend (Realtime DB / WebSocket).  

**User App (main version)**  
1. Opens app → sees nearby vehicles in real-time.  
2. Requests route → backend calculates best options.  
3. Subscribes to notifications (arrivals/delays).  

---

## ⏳ Development Phases

| Phase | Tasks | Duration |
|-------|-------|---------|
| 1 | Flutter & Firebase setup, project initialization, Google Maps API keys | 2–3 hrs |
| 2 | Basic map & user location, dummy vehicle markers | 1–2 days |
| 3 | Real-time vehicle tracking, Driver app location sharing | 2–3 days |
| 4 | Route planning with Google Directions API | 2–4 days |
| 5 | Push notifications for arrivals/delays | 2–3 days |
| 6 | Polishing & add-ons: payments, saved routes, dark mode, UI/UX | Ongoing |

---

## 📊 Example User Flow

1. Open Sheger Ride → see nearby buses/trains live.  
2. Enter destination → view optimal routes.  
3. Select route → track vehicle in real-time.  
4. Receive push notification:  
   > “🚍 Your bus will arrive in 5 mins”  

---

## ⚡ Getting Started

### Prerequisites
- Flutter SDK installed ([Flutter Setup Guide](https://docs.flutter.dev/get-started/install))  
- Firebase account  
- Google Maps API Key  

### Installation
```bash
# Clone the repository
git clone https://github.com/yourusername/sheger_ride.git

# Navigate to the project folder
cd sheger_ride

# Install dependencies
flutter pub get

# Run the app
flutter run
