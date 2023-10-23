//
//  Comic.swift
//  Comic App
//
//  Created by Jaylen Smith on 10/22/23.
//

import Foundation

struct Comic: Identifiable, Codable {
    
    var id: Int { self.num }
    
    let alt: String
    let day: String
    let img: String
    let link: String
    let month: String
    let news: String
    let num: Int
    let safe_title: String
    let title: String
    let transcript: String
    let year: String
}

extension Comic {
    
    ///The url associated with this comic
    var comicImageUrl: URL? {
        return URL(string: self.img)
    }
    
    ///dd/mm/yyyy format
    var formattedDate: String {
        "\(self.month)/\(self.day)/\(self.year)"
    }
}























//{
//  "month": "1",
//  "num": 50,
//  "link": "",
//  "year": "2006",
//  "news": "",
//  "safe_title": "Penny Arcade",
//  "transcript": "Tycho: You know what? If you've never played the 1995 SNES RPG 'Seiken Densetsu' don't even _bother_ reading today's strip. We don't _need_ your kind here.\n{{title text: Of course, Penny Arcade has already mocked themselves for this. They don't care.}}",
//  "alt": "Of course, Penny Arcade has already mocked themselves for this.  They don't care.",
//  "img": "https://imgs.xkcd.com/comics/penny_arcade.jpg",
//  "title": "Penny Arcade",
//  "day": "17"
//}
