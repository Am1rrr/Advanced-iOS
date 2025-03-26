//
//  HeroListView.swift
//  lab4
//
//  Created by amir on 26.03.2025.
//

import Foundation
import SwiftUI

struct HeroListView: View {
    @ObservedObject var viewModel: HeroListViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            } else {
                List(viewModel.heroes) { hero in
                    NavigationLink(destination: HeroDetailView(hero: hero)) {
                        HStack {
                            AsyncImage(url: URL(string: hero.images.lg)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(hero.name).font(.headline)
                                Text(hero.biography.fullName).font(.subheadline)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("SuperHeroes")
    }
}

