//
//  DatabaseHelper.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 15.11.2025.
//

import Foundation

//MARK: Sadece Welcome ve User kısımlarını alıyoruz

struct DatabaseHelper{
    
    //MARK: Fix data çekme yöntemi
    func getProducts() async throws -> [Product]{
        guard let url = URL(string : "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        let (data , _) = try await URLSession.shared.data(from: url)
        let products = try  JSONDecoder().decode(ProductArray.self, from: data)
        return products.products
    }
    
    func getUsers() async throws -> [User]{
        guard let url = URL(string : "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
        let (data , _) = try await URLSession.shared.data(from: url)
        let users = try  JSONDecoder().decode(UserArray.self, from: data)
        return users.users
    }
}

