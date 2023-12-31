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
      List {
        ForEach(viewModel.desserts, id: \.self) { dessert in
          DessertCard(dessert: dessert)
        }
      }
      .padding()
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

private struct DessertCard: View {
  let dessert: DessertResponse.Dessert
  
  var body: some View {
    NavigationLink(destination: DessertDetailView(viewModel: DessertDetailViewModel(dessert: dessert))) {
      HStack(spacing: 20) {
        AsyncImage(
          url: URL(string: dessert.strMealThumb),
          transaction: Transaction(animation: .easeInOut(duration: 0.5))) { phase in
            switch phase {
            case .empty:
              ProgressView()
                .frame(maxWidth: 40, maxHeight: 40)
            case .success(let image):
              image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 40, maxHeight: 40)
                .clipShape(Circle())
                .transition(.opacity)
            case .failure:
              Image(systemName: "birthday.cake.fill")
                .frame(maxWidth: 40, maxHeight: 40)
            @unknown default:
              EmptyView()
            }
          }
        Text(dessert.strMeal.capitalized)
          .font(.title3)
        Spacer()
      }
    }
  }
}

struct DessertFeedView_Previews: PreviewProvider {
  static var previews: some View {
    DessertFeedView()
  }
}
