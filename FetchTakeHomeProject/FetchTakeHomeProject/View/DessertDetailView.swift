//
//  DessertDetailView.swift
//  FetchTakeHomeProject
//
//  Created by Sachin Panayil on 11/8/23.
//

import SwiftUI

struct DessertDetailView: View {
  
  @StateObject var viewModel: DessertDetailViewModel
  
  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      ScrollView {
        TitleView(title: viewModel.dessertDetail?.strMeal)
        
        SectionHeaderView(text: "Instructions", isLoading: viewModel.isLoading)
        InstructionsView(instructions: viewModel.dessertDetail?.strInstructions)
        
        SectionHeaderView(text: "Ingredients and Measurements", isLoading: viewModel.isLoading)
        IngredientsMeasurementsView(ingredients: viewModel.dessertDetail?.ingredients, measurements: viewModel.dessertDetail?.measurements)
      }
      .padding()
      .multilineTextAlignment(.center)
      .onAppear {
        if viewModel.dessertDetail == nil {
          viewModel.fetchDessertDetails()
        }
      }
      .background(RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue).opacity(0.4)
                    .shadow(radius: 20)).padding()
      .overlay {
        if viewModel.isLoading {
          ProgressView()
            .controlSize(.large)
            .scaleEffect(1.5)
        }
      }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

private struct TitleView: View {
  let title: String?
  
  var body: some View {
    if let title = title {
      Text(title)
        .padding(.bottom, 1)
        .font(.largeTitle)
        .bold()
    } else {
      Text("Loading!")
        .padding(.bottom, 1)
        .font(.largeTitle)
        .bold()
    }
  }
}

private struct SectionHeaderView: View {
  let text: String
  let isLoading: Bool
  
  var body: some View {
    Text(isLoading ? "" : text)
      .padding(.bottom, 1)
      .font(.title2)
      .underline()
  }
}

private struct InstructionsView: View {
  let instructions: String?
  
  var body: some View {
    if let instructions = instructions {
      Text(instructions)
        .font(.subheadline)
        .padding(.bottom, 30)
    }
  }
}

private struct IngredientsMeasurementsView: View {
  let ingredients: [String]?
  let measurements: [String]?
  
  var body: some View {
    VStack {
      if let ingredients = ingredients, let measurements = measurements {
        ForEach(Array(zip(ingredients, measurements)), id: \.0) { ingredient, measurement in
          HStack {
            Text(ingredient)
            Spacer()
            Text(measurement)
          }
          .font(.subheadline)
        }
      }
    }
  }
}


struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
      DessertDetailView(viewModel: DessertDetailViewModel(dessert: DessertResponse.Dessert.init(
        strMeal: "Apple Pie",
        strMealThumb: "www.google.com",
        idMeal: "52893")))
    }
}
