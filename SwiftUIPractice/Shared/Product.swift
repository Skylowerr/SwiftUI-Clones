//
//  Product.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 15.11.2025.
//

import Foundation

//Codable niye?
///let products = try JSONDecoder().decode(ProductArray.self, from: data)
////Bu satır, dışarıdan gelen ham veri (data) bloğunu alır ve bunu Swift'teki ProductArray nesnesine güvenli bir şekilde dönüştürür. Decodable olmadan bu dönüşümü manuel olarak yapmak, çok daha karmaşık ve hataya açık bir süreç olurdu.
struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}


    // MARK: - Product
    struct Product: Codable, Identifiable {
        let id: Int
        let title, description: String
        let price, discountPercentage, rating: Double
        let stock: Int?
        let tags: [String]?
        let brand: String?
        let sku: String?
        let weight: Int?
        let warrantyInformation, shippingInformation: String?
        let minimumOrderQuantity: Int?
        let images: [String]
        let thumbnail: String?
        let category : String?
        
        var firstImage : String{
            images.first ?? Constants.randomImage
        }
        
        //MARK: INITIALIZER
        static var mock: Product{
            Product(
                id: 123,
                title: "Example Product Title",
                description: "This is some mock product description that goes here.",
                price: 999,
                discountPercentage: 15,
                rating: 4.5,
                stock: 50,
                tags: ["tag1","tag2"],
                brand: "Apple",
                sku: "sku",
                weight: 27,
                warrantyInformation: "Warranty Info",
                shippingInformation: "Shipping Info",
                minimumOrderQuantity: 7,
                images: [Constants.randomImage,Constants.randomImage,Constants.randomImage],
                thumbnail: Constants.randomImage,
                category: "Electronic Devices"
            )
        }
    }

    //ProductRow bu öğeleri gruplamak ve yatay bir liste (satır) oluşturmak için kullanılan bir konteynerdir.
    //her satırın (Row) kendine ait bir başlığı ve yatay olarak kaydırılabilen bir öğe listesi vardır. ["Apple Ürünleri"]
    struct ProductRow: Identifiable{
        let id = UUID().uuidString
        let title: String
        let products : [Product]
        
    }
