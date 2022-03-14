//
//  MovieDetailView.swift
//  CoreDataDemo
//
//  Created by Shubham Kumar on 01/02/22.
//

import SwiftUI

struct MovieDetailView: View {
    //MARK: PROPERTIES
    let movie: Movie
    @State private var movieName: String = ""
    var coreDM:CoreDataManager
    @Binding var needsRefresh: Bool
    
    //MARK: BODY
    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Update") {
                if !movieName.isEmpty {
                    movie.title = movieName
                    coreDM.updateMovie()
                    needsRefresh.toggle()
                }
            }//:Button
        }//:VStack
    }
}

//MARK: PREVIEW
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = Movie()
        MovieDetailView(movie: movie, coreDM: CoreDataManager(), needsRefresh: .constant(false) )
    }
}
