//
//  MainView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: RouteViewModel
    @EnvironmentObject private var filterViewModel: FilterViewModel
    @State private var showStories = false
    
    @State private var stories: [StoryModel] = [
        StoryModel.story1,
        StoryModel.story2,
        StoryModel.story3,
        StoryModel.story4
    ]

    @State private var selectedStory: StoryModel?
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            switch viewModel.mode {
            case .content:
                contentView
                    .padding(.horizontal)
            case .error(let type):
                ErrorView(errorType: type)
            }
        }
        .fullScreenCover(item: $selectedStory) { story in
            StoriesView(
                stories: $stories,
                selectedStoryIndex: stories.firstIndex(
                    where: { $0.id == story.id }
                ) ?? .zero
            )
        }
    }
}

private extension MainView {
    var contentView: some View {
        VStack(spacing: 44) {
            StoriesCollectionView(
                stories: $stories,
                selectedStory: $selectedStory
            )
                .padding(.top, 16)
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: .zero) {
                    Button(action: viewModel.selectFrom) {
                        HStack {
                            Text(viewModel.fromRaw ?? "Откуда")
                                .foregroundStyle(
                                    viewModel.fromRaw == nil
                                    ? .grayUniversal
                                    : .blackUniversal
                                )
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: viewModel.selectTo) {
                        HStack {
                            Text(viewModel.toRaw ?? "Куда")
                                .foregroundStyle(
                                    viewModel.toRaw == nil
                                    ? .grayUniversal
                                    : .blackUniversal
                                )
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.whiteUniversal)
                )
    
                Button(action: viewModel.swapAction) {
                    Image(.swapIcon)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blueUniversal)
            )
            
            if viewModel.fromRaw != nil &&
                viewModel.toRaw != nil {
                Button(action: viewModel.showCarriers) {
                    Text("Найти")
                        .foregroundStyle(.whiteUniversal)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 47)
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.blueUniversal)
                )
            }
            
            Spacer()
        }
    }
}
