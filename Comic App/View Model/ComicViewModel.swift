//
//  ComicViewModel.swift
//  Comic App
//
//  Created by Jaylen Smith on 10/22/23.
//

import Foundation

@MainActor
final class ComicViewModel: ObservableObject {
    
    @Published var showComicFetchError = false
    @Published var number: Int = 1
    @Published var comic: Comic!
    
    private let comicManager = ComicManager.shared
    
    func fetchComicFromNum() {
        
        switch number.withinComicRange {
        case true:
           fetchValidComic()
        case false:
            fetchTodaysComic()
        }
        
        func fetchTodaysComic() {
            self.number = 1
            
            comicManager.fetchTodaysComic { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let comic):
                        self?.comic = comic
                    case .failure(_):
                        self?.showComicFetchError.toggle()
                    }
                }
            }
        }
        
        func fetchValidComic() {
            comicManager.fetchComicByNumber(number) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let comic):
                        self?.comic = comic
                    case .failure(_):
                        self?.showComicFetchError.toggle()
                    }
                }
            }
        }
    }
}
