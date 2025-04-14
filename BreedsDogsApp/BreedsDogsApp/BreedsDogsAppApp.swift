//
//  BreedsDogsAppApp.swift
//  BreedsDogsApp
//
//  Created by David Jesús Maya Quirós on 11/4/25.
//

import SwiftUI

@main
struct BreedsDogsAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BreedsListView()
                    .environmentObject(BreedsViewModel())
            }
        }
    }
}
