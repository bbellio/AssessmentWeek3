//
//  SearchResult.swift
//  MovieSearch
//
//  Created by Bethany Wride on 10/4/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
//    private enum CodingKeys: String, CodingKey {
//        case title
//        case rating = "vote_average"
//        case overview
//        case poster = "poster_path"
//    }
    let title: String
    let vote_average: Double
    let overview: String
    let poster_path: String?
}
