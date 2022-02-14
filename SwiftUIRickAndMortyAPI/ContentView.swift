//
//  ContentView.swift
//  SwiftUIRickAndMortyAPI
//
//  Created by Richard Price on 11/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharacterViewModel(service: CharacterService())
 
    var body: some View {
        NavigationView {
            
            switch viewModel.state {
            case .success(let data):
                List {
                    ForEach(data, id: \.id) { item in
                        Text(item.name)
                    }
                }
                .navigationBarTitle("Characters")
                .font(.largeTitle)
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }.task {
            await viewModel.getCharacters()
        }
        .alert("Error", isPresented: $viewModel.hasError, presenting: viewModel.state) { detail in
            Button("Retry") {
                Task {
                    await viewModel.getCharacters()
                }
            }
        } message: { detail in
            if case let .failed(error) = detail {
                Text(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
