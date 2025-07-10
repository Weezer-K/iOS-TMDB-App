//
//  ContentView.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                MoviesView()
            }
            .tabItem {
                Image(systemName: "tv")
                Text("Movies")
            }
            NavigationStack {
                LikedMoviesListView()
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }
            NavigationStack {
                SettingView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }.onAppear(perform: {decodeShow()})
    }
}
