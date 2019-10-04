//
//  SearchResultController.swift
//  MovieSearch
//
//  Created by Bethany Wride on 10/4/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class SearchResultController {
    static let baseURL = URL(string: SearchConstants.baseURL)
    static let imageURL = URL(string: SearchConstants.imageURL)
    
    static func searchMovieDatabaseWith(searchText: String, completion: @escaping ([Movie]) -> Void) {
        guard var unwrappedURL = baseURL else {
            completion([])
            return
        }
        
        let searchURL = unwrappedURL.appendingPathComponent(SearchConstants.searchComponent)
        let movieURL = searchURL.appendingPathComponent(SearchConstants.movieComponent)
        
        guard var urlComponents = URLComponents(url: movieURL, resolvingAgainstBaseURL: true) else {
            print("Error with URL components")
            completion([])
            return
        }
        
        let apiQuery = URLQueryItem(name: SearchConstants.apiKey, value: SearchConstants.apiValue)
        let searchTextQuery = URLQueryItem(name: SearchConstants.queryKey, value: searchText)
        urlComponents.queryItems = [apiQuery, searchTextQuery]
        
        guard let finalURL = urlComponents.url else {
            print("Error with final URL")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in dataTask : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("No data")
                completion([])
                return
            }
            
            do {
                let decodedSearchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                completion(decodedSearchResults.results)
            } catch {
                let error = error
                print("Error decoding data: \(error)")
            }
        }.resume() // End of dataTask
    } // End of function
    
    static func getMoviePosterFor(movie: Movie, completion: @escaping (UIImage?) -> Void) {
        guard let unwrappedImageURL = imageURL else {
            print("No URL")
            completion(nil)
            return
        }
        guard let moviePoster = movie.poster_path else { return }
        let imageURLWithValue = unwrappedImageURL.appendingPathComponent(moviePoster)
        
        URLSession.shared.dataTask(with: imageURLWithValue) { (data, _, error) in
            if let error = error {
                print("Error in dataTask : \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("No image")
                return
            }
            completion(image)
        }.resume() // End of dataTask
    } // End of function
} // End of class
