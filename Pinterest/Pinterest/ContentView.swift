//
//  ContentView.swift
//  Pinterest
//
//  Created by amir on 03.04.2025.
//

//import SwiftUI
//struct ContentView: View {
//    @StateObject private var viewModel = ImageGalleryViewModel()
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Button("Fetch Images") {
//                    viewModel.fetchImages()
//                }
//                .padding()
//                ScrollView {
//                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
//                        ForEach(viewModel.images) { image in
//                            AsyncImage(url: URL(string: image.url)) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFill()
//                            } placeholder: {
//                                ProgressView()
//                            }
//                            .frame(height: 150)
//                            .clipped()
//                            .cornerRadius(8)
//                        }
//                    }
//                    .padding()
//                }
//            }
//            .navigationTitle("Image Gallery")
//        }
//    }
//}

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageGalleryViewModel()

    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 8)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.images) { imageModel in
                        Image(uiImage: imageModel.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 180)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                .padding()

                Button("Load More Images") {
                    viewModel.fetchImages()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Pinterest Gallery")
            .onAppear {
                viewModel.fetchImages()
            }
        }
    }
}


#Preview {
    ContentView()
}
