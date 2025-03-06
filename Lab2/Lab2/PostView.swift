//
//  PostView.swift
//  Lab2
//
//  Created by amir on 27.02.2025.
//

import SwiftUI

struct PostView: View {
    @StateObject var imageLoader = ImageLoader()

    var body: some View {
        VStack {
            if let _ = imageLoader.imageData {
                Text("Image Loaded")
            } else {
                Text("Loading Image...")
            }
        }
        .onAppear {
            imageLoader.loadImage(url: URL(string: "https://example.com/image.jpg")!)
        }
    }
}
