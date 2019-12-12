//
//  ContentView.swift
//  ChuckNorisJokes
//
//  Created by Ramill Ibragimov on 12.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var randomJoke: String = ""
    @State private var specificJoke: String = ""
    @State private var randomJokeID: Int = 0
    @State private var specificJokeID: Int = 0
    @State private var jokeCount: Int = 1

    var body: some View {
        TabView {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Joke id: \(self.randomJokeID)")
                        .foregroundColor(.secondary)
                        .padding()
                }
                Text(self.randomJoke)
                    .foregroundColor(.primary)
                    .font(.title)
                    .padding()
                Spacer()
                Button(action: {
                        self.getRandomJoke()
                    }) {
                        Image(systemName: "arrow.2.circlepath")
                            .font(.title)
                    }
                .padding()
            }.onAppear() {
                self.getJokeCount()
                self.getRandomJoke()
            }.tabItem({
                Image(systemName: "flame")
                    .resizable()
                    .font(.title)
            })
            
            VStack {
                Text("Total joke count: \(self.jokeCount)")
                    .foregroundColor(.secondary)
                    .padding()
                Spacer()
                HStack {
                    Spacer()
                    Text("Joke id: \(self.specificJokeID)")
                        .foregroundColor(.secondary)
                        .padding()
                }
                Text(self.specificJoke)
                    .foregroundColor(.primary)
                    .font(.title)
                    .padding()
                Spacer()
                
                HStack {
                    Picker("", selection: $specificJokeID) {
                        ForEach(0..<self.jokeCount) { index in
                            Text("Joke \(index)").tag(index)
                        }
                    }.padding()
                        
                    Button(action: {
                            self.getSpecificJoke()
                        }) {
                            Image(systemName: "bolt")
                                .font(.title)
                        }
                    .padding()
                }
            }.onAppear() {
                self.getJokeCount()
                self.getSpecificJoke()
            }.tabItem({
                Image(systemName: "drop.triangle")
                    .resizable()
                    .font(.title)
            })
        }
    }
    
    func getRandomJoke() {
        NetworkManager.fetchRandom { page in
            DispatchQueue.main.async {
                let tempString = page.value?.joke ?? "n/a"
                let newString = tempString.replacingOccurrences(of: "&quot;", with: "'")
                
                self.randomJoke = newString
                self.randomJokeID = page.value?.id ?? 0
            }
        }
    }
    
    func getJokeCount() {
        NetworkManager.fetchJokeCount { page in
            DispatchQueue.main.async {
                self.jokeCount = page.value ?? 0
            }
        }
    }
    
    func getSpecificJoke() {
        NetworkManager.fetchSpecificJoke("/\(specificJokeID)") { page in
            DispatchQueue.main.async {
                let tempString = page.value?.joke ?? "n/a"
                let newString = tempString.replacingOccurrences(of: "&quot;", with: "'")
                
                self.specificJoke = newString
                self.specificJokeID = page.value?.id ?? 0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
