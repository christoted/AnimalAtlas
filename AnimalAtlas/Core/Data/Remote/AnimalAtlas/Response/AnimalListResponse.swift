//
//  AnimalListResponse.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation

struct AnimalListResponse: Codable {
    let name: String
    let taxonomy: Taxonomy
    let locations: [String]
    let characteristics: Characteristics
}

struct Characteristics: Codable {
    let prey, nameOfYoung, groupBehavior, estimatedPopulationSize: String?
    let biggestThreat, mostDistinctiveFeature, gestationPeriod, habitat: String?
    let diet, averageLitterSize, lifestyle, commonName: String?
    let numberOfSpecies, location, slogan, group: String?
    let color, skinType, topSpeed, lifespan: String?
    let weight, height, ageOfSexualMaturity, ageOfWeaning: String?

    enum CodingKeys: String, CodingKey {
        case prey
        case nameOfYoung = "name_of_young"
        case groupBehavior = "group_behavior"
        case estimatedPopulationSize = "estimated_population_size"
        case biggestThreat = "biggest_threat"
        case mostDistinctiveFeature = "most_distinctive_feature"
        case gestationPeriod = "gestation_period"
        case habitat, diet
        case averageLitterSize = "average_litter_size"
        case lifestyle
        case commonName = "common_name"
        case numberOfSpecies = "number_of_species"
        case location, slogan, group, color
        case skinType = "skin_type"
        case topSpeed = "top_speed"
        case lifespan, weight, height
        case ageOfSexualMaturity = "age_of_sexual_maturity"
        case ageOfWeaning = "age_of_weaning"
    }
}

struct Taxonomy: Codable {
    let kingdom, phylum, taxonomyClass, order: String?
    let family, genus, scientificName: String?

    enum CodingKeys: String, CodingKey {
        case kingdom, phylum
        case taxonomyClass = "class"
        case order, family, genus
        case scientificName = "scientific_name"
    }
}
