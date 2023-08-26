//
//  ViewExtensions.swift
//  MyAlbum
//
//  Created by Ronan Mak on 21/8/2023.
//

import SwiftUI

// MARK: - ActivityIndicator Config

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView)->Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}
