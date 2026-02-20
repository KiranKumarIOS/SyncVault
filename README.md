# SyncVault

Offline-First iOS Application built using MVVM Architecture.

## 🚀 Features

- Fetch posts from API
- Offline support using Core Data
- Automatic fallback when network fails
- Clean MVVM architecture
- Repository pattern implementation

## 🛠 Tech Stack

- Swift
- UIKit
- Core Data
- URLSession
- MVVM Architecture

## 📱 Architecture

SyncVault follows:

View → ViewModel → Repository → CoreDataManager / NetworkManager

## 🌐 API Used

https://jsonplaceholder.typicode.com/posts

## 📌 Offline Strategy

- Try fetching from API
- If API fails → Load from Core Data
- Cached data persists locally

---

Developed by Kiran Kumar Reddy
