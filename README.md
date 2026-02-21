# SyncVault

Offline-First iOS Application built using MVVM Architecture.

## 🚀 Features

- Fetch posts from API
- Offline support using Core Data
- Pull-to-refresh functionality
- Activity indicator while loading
- Local search by post title
- Empty state handling (No Results Found)
- Network error handling
- MVVM architecture

## 🔍 Search Behavior

- Filters posts locally
- Displays “No Results Found” when no matches
- Restores full list when search is cleared


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
