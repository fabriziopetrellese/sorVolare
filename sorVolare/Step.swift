//
//  Step.swift
//  sorVolare
//
//  Created by Fabrizio Petrellese on 25/10/24.
//

import SwiftUI

struct Step: Identifiable, Codable {
    var id = UUID()
    var title: String
    var file: String
    var original = true
}
