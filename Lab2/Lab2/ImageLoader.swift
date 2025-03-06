//
//  ImageLoader.swift
//  Lab2
//
//  Created by amir on 27.02.2025.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {
    @Published var imageData: Data? = nil

    func loadImage(url: URL) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            let data = Data()
            DispatchQueue.main.async {
                self.imageData = data
            }
        }
    }
}

