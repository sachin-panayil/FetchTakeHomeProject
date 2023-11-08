//
//  DessertDetailViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Sachin Panayil on 11/8/23.
//

import Foundation

final class DessertDetailViewModel: ObservableObject {
  @Published var dessertDetail: DessertDetailResponse.DessertDetail?
  @Published var isLoading = false
  var dessert: DessertResponse.Dessert
  
  init(dessert: DessertResponse.Dessert) {
    self.dessert = dessert
  }
  
  func fetchDessertDetails() {
    isLoading = true
    
    let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(dessert.idMeal)"
    
    guard let url = URL(string: urlString) else {
      print("Invalid URL")
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print("Error found! \(error)")
        return
      }
      
      guard let data = data else {
        print("No data received.")
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let apiResponse = try decoder.decode(DessertDetailResponse.self, from: data)
        DispatchQueue.main.async {
          self.dessertDetail = apiResponse.meals.first
          self.isLoading = false
        }
      } catch {
        print("Error found! \(error)")
      }
    }
    task.resume()
  }
  
}
