//
//  likeButtonView.swift
//  MyAlbum
//
//  Created by Ronan Mak on 22/8/2023.
//

import SwiftUI

struct likeButtonView: View {

    @State private var isFilled = false

    var buttonCallback: (Bool) -> Void

    var body: some View {
        Image(systemName: isFilled ? "heart.fill" : "heart")
            .foregroundColor(isFilled ? .red : .gray)
            .font(.system(size: 30))
            .onTapGesture {
                isFilled.toggle()
                buttonCallback(isFilled)
            }
    }
}
