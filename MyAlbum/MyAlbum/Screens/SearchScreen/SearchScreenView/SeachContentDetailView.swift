//
//  SeachContentDetailView.swift
//  MyAlbum
//
//  Created by Ronan Mak on 23/8/2023.
//

import SwiftUI

struct SeachContentDetailView: View {

    var data: SearchResult

    var body: some View {
        VStack {
            HStack {
                Text(data.collectionName ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding([.leading, .trailing])
        }
    }
}
