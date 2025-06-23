//
//  StoriesCollectionView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 23.06.2025.
//

import SwiftUI

struct StoriesCollectionView: View {
    @Binding var stories: [StoryModel]
    @Binding var selectedStory: StoryModel?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(stories.indices, id: \.self) { index in
                    let story = stories[index]
                    StoryPreviewCell(story: story)
                        .onTapGesture {
                            stories[index].isViewed = true
                            selectedStory = story
                        }
                }
            }
            .padding(.vertical, 4)
        }
    }
}

private struct StoryPreviewCell: View {
    let story: StoryModel

    var body: some View {
        Spacer()
        
        Image(story.image)
            .resizable()
            .scaledToFill()
            .frame(width: 92, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                VStack(alignment: .leading) {
                    Spacer()
                    Text(story.title)
                        .font(.caption)
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 4)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        story.isViewed
                        ? Color.clear
                        : Color.blue,
                        lineWidth: 4
                    )
            )
            .opacity(story.isViewed ? 0.5 : 1.0)
    }
}

