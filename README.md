# The MyAlbum App

## Description

The MyAlbum app allows users to seamlessly search for their favorite songs, albums, or artists and provides a rich and user-friendly experience.

## API Overview

The Search API is employed within the app for querying content across various Apple Stores. Note that promotional content from the API is primarily for store content promotion. Usage terms and conditions apply.

## Features

- Dynamic Search: Enables quick finding of songs, albums, or artists using the search function.
- Intuitive Display: Presents search results showing song name, artist, and album art in a list.
- Paging Support: Loads more records in batches of 20 through paging.
- Filter Options: Refines search results by country or media type.
- Bookmarking: Adds favorite songs to a "favorites" list for easy access later.
- Multilingual: Available in English and Traditional Chinese (Hong Kong)

## Getting Started

### Compatibility

- It should be noted that the application is compatible only with iOS 16 and newer versions. Users should ensure their device's operating system is up-to-date before using the application.

### Prerequisites

- Realm v10.42.0
- Kingfisher v7.9.0
- SwiftUI
- Combine

### Installation

In this project, dependency management is handled by the use of local frameworks instead of traditional dependency managers like Carthage or CocoaPods. This approach was chosen to simplify the setup process, enabling immediate use of the project upon download.

To get started, the following steps should be taken:

- The project should be downloaded directly from the GitHub repository.
- Once downloaded, the project is ready to use without any additional setup.

### Development Experience and Challenges

During the process of the app's development, several challenges were faced:

Swift and Combine vs SwiftUI and Combine:

- Despite the ease of development with Swift, the choice was made to use SwiftUI and Combine to leverage the latest platform-specific tools and frameworks. However, for those considering support for iOS 13, it's recommended to use Swift and Combine instead of SwiftUI for better stability, performance, and maintenance.

SwiftUI Limitations:

- While SwiftUI offers many variables and features for binding, state changing, and functional programming, it still has some limitations and issues, particularly for iOS 13+. Challenges were faced with navigation, keyboard handling, and other SwiftUI-specific problems.

Choice of Database:

- The decision was made to use the local database Realm instead of an online database for quicker development and offline usage. However, this choice may pose a risk for database migration issues in the future.

Localization Approach:

- Instead of using an API to fetch translated text and titles, dynamic localization in SwiftUI was implemented for speedier development. However, using an API would likely be a better approach for future projects. This would allow changes to be made to the translated text through API calls without needing to deploy updates to the app store.