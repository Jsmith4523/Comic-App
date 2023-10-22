//
//  ContentView.swift
//  Comic App
//
//  Created by Jaylen Smith on 10/22/23.
//

import SwiftUI

struct ContentView: View {
        
    @State private var showError = false
    @StateObject private var comicVM = ComicViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField(value: $comicVM.number, format: .number) {
                    Text("Comic Number")
                }
                .textFieldStyle(.roundedBorder)
                if showError {
                    Text("That number is within an invalid range or is not a number!")
                        .font(.system(size: 18).bold())
                        .foregroundColor(.red)
                        .padding()
                }
                Button {
                    comicVM.fetchComicFromNum()
                } label: {
                    Text("Submit")
                        .foregroundColor(.white)
                        .font(.system(size: 18).weight(.heavy))
                        .padding()
                        .frame(width: 250)
                        .background(.blue)
                        .cornerRadius(15)
                        .padding()
                }
            }
            .padding()
            .multilineTextAlignment(.center)
//            .sheet(item: $comicVM.comic) { comic in
//                ComicDetailView(comic: comic)
//            }
            .onReceive(comicVM.$number) { number in
                if !(number.withinComicRange) {
                    showError = true
                } else {
                    showError = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
