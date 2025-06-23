//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 23.06.2025.
//

import SwiftUI

struct StoriesView: View {
    @StateObject var viewModel: StoriesViewModel
    @Environment(\.dismiss) private var dismiss
    
    private let configuration = Config()
    
    init(stories: Binding<[StoryModel]>, selectedStoryIndex: Int) {
        _viewModel = StateObject(
            wrappedValue: StoriesViewModel(
                stories: stories,
                selectedStoryIndex: selectedStoryIndex
            )
        )
    }
    
    var body: some View {
        GeometryReader { r in
            TabView(selection: $viewModel.currentStoryIndex) {
                ForEach(Array(viewModel.stories.enumerated()), id: \.offset) { (index, story) in
                    ZStack {
                        Image(story.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: r.size.width)
                            .clipShape(RoundedRectangle(cornerRadius: 40))

                        Story(story: story)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .background(.blackUniversal)
            .overlay(alignment: .top) {
                ProgressBar(
                    numberOfSections: viewModel.stories.count,
                    progress: viewModel.progress
                )
                .padding(
                    .init(
                        top: 28,
                        leading: 12,
                        bottom: 12,
                        trailing: 12
                    )
                )
            }
            .overlay(alignment: .topTrailing) {
                backButton
            }
            .onAppear {
                viewModel.startTimer()
            }
            .onDisappear {
                viewModel.stopTimer()
            }
            .onReceive(viewModel.timer) { _ in
                viewModel.timerTick()
            }
            .onTapGesture {
                viewModel.handleTap()
            }
        }
    }
}

private extension StoriesView {
    var backButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.whiteUniversal, Color.blackUniversal)
                        .font(.system(size: 24))
                }
                .padding(.top, 57)
                .padding(.trailing, 12)
            }
            Spacer()
        }
    }
}

private struct Story: View {
    let story: StoryModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                Text(story.title)
                    .font(.bold34)
                    .foregroundColor(.white)
                    .lineLimit(2)
                Text(story.description)
                    .font(.regular20)
                    .lineLimit(3)
                    .foregroundColor(.white)
            }
            .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
        }
    }
}
