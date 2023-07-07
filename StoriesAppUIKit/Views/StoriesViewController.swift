//
//  ViewController.swift
//  StoriesAppUIKit
//
//  Created by swostik gautam on 07/07/2023.
//

import UIKit
import RxSwift

class StoriesViewController: UIViewController {
    weak var storiesCoordinator: StoriesAppCoordinator?
    
    var storiesViewModel = StoriesViewModel()
    
    var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        let indicator = CustomProgressIndicator(frame: view.frame)
        
        let scrollableView = UIScrollView()
        scrollableView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollviewCOntainer = UIStackView()
        scrollviewCOntainer.axis = .vertical
        scrollviewCOntainer.distribution = .equalSpacing
        scrollviewCOntainer.spacing = 10
        scrollviewCOntainer.translatesAutoresizingMaskIntoConstraints = false
        
        storiesViewModel
            .isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { loading in
                if loading {
                    indicator.startAnimating()
                    return
                }
                indicator.stopAnimating()
                self.navigationItem.title = "Stories"
            }).disposed(by: disposeBag)
        
        storiesViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { error in
                let alert  = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
                
            })
            .disposed(by: disposeBag)
        
        storiesViewModel
            .stories
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { stories in
                if stories.isEmpty {
                    let emptyLabel = UILabel()
                    emptyLabel.text = "Stories Not Found"
                    emptyLabel.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(emptyLabel)
                    NSLayoutConstraint.activate([
                        emptyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                        emptyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    ])
                    return
                }
                for story in stories {
                    let uiColor : UIColor = .random
                    let storyTitleCard = StoryTitleCardView()
                    storyTitleCard.color = uiColor
                    storyTitleCard.title = story.title ?? ""
                    storyTitleCard.author = story.author ?? ""
                    storyTitleCard.onPressed = {
                        self.storiesCoordinator?.gotDetailsScreen(story: story,color: uiColor)
                    }
                    scrollviewCOntainer.addArrangedSubview(storyTitleCard)
                }
            }).disposed(by: disposeBag)
        
        scrollableView.addSubview(scrollviewCOntainer)
        view.addSubview(scrollableView)
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            scrollableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            scrollviewCOntainer.topAnchor.constraint(equalTo: scrollableView.topAnchor , constant: 16),
            scrollviewCOntainer.leadingAnchor.constraint(equalTo: scrollableView.leadingAnchor , constant: 16),
            scrollviewCOntainer.trailingAnchor.constraint(equalTo: scrollableView.trailingAnchor ,  constant: -16),
            scrollviewCOntainer.bottomAnchor.constraint(equalTo: scrollableView.bottomAnchor , constant: -16),
            scrollviewCOntainer.widthAnchor.constraint(equalTo: scrollableView.widthAnchor , constant: -32),
            
            indicator.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: super.view.centerYAnchor),
            
        ])
        storiesViewModel.getStories()
    }
}

extension UIColor {
    static var random: UIColor {
        let red = CGFloat.random(in: 0.6...1)
        let green = CGFloat.random(in: 0.6...1)
        let blue = CGFloat.random(in: 0.6...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

