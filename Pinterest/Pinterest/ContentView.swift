//
//  ContentView.swift
//  Pinterest
//
//  Created by amir on 03.04.2025.
//

import SwiftUI
struct ContentView: View {
    @StateObject private var viewModel = ImageGalleryViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Button("Fetch Images") {
                    viewModel.fetchImages()
                }
                .padding()
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(viewModel.images) { image in
                            AsyncImage(url: URL(string: image.url)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Image Gallery")
        }
    }
}
