//
//  ContentView.swift
//  FindMyPet
//
//  Created by amir on 07.05.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .profile
//    @StateObject private var chatVM = ChatViewModel(chatId: "globalChat")
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .lostFound:
                    LostFoundView()
                case .chat:
                    ChatListView()
                case .myPets:
                    ReportPetView()
                case .profile:
                    if authViewModel.isAuthenticated{
                        ProfileView()
                    } else{
                        LoginView()
                    }
                }
            }

            CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            tabButton(tab: .lostFound, icon: "magnifyingglass")
            tabButton(tab: .chat, icon: "heart.fill")
            tabButton(tab: .myPets, icon: "pawprint.fill")
            tabButton(tab: .profile, icon: "person.crop.circle")
        }
        .padding(.horizontal, 25)
        .padding(.top, 10)
        .padding(.bottom, 30)
        .background(Color(red: 188/255, green: 230/255, blue: 154/255))
    }

    private func tabButton(tab: Tab, icon: String) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(selectedTab == tab ? .white : .white.opacity(0.5))
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())}
