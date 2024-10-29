//
//  Toy.swift
//  sorVolare
//
//  Created by Tulli-OS on 28/10/24.
//

import SwiftUI

struct Toy {
    let id: Int
    let color: Color
}

extension Toy {
    static let all = [
        Toy(id: 1, color: .red),
        Toy(id: 2, color: .blue),
        Toy(id: 3, color: .green),
        Toy(id: 4, color: .black),
        Toy(id: 5, color: .orange),
        Toy(id: 6, color: .purple),
        Toy(id: 7, color: .brown),
        Toy(id: 8, color: .yellow),
        Toy(id: 9, color: .gray)
    ]
}
