//
//  SearchScreenViewModel.swift
//  MyAlbum
//
//  Created by Ronan Mak on 20/8/2023.
//

import Foundation
import Combine
import SwiftUI

class SearchScreenViewModel: ObservableObject {

    let apiClient = URLSessionAPIClient<MyAlbumEndpoints.iTunesAPIEndPoint>()

    typealias EndPointRequest = MyAlbumEndpoints.iTunesAPIEndPoint

    @Published var searchResults = [SearchResult]()
    @Published var searchQuery = ""
    @Published var selectedOption: PickerOptions = .all
    @Published var isLoading = false
    @Published var offset: Int = 0
    @Published var isTyping = false

    var limit: Int = 20
    var page: Int = 0

    var isLoadMore = false
    var showLoadingIcon: Bool {
        !searchQuery.isEmpty && offset == searchResults.count
    }

    var showResultIndicator: Bool {
        !searchQuery.isEmpty && (searchResults.count % limit != 0 || searchResults.count == 0) && !isLoading && !isTyping
    }


    var cancelables = Set<AnyCancellable>()
    var searchCancelable: AnyCancellable? = nil
    var selectedOptionCancelable: AnyCancellable? = nil

    init() {
        searchQueryBinding()
        selectedOptionBinding()
    }
}

// MARK: - Binding

extension SearchScreenViewModel {

    func selectedOptionBinding() {
        selectedOptionCancelable = $selectedOption
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink{ [weak self] option in
                guard let self = self else { return }
                if !self.searchQuery.isEmpty {
                    self.resetAlbumsData()
                    self.fetchSearchResult()
                }
            }
    }

    func searchQueryBinding() {
        searchCancelable = $searchQuery
            .removeDuplicates()
            .debounce(for: 1.5, scheduler: RunLoop.main)
            .sink { [weak self] input in
                guard let self = self else { return }
                input == "" ?
                self.searchResults = [SearchResult]() :
                self.fetchSearchResult()
            }
    }
}


// MARK: - Update View functions

extension SearchScreenViewModel {

    func loadMore() {
        guard !isLoading, isLoadMore else { return }
        self.fetchSearchResult()
    }

    func resetAlbumsData() {
        page = 0
        offset = 0
        searchResults = []
    }

    func resetAllOnNotificationChange() {
        resetAlbumsData()
        searchQuery = ""
        selectedOption = .song
        isLoading = false
    }

    func loadMoreWhenScrolledToEnd(reader: GeometryProxy) -> Color {
        let minY = reader.frame(in: .global).minY
        let height = UIScreen.main.bounds.height / 1.3

        if !searchResults.isEmpty && minY < height {
            DispatchQueue.main.async {
                self.offset = self.searchResults.count
                self.isLoadMore = true
            }
        } else {
            self.isLoadMore = false
        }
        return Color.clear
    }
}


// MARK: - Fetch search result related funcitons

extension SearchScreenViewModel {

    func fetchSearchResult() {
        isTyping = false
        self.isLoading = true

        let request = updateSearchRequestModel()

        apiClient.request(request)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("error", error)
                    case .finished:
                        print("search result fetched")
                    }
                },
                receiveValue: { [weak self] (response: SearchResponse) in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.searchResults.append(contentsOf: response.results)
                        self.isLoading = false
                        self.page += 1
                    }
                }
            )
            .store(in: &cancelables)
    }

    func updateSearchRequestModel() -> EndPointRequest {
        let query = searchQuery.replacingOccurrences(of: " ", with: "+")
        let offset = limit * page

        switch selectedOption {
        case .all:
            return MyAlbumEndpoints.iTunesAPIEndPoint.search(
                SearchAllRequest(
                    searchQuery: query,
                    limit: self.limit,
                    offset: offset
                )
            )
        case .country:
            return MyAlbumEndpoints.iTunesAPIEndPoint.searchByCountry(
                SearchRequest(
                    searchQuery: query,
                    limit: self.limit,
                    offset: offset,
                    selectedOption: "country"
                )
            )
        case .song:
            return MyAlbumEndpoints.iTunesAPIEndPoint.searchBySong(
                SearchRequest(
                    searchQuery: query,
                    limit: self.limit,
                    offset: offset,
                    selectedOption: "song"
                )
            )
        }
    }
}
