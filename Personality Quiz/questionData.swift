//
//  questionData.swift
//  Personality Quiz
//
//  Created by Aleksey Popov on 01/09/2019.
//  Copyright © 2019 Aleksey Popov. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponceType
    var answer: [Answer]
}

enum ResponceType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"

    var definition: String {
        switch self {
        case.dog :
            return "Вы невероятно любите тусить с друзьями. Вы окружаете себя людьми которые вам нравятся, и обожаете заниматься общими делами."
        case .cat:
            return "Вам нравится самостоятельная жизнь. Вы любите гулять сами по себе."
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны энергией."
        case.turtle:
            return "Вы умны не по годам. Концентрируетесь на детялях. Медленно и верно идете к цели."
        }
    }
}
