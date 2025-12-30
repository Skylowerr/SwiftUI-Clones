//
//  Category.swift
//  SwiftUIPractice
//
//  Created by Emirhan Gökçe on 16.11.2025.
//

import Foundation

//String diyerek .rawValue'yu, CaseIterable diyerek .allCases 'ı aktif hale getiririz
enum Category : String, CaseIterable{
    case all, music, podcasts, audiobooks
}
