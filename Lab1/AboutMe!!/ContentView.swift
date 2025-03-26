//
//  ContentView.swift
//  AboutMe!!
//
//  Created by amir on 14.02.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//            Text("Khamrayev Amirshakh")
//                .font(.largeTitle )
//            Image("myPhoto")
//            .resizable()
//            .scaledToFit()
//            .frame(width: 200, height: 200)
//            List{
//                HStack{
//                    Text("Age")
//                    Spacer()
//                    Text("20")
//                }
//                HStack{
//                    Text("Location")
//                    Spacer()
//                    Text("Almaty")
//                }
//                HStack{
//                    Text("Occupation")
//                    Spacer()
//                    Text("Student")
//                }
//                Section("Favourites"){
//                    HStack{
//                        Text("Food")
//                        Spacer()
//                        Text("Steak 🥩 ")
//                    }
//                    HStack{
//                        Text("Colour")
//                        Spacer()
//                        Text("Blue")
//                            .bold()
//                            .foregroundColor(.blue)
//                    }
//                    HStack{
//                        Text("Animal")
//                        Spacer()
//                        Text("Dog 🐶")
//                    }
//                }
//                Section("Interests"){
//                    Text("Gym 🏋🏿")
//                    Text("Films")
//                    Text("Books")
//                }
//            }
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "person")
                }
            
            StoryView()
                .tabItem {
                    Label("Story", systemImage: "book")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeView: View {
    
    var body: some View {
        VStack {
            Text("All About")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()


            Image("myPhoto")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(40)


            Text("Khamrayev Amirshakh")
                .font(.title)
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

struct StoryView: View {
    var body: some View {
        VStack {
            Text("My Story")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                Text("I was born in Almaty. My goal is to become greate IOS developer!! 🧑🏼‍💻")
                    .font(.body)
                    .padding()
            }
        }
        .padding([.top, .bottom], 50)
    }
}


//struct StoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryView()
//    }
//}

struct FavoritesView: View {
    var body: some View {
        List {
            Section("Hobbies") {
                Text("Gym 🏋🏿")
                Text("Books")
                Text("Movies")
            }
            
            Section("Foods") {
                HStack {
                    Text("Food")
                    Spacer()
                    Text("Steak 🥩 ")
                }
            }

            Section("Favorite Colors") {
                HStack {
                    Text("Colour")
                    Spacer()
                    Text("Blue")
                        .bold()
                        .foregroundStyle(.blue)
                }
            }
        }
        .navigationTitle("Favorites")
    }
}



struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

