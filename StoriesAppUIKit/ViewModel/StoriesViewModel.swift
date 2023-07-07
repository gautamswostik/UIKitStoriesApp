//
//  StoriesViewModel.swift
//  StoriesAppUIKit
//
//  Created by swostik gautam on 07/07/2023.
//

import Foundation
import RxSwift

class StoriesViewModel {
    private var storiesApiService = StoriesApiService()
     
    var stories: PublishSubject<[StoriesModel]> = .init()
    var isLoading: PublishSubject<Bool> = .init()
    var error: PublishSubject<Error>  = .init()
    
    func getStories() {
        isLoading.onNext(true)
        storiesApiService.fetchStories { stories in
            switch stories {
            case .success(let stories):
                self.isLoading.onNext(false)
                self.stories.onNext(stories)
            case .failure(let error):
                self.stories.onNext([])
                self.isLoading.onNext(false)
                self.error.onNext(error)
            }
        }
    }
    
}
