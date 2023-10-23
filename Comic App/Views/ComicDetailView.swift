//
//  ComicDetailView.swift
//  Comic App
//
//  Created by Jaylen Smith on 10/23/23.
//

import SwiftUI

struct ComicDetailView: View {
    
    @State private var comicImage: UIImage?
    
    let comic: Comic
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        Text(comic.title)
                            .font(.system(size: 25).bold())
                        Text(comic.formattedDate)
                            .font(.system(size: 19))
                    }
                    .multilineTextAlignment(.center)
                    if let comicImage {
                        Image(uiImage: comicImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        ZStack(alignment: .center) {
                            Color(uiColor: .opaqueSeparator)
                            ProgressView()
                        }
                        .frame(height: 200)
                    }
                    HStack {
                        VStack {
                            Text(comic.transcript)
                                .font(.system(size: 20).bold())
                        }
                        Spacer()
                    }
                    .multilineTextAlignment(.leading)
                    .padding()
                }
            }
            .presentationDragIndicator(.visible)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                getComicImage()
            }
        }
    }
    
    private func getComicImage() {
        ComicManager.shared.fetchComicImage(comic.comicImageUrl) { image in
            DispatchQueue.main.async {
                self.comicImage = image
            }
        }
    }
}
//
//struct ComicDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ComicDetailView(comic: .dummyComic)
//    }
//}
