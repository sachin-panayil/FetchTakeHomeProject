//
//  DessertFeedViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Sachin Panayil on 11/8/23.
//

import Foundation

final class DessertFeedViewModel: ObservableObject {
  @Published var desserts: [DessertResponse.Dessert] = []
  @Published var isLoading = false
  
  func fetchDesserts() {
    isLoading = true
    
    let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
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
        let apiResponse = try decoder.decode(DessertResponse.self, from: data)
        DispatchQueue.main.async {
          self.desserts = apiResponse.meals.sorted { $0.strMeal < $1.strMeal }
          self.isLoading = false
        }
      } catch {
        print("Error found! \(error)")
      }
    }
    task.resume()
  }
}
