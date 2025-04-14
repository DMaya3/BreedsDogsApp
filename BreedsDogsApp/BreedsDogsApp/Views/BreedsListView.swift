//
//  BreedsListView.swift
//  BreedsDogsApp
//
//  Created by David Jesús Maya Quirós on 11/4/25.
//

import SwiftUI

struct BreedsListView: View {
    @EnvironmentObject var viewModel: BreedsViewModel
    @State private var selectedBreed: SelectedBreed? = nil
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(self.filteredBreeds, id: \.id) { breed in
                ForEach(breed.subBreeds, id: \.self) { subBreed in
                    Button {
                        self.selectedBreed = SelectedBreed(main: breed.main, sub: subBreed)
                    } label: {
                        HStack {
                            Text(breed.main.capitalized)
                            Text(subBreed.capitalized)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundStyle(.black)
                    }
                }
            }
            .sheet(item: $selectedBreed) { selection in
                NavigationStack {
                    BreedViewDetail(breed: selection.main, subBreed: selection.sub)
                        .environmentObject(self.viewModel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Dogs")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            .searchable(text: $searchText, prompt: "Search")
        }
    }
}

extension BreedsListView {
    var filteredBreeds: [Breed] {
        if searchText.isEmpty {
            return viewModel.breedsArray
        } else {
            return viewModel.breedsArray.compactMap { breed in
                let matchesMain = breed.main.localizedCaseInsensitiveContains(searchText)
                let filteredSubBreeds = breed.subBreeds.filter {
                    $0.localizedCaseInsensitiveContains(searchText)
                }
                
                if matchesMain {
                    return Breed(main: breed.main, subBreeds: breed.subBreeds)
                } else if !filteredSubBreeds.isEmpty {
                    return Breed(main: breed.main, subBreeds: filteredSubBreeds)
                } else {
                    return nil
                }
            }
        }
    }
}
