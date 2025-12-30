//
//  User.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 15.11.2025.
//

import Foundation

// MARK: - WeatherApp
struct UserArray: Codable {
    let users: [User] // users.users kısmı burası oluyor. Fakat nedenini anlamadım
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    //TODO: neden buralara = atmak yerine : Şeklinde tanımladık?
    
    var work : String {
        "Worker at Some Job"
    }
    var education : String{
        "Graduate Degree"
    }
    
    var aboutMe : String{
        "This is a sentence about me that will look good on my profile"
    }
    
    //TODO: Neden {} arasına yazıyoruz? var basics : [UserInterest] = [] şeklinde yazamaz mıyız?
    //height henüz initialize edilmeden (nesne tam oluşmadan) ona erişmeye çalışmış olurdun. Yani hata alırdın
    //emojiler nil
    var basics: [UserInterest]{
        [
            UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
            UserInterest(iconName: "graduationcap", emoji: nil, text: education),
            UserInterest(iconName: "wineglass", emoji: nil, text: "Socially"),
            UserInterest(iconName: "moon.stars.fill", emoji: nil, text: "Virgo"),
        ]
    }
    
    //iconlar nil
    var interests: [UserInterest]{
        [
            UserInterest(iconName: nil, emoji: "👟", text: "Running"),
            UserInterest(iconName: nil, emoji: "💪", text: "Gym"),
            UserInterest(iconName: nil, emoji: "💃", text: "Dancing"),
            UserInterest(iconName: nil, emoji: "🚗", text: "Driving"),
        ]
    }
    
    var images : [String]{
        ["https://picsum.photos/500/500","https://picsum.photos/600/600","https://picsum.photos/700/700"]
    }
    
    
    static var mock: User{
        User(
            id: 444,
            firstName: "Emirhan",
            lastName: "Gokce",
            age: 20,
            email: "sky@sky.com",
            phone: "",
            username: "",
            password: "",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
}


