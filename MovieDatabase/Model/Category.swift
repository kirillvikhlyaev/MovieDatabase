//
//  Category.swift
//  MovieDatabase
//
//  Created by Кирилл on 31.08.2022.
//

import Foundation

struct Category {
    let name: String
    let movies: [Collectable]
}

protocol Collectable {}
