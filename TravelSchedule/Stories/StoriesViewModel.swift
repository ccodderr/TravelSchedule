//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 23.06.2025.
//

import SwiftUI
import Combine

final class StoriesViewModel: ObservableObject {
    @Published var progress: CGFloat = 0.0
    @Published var currentStoryIndex: Int = 0
    
    @Binding private(set) var stories: [StoryModel]
    
    private(set) var timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    private var configuration: Config
    private var cancellable: Cancellable?
    private var step: CGFloat
    private var subscriptions = Set<AnyCancellable>()
    
    init(stories: Binding<[StoryModel]>, selectedStoryIndex: Int) {
        _stories = stories
        
        let index = min(selectedStoryIndex, stories.count - 1)
        self.step = 1 / CGFloat(stories.count)
        self.currentStoryIndex = index
        self.progress = CGFloat(selectedStoryIndex) / CGFloat(stories.count)
        
        self.configuration = Config(storiesCount: stories.count)
        
        addObservers()
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.publish(
            every: configuration.timerTickInternal,
            on: .main,
            in: .common
        ).autoconnect()
    }
    
    func stopTimer() {
        cancellable?.cancel()
    }
    
    func resetTimer() {
        startTimer()
    }
    
    func nextStory() {
        let storiesCount = stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount
        ? currentStoryIndex + 1
        : 0
        
        self.currentStoryIndex = nextStoryIndex
    }
    
    func handleTap() {
        nextStory()
        resetTimer()
    }
    
    func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
            nextStory()
        }
        
        if nextProgress >= step * CGFloat(currentStoryIndex + 1) {
            nextStory()
        }
        
        progress = nextProgress
    }
}

private extension StoriesViewModel {
    func addObservers() {
        $currentStoryIndex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] index in
                guard let self else { return }
                
                self.stories[index].isViewed = true
                withAnimation {
                    self.progress = CGFloat(index) / CGFloat(self.stories.count)
                }
            }
            .store(in: &subscriptions)
    }
    
    func createTimer(configuration: Config) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
