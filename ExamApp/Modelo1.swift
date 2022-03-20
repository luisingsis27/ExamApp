//
//  Modelo1.swift
//  ExamApp
//
//  Created by Luis on 17/03/22.
//

import Foundation

/*struct Model1 : Codable {
    var result : ModelP
    
}*/

struct ModelP: Codable {
    let colors: [String]
    let questions: [Question]
    
    
       /*init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)

           self.colors = try container.decode([String].self, forKey: .colors)
           self.questions = try container.decode([Question].self, forKey: .questions)
       }*/
}
// MARK: - Question
struct Question: Codable {
    let total: Int
    let text: String
    let chartData: [ChartDatum]
}

// MARK: - ChartDatum
struct ChartDatum: Codable {
    let text: String
    let percetnage: Int
}

