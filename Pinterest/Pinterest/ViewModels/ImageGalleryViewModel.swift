//
//  ImageGalleryViewModel.swift
//  Pinterest
//
//  Created by amir on 03.04.2025.
//

import Foundation

class ImageGalleryViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    private let imageCount = 5

    func fetchImages() {
        DispatchQueue.global(qos: .userInitiated).async {
            var newImages: [ImageModel] = []
            let group = DispatchGroup()

            for _ in 0..<self.imageCount {
                group.enter()
                let url = "https://picsum.photos/200/300?random=\(UUID().uuidString)"
                let model = ImageModel(url: url)
                newImages.append(model)
                group.leave()
            }

            group.notify(queue: .main) {
                self.images.append(contentsOf: newImages)
            }
        }
    }
}
