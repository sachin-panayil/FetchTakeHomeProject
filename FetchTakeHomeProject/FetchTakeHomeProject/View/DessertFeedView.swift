//
//  DessertFeedView.swift
//  FetchTakeHomeProject
//
//  Created by Sachin Panayil on 11/8/23.
//

import SwiftUI

struct DessertFeedView: View {
  @ObservedObject var viewModel = DessertFeedViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        List {
          ForEach(viewModel.desserts, id: \.self) { dessert in
            NavigationLink(destination: DessertDetailView(viewModel: DessertDetailViewModel(dessert: dessert))) {
              Text(dessert.strMeal)
            }
          }
        }
        .padding()
      }
      .navigationTitle(Text("List of Desserts"))
    }
    .onAppear(perform: viewModel.fetchDesserts)
    .overlay {
      if viewModel.isLoading {
        ProgressView()
          .controlSize(.large)
      }
    }
  }
}
  
  struct DessertFeedView_Previews: PreviewProvider {
    static var previews: some View {
      DessertFeedView()
    }
  }
