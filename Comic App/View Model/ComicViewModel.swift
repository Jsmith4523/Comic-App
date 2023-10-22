//
//  ComicViewModel.swift
//  Comic App
//
//  Created by Jaylen Smith on 10/22/23.
//

import Foundation

final class ComicViewModel: ObservableObject {
    
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
            comicManager.fetchTodaysComic { [weak self] result in
                switch result {
                case .success(let comic):
                    self?.comic = comic
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func fetchValidComic() {
            comicManager.fetchComicByNumber(number) { [weak self] result in
                switch result {
                case .success(let comic):
                    self?.comic = comic
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
