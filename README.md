<div align="center">

# 🦋 Morphos

### An iOS companion for transgender people throughout their transition journey.

**Developed during the Apple Developer Academy @ UFPE**

![Swift](https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-007AFF?style=for-the-badge&logo=swift&logoColor=white)
![SwiftData](https://img.shields.io/badge/SwiftData-555555?style=for-the-badge&logo=apple&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)

<br>

<a href="https://apps.apple.com/fr/app/morphos/id6737781921">
  <img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83"
       alt="Download on the App Store"
       height="55">
</a>

<br>

*Currently available in Brazilian Portuguese, with support-service listings focused on Recife, Brazil.*

</div>

---


## About

**Transformadas** is an iOS application designed to support transgender people throughout their gender transition. It brings personal reflections, progress tracking, and information about support services into one place.

Created by a multidisciplinary team at the **Apple Developer Academy @ UFPE**, the project combines native iOS development, data visualization, and user-centered design.

## Features

### 📊 Journey dashboard
- Visualize changes in mood, weight, and recorded effects through interactive charts.
- Track the number of days since the beginning of a transition.
- Browse personal photos, audio recordings, and documents.

### 📔 Personal diary
- Create and manage dated journal entries with notes, moods, photos, audio, and other records.
- Navigate entries using date-based views.
- Create and manage reminders.

### 📍 Support service discovery
- Discover services relevant to the transgender community.
- Explore locations through an interactive map.
- Filter services by category and search by name.
- View service descriptions, addresses, and contact information.

### 🔐 Personalization
- Set up a personal profile with **Sign in with Apple**.
- Keep personal records using local persistence with **SwiftData**.


## 🔄 Product Development Process

Transformadas was developed using **Challenge-Based Learning (CBL)**, combined with **Agile methodologies**, as part of the Apple Developer Academy.

Our development process followed an iterative, user-centered approach, connecting real-world challenges with technical solutions.

### 🔍 User Research & Discovery
- Conducted research to better understand the target audience, their needs, and the challenges faced throughout gender transition.
- Interviewed potential users to gather insights and inform product decisions.
- Used research findings to guide feature prioritization and the overall user experience.

### 🎨 Ideation & Prototyping
- Collaborated across development and UX/UI design to transform research insights into product concepts.
- Developed and iterated on Minimum Viable Products (MVPs) to explore and refine the proposed solution.
- Refined the application's features and user flows throughout the design and development process.

### 🚀 Agile Development & CBL
- Applied Challenge-Based Learning to investigate a real-world problem and develop a meaningful technological solution.
- Used Agile practices to organize development tasks, adapt to feedback, and continuously improve the product.
- Worked in a multidisciplinary team of three iOS developers and two UX/UI designers, encouraging collaboration across all stages of development.

This process allowed us to approach software development not only as a technical challenge, but also as a way to create a product grounded in user needs.


## Tech stack

| Technology | Purpose |
|---|---|
| **Swift / SwiftUI** | Native iOS development and declarative interfaces |
| **SwiftData** | Local persistence and queries for personal records |
| **Swift Charts** | Interactive progress visualizations |
| **CloudKit** | Shared service-directory records |
| **MapKit** | Map-based discovery and user location |
| **AVFoundation** | Audio recording and playback |
| **UserNotifications** | Reminders and local notifications |
| **AuthenticationServices** | Sign in with Apple |

## Technical overview

The project separates feature screens, data models, and shared utilities. Personal data such as entries and reminders is managed through SwiftData; the services directory is retrieved from CloudKit and presented through list and map interfaces.

```text
Transformadas/Transformadas/
├── Models/          # Data models and data-access logic
├── Views/
│   ├── Diary/       # Journal entries and reminders
│   ├── Journey/     # Progress dashboard and media
│   ├── Services/    # Service discovery, filters, and map
│   └── Onboarding/  # Introduction and account setup
├── Util/            # Shared helpers, audio, notifications, pickers
├── StyleGuide/      # Visual styles and typography
└── Assets.xcassets/ # Images, icons, and colors
```


## 📲 Download the App

Transformadas is available on the **Apple App Store**.

**[Download Transformadas on the App Store](APP_STORE_URL)**

> **Availability note:** The application is currently available
> in Brazilian Portuguese. Its service discovery features
> focus on Recife, Pernambuco, Brazil.

## 💻 Running the Project Locally

### Requirements
- macOS with Xcode installed
- iOS Simulator or a compatible physical iPhone
- Appropriate Apple Developer capabilities for supported integrations

### Setup

1. Clone the repository:

```bash
git clone https://github.com/arthurmarsar0/Transformadas.git
```

2. Open `Transformadas/Transformadas.xcodeproj` in Xcode.
3. Configure the development team and required capabilities.
4. Resolve Swift Package Manager dependencies.
5. Build and run the application.

**Note:** CloudKit and Sign in with Apple may require additional configuration to work outside the original development environment.


## Team

Built collaboratively by a multidisciplinary Apple Developer Academy team:

| Team member | Role |
|---|---|
| [Arthur Alves Marsaro](https://github.com/arthurmarsar0) | iOS Development |
| [Alice](https://github.com/alicebarbosam) | iOS Development |
| [Pedro](https://github.com/PedroMonte) | iOS Development |
| Rodrigo | UX/UI Design |
| Nati | UX/UI Design |

Development and UX/UI design were coordinated throughout the product process, from shaping the user experience to implementing the application.

## Project context

- **Program:** Apple Developer Academy @ UFPE
- **Challenge:** 4th Challenge — Terra Firme
- **Location:** Recife, Brazil
- **Year:** 2024

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

<div align="center">

*Built with care, empathy, and technology.* 🦋

</div>
