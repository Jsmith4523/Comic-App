//
//  Int+EXT.swift
//  Comic App
//
//  Created by Jaylen Smith on 10/22/23.
//

import Foundation

extension Int {
    
    var withinComicRange: Bool {
        return (self >= 0 && self <= 2843)
    }
}
