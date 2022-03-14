//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by Shubham Kumar on 01/02/22.
//

import SwiftUI

struct ContentView: View {
    //MARK: PROPERTIES
    @State private var movieTitle: String = ""
    @State private var movies: [Movie] = [Movie]()
    let coreDM: CoreDataManager
    @State private var needsRefresh: Bool = false
    
    private func populateMovies(){
        movies = coreDM.getAllMovies()
    }
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter title", text: $movieTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save"){
                    coreDM.saveMovie(title: movieTitle)
                    populateMovies()
                }//:Button
                List {
                    ForEach(movies, id:\.self) {
                        movie in
                        
                        NavigationLink(destination: MovieDetailView(movie: movie, coreDM: coreDM, needsRefresh: $needsRefresh), label: {
                            Text(movie.title ?? "Not Found!")
                        })//:NavigationLink
                    }//:ForEach
                    .onDelete(perform: {
                        indexSet in
                        indexSet.forEach{
                            index in
                                let movie = movies[index]
                                    //delete using coredata
                                coreDM.deleteMovie(movie: movie)
                                populateMovies()
                        }//indexSet:forEach
                    })//:onDelete
                }//:List
                .listStyle(PlainListStyle())
                .tint(needsRefresh ? .white : .black)
                Spacer()
            }//:VStack
            .padding()
            .navigationTitle("Movies")
            .onAppear(perform: {
                populateMovies()
            })//:OnAppear
        }//:Navigation View
    }
}

//MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
