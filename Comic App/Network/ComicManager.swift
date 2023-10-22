//
//  ComicManager.swift
//  Comic App
//
//  Created by Jaylen Smith on 10/22/23.
//

import Foundation
import UIKit

enum ComicManagerError: Error {
    case urlError
    case dataError
    case decodingError
}

final class ComicManager {
    
    ///Shared instance
    static let shared = ComicManager()
    
    ///Fetch today's comic
    func fetchTodaysComic(completion: @escaping (Result<Comic, Error>) -> Void) {
        guard let url = URL(string: "https://xkcd.com/info.0.json") else {
            return
        }
        
        URLSession.shared.fetchComic(url) { result in
            switch result {
            case .success(let comic):
                completion(.success(comic))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    ///Fetch comic by number
    func fetchComicByNumber(_ number: Int, completion: @escaping (Result<Comic, Error>) -> Void) {
        guard let url = URL(string: "https://xkcd.com/\(number)/info.0.json") else {
            return
        }
        
        URLSession.shared.fetchComic(url) { result in
            switch result {
            case .success(let comic):
                completion(.success(comic))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    ///Fetch the comic image provided by the url
    func fetchComicImage(_ imageUrl: URL?, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.fetchComicImage(imageUrl) { image in
            completion(image)
        }
    }
}

extension URLSession {
    
    func fetchComic(_ url: URL, completion: @escaping (Result<Comic, Error>) -> Void) {
        dataTask(with: url) { data, response, err in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, err == nil else {
                completion(.failure(ComicManagerError.dataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let comic = try decoder.decode(Comic.self, from: data)
                completion(.success(comic))
            } catch {
                completion(.failure(ComicManagerError.decodingError))
            }
        }
        .resume()
    }
    
    func fetchComicImage(_ imageUrl: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl else {
            completion(nil)
            return
        }
        
        dataTask(with: imageUrl) { data, response, err in
            guard let data, let response = response as? HTTPURLResponse, response.statusCode == 200, err == nil else {
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }
        .resume()
    }
}
