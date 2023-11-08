//
//  Dessert.swift
//  FetchTakeHomeProject
//
//  Created by Sachin Panayil on 11/8/23.
//

import Foundation

struct DessertResponse: Codable {
  var meals: [Dessert]
  
  struct Dessert: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
  }
}
