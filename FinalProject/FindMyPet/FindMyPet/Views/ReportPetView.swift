//
//  ReportPetView.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//

import SwiftUI
import PhotosUI

struct ReportPetView: View {
    @StateObject private var viewModel = ReportPetViewModel()
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        ScrollView {
            VStack(spacing:20) {
                ZStack{
                    Rectangle()
                        .frame(width: 410, height: 120)
                        .foregroundColor(Color(red: 188/255, green: 230/255, blue: 154/255))
                    Text("Report Pet").font(.title).bold()
                        .padding(.top, 30)
                }
                Image("Dog")
                Text("Have you lost your pet?\nOr found someone else’s?")
                    .multilineTextAlignment(.center)
                Text("Report it to FindMyPet to alert our network")
                    .font(.system(size: 17,weight: .medium))
                   

                Picker("Status", selection: $viewModel.petStatus) {
                    Text(PetStatus.Lost.rawValue).tag(PetStatus.Lost)
                    Text(PetStatus.Found.rawValue).tag(PetStatus.Found)
                }
                .pickerStyle(.segmented)
                .padding()



                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                TextField("Description", text: $viewModel.description, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...)
                    .padding(.horizontal)

                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(8)
                }

                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Text("Add a photo of this pet")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .onChange(of: selectedItem) { item in
                    Task {
                        if let data = try? await item?.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            viewModel.image = image
                        }
                    }
                }
                
                Menu {
                    Button("Dog") { viewModel.type = .Dog }
                    Button("Cat") { viewModel.type = .Cat }
                    Button("Other") { viewModel.type = .Other }
                } label: {
                    HStack {
                        Text("Type: \(viewModel.type.rawValue)")
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Button("Submit") {
                        viewModel.submitReport()
                    }
                    .buttonStyle(.borderedProminent)
                }

                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }

                if viewModel.uploadSuccess {
                    Text("Successfully submitted!").foregroundColor(.green)
                }
                Spacer()
            }
//            .ignoresSafeArea(edges: .top)
//            .padding([.leading, .trailing, .bottom])

            
            
        }
        .ignoresSafeArea(edges: .top)
        .padding([.leading, .trailing, .bottom])
    }
}

#Preview {
    ReportPetView()
}
