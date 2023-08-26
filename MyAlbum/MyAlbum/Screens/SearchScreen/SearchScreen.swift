//
//  SearchScreen.swift
//  MyAlbum
//
//  Created by Ronan Mak on 20/8/2023.
//

import SwiftUI

struct SearchScreen: View {

    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @ObservedObject var viewModel = SearchScreenViewModel()

    @State private var text = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("SearchTitle".localized(language))
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(10)

                // Search Bar
                VStack(spacing: 15) {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("searchPlaceholder".localized(language), text: $text)
                            .onChange(of: text, perform: { newValue in
                                viewModel.resetAlbumsData()
                                viewModel.searchQuery = newValue
                                viewModel.isTyping = true
                            })
                            .submitLabel(.done)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                }
                .padding()

                // Picker View
                PickerView(selectedOption: $viewModel.selectedOption)

                // Search Content
                ScrollView(.vertical, showsIndicators: false, content: {
                    ForEach(viewModel.searchResults, id: \.self) { album in
                        NavigationLink(destination: SeachContentDetailView(data: album)) {
                            SearchContentRow(album: album)
                        }
                    }

                    // Loading Indicator
                    if viewModel.showResultIndicator {
                        Text("NoResultFound".localized(language))
                            .padding(.vertical, 10)
                    } else if viewModel.showLoadingIcon{
                        ActivityIndicator(isAnimating: true) {
                            $0.color = .black
                            $0.hidesWhenStopped = false
                        }
                        .onAppear(perform: {
                            viewModel.loadMore()
                        })

                    } else {
                        GeometryReader { (reader: GeometryProxy) in
                            viewModel.loadMoreWhenScrolledToEnd(reader: reader)
                        }
                        .frame(width: 20, height: 20)
                    }
                })
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(for: LocalizationService.changedLanguage)
        ) { _ in
            text = ""
            viewModel.resetAllOnNotificationChange()
        }
    }
}

