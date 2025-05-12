//
//  ImageGalleryViewModel.swift
//  Pinterest
//
//  Created by amir on 03.04.2025.
//

//import Foundation
//
//class ImageGalleryViewModel: ObservableObject {
//    @Published var images: [ImageModel] = []
//    private let imageCount = 5
//
//    func fetchImages() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            var newImages: [ImageModel] = []
//            let group = DispatchGroup()
//
//            for _ in 0..<self.imageCount {
//                group.enter()
//                let url = "https://picsum.photos/200/300?random=\(UUID().uuidString)"
//                let model = ImageModel(url: url)
//                newImages.append(model)
//                group.leave()
//            }
//
//            group.notify(queue: .main) {
//                self.images.append(contentsOf: newImages)
//            }
//        }
//    }
//}

import Foundation
import UIKit

class ImageGalleryViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    private let imageCount = 5

    func fetchImages() {
        DispatchQueue.global(qos: .userInitiated).async {
            var newImages: [ImageModel] = []
            let group = DispatchGroup()

            for _ in 0..<self.imageCount {
                group.enter()

                let urlString = "https://picsum.photos/200/300?random=\(UUID().uuidString)"
                guard let url = URL(string: urlString) else {
//                    group.leave()
                    continue
                }

                URLSession.shared.dataTask(with: url) { data, _, _ in
                    defer { group.leave() }

                    if let data = data, let image = UIImage(data: data) {
                        let model = ImageModel(image: image)
                        newImages.append(model)
                    }
                }.resume()
            }

            group.notify(queue: .main) {
                self.images.append(contentsOf: newImages)
            }
        }
    }
}
