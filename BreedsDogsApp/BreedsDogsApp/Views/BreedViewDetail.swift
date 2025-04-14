//
//  BreedViewDetail.swift
//  BreedsDogsApp
//
//  Created by David Jesús Maya Quirós on 14/4/25.
//

import SwiftUI

struct BreedViewDetail: View {
    private var breed: String
    private var subBreed: String?
    @EnvironmentObject private var viewModel: BreedsViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(breed: String, subBreed: String? = nil) {
        self.breed = breed
        self.subBreed = subBreed
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: self.viewModel.breedImageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: UIScreen.main.bounds.width - 20, height: 200)
                .clipShape(.rect(cornerRadius: 15))
                .padding(15)
                
                HStack {
                    Text(self.breed.capitalized)
                    Text(self.subBreed?.capitalized ?? "")
                }
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed gravida massa nec mollis fringila. Nunc gravida ultricies imperdiet.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("List")
                    }
                }

            }
            ToolbarItem(placement: .principal) {
                Text("Detail")
                    .fontWeight(.bold)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                await self.viewModel.fetchBreedImage(breedName: "\(breed) \(subBreed ?? "")".replacingOccurrences(of: " ", with: "/"))
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}
