//
//  StoryModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 23.06.2025.
//

import SwiftUI

struct StoryModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
    var isViewed: Bool = false 
    
    static let story1 = StoryModel(
        image: "storyImage1",
        title: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1",
        description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 "
    )

    static let story2 = StoryModel(
        image: "storyImage2",
        title: "Text2 Text2 Text2 Text2 Text2",
        description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 "
    )

    static let story3 = StoryModel(
        image: "storyImage3",
        title: "Text3 Text3 Text3 Text3 Text3",
        description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 "
    )
    
    static let story4 = StoryModel(
        image: "storyImage4",
        title: "Text4 Text4 Text4 Text4 Text4",
        description: "Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 "
    )
}
