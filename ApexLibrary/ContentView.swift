//
//  ContentView.swift
//  ApexLibrary
//
//  Created by Sergio Garcia on 23/4/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentPredatorType = PredatorType.all
    @State var currentMovieType = MovieType.all
    

    let predators = Predators()
    
    var filterDinos: [ApexPredator] {
        predators.filter(by:currentPredatorType)
        predators.filter(by: currentMovieType)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filterDinos) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                } label: {
                    
                    HStack {
                        // Dinosaur Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height:100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment:.leading) {
                            // Name
                            Text(predator.name).fontWeight(.bold)
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentPredatorType.animation()) {
                            ForEach(PredatorType.allCases) {
                                type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentMovieType.animation()) {
                            ForEach(MovieType.allCases) {
                                type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "movieclapper")
                    }
                }
            }
            
        }
            .preferredColorScheme(.dark)
        
    }
}

#Preview {
    ContentView()
}
