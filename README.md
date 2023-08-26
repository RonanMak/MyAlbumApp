# MyAlbum App

## Description

MyAlbum allows users to seamlessly search for their favorite songs, albums, or artists and provide a rich and user-friendly experience.

## API Overview

The Search API is used in this app for querying content across various Apple Stores. Note that promotional content from the API is primarily for store content promotion. Usage terms and conditions apply.


## Features

- Dynamic Search: Quickly find songs, albums, or artists using the search function.

- Intuitive Display: Search results show song name, artist, and album art in a list.

- Paging Support: Load more records in batches of 20 through paging.

- Filter Options: Refine search results by country or media type.

- Bookmarking: Add favorite songs to a "favorites" list for easy access later.

- Multilingual: Available in English and Traditional Chinese (Hong Kong)


## Getting Started

### Compatibility

- Please note that this application is compatible only with iOS 16 and newer versions. Ensure your device's operating system is up-to-date before using the application.

### Prerequisites

* Realm v10.42.0
* Kingfisher v7.9.0
* SwiftUI
* Combine


### Installation

In this project, dependency management is handled through the use of local frameworks instead of traditional dependency managers like Carthage or CocoaPods. This approach was chosen to simplify the setup process, allowing for immediate use of the project upon download.

To get started, follow these steps:

- Download the project directly from the GitHub repository.

- Once downloaded, the project is ready to use without any additional setup.


### Development Experience and Challenges

During the development process, a number of challenges were encountered:

Swift and Combine vs SwiftUI and Combine: 

- Despite the ease of development with Swift, I opted to use SwiftUI and Combine to leverage the latest platform-specific tools and frameworks. However, for those considering support for iOS 13, I recommend using Swift and Combine instead of SwiftUI for better stability, performance, and maintenance.

SwiftUI Limitations: 

- While SwiftUI offers many variables and features for binding, state changing, and functional programming, it still has some limitations and issues, particularly for iOS 13+. Challenges were encountered with navigation, keyboard handling, and other SwiftUI-specific problems.

Choice of Database: 

- I decided to use the local database Realm instead of an online database for quicker development and offline usage. However, this choice may pose a risk for database migration issues in the future.

Localization Approach: 

- Instead of using an API to fetch translated text and titles, I implemented dynamic localization in SwiftUI for speedier development. However, using an API would likely be a better approach for future projects. This would allow changes to be made to the translated text through API calls without needing to deploy updates to the app store.
