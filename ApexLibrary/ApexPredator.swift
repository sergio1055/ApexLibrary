//
//  ApexPredator.swift
//  ApexLibrary
//
//  Created by Sergio Garcia on 23/4/24.
//

import Foundation
import SwiftUI
import MapKit


struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [MovieType]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription:String
    }
}



enum MovieType: String, Decodable, CaseIterable, Identifiable {
    case all
    case JurassicParkI = "Jurassic Park"
    case JurassicParkII = "The Lost World: Jurassic Park"
    case JurassicParkIII = "Jurassic Park III"
    case JurassicWorldI = "Jurassic World"
    case JurassicWorldII = "Jurassic World: Fallen Kingdom"
    case JurassicWorldIII = "Jurassic World: Dominion"
    
    var id: MovieType {
        self
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .JurassicParkI:
            "fossil.shell.fill"
        case .JurassicParkII:
            "fossil.shell.fill"
        case .JurassicParkIII:
            "fossil.shell.fill"
        case .JurassicWorldI:
            "globe.europe.africa"
        case .JurassicWorldII:
            "globe.europe.africa"
        case .JurassicWorldIII:
            "globe.europe.africa"
        }
        
    }
}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: PredatorType {
        self
    }
    
    var background: Color {
        switch self {
            case .land:
                .brown
            case .air:
                .teal
            case .sea:
                .blue
        case .all:
                .black
            }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}
