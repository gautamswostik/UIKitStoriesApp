//
//  StoryDetailView.swift
//  StoriesAppUIKit
//
//  Created by swostik gautam on 07/07/2023.
//

import UIKit

class StoryDetailView: UIViewController {
    weak var storiesCoordinator: StoriesAppCoordinator?
    
    var story: StoriesModel = StoriesModel()
    var color: UIColor = UIColor()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
        
        let title =  UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 32, weight: .bold)
        title.text = story.title
        
        let description =  UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.font = UIFont(name: "Thonburi", size: 18)
        description.text = story.story
        
        let moral =  UILabel()
        moral.translatesAutoresizingMaskIntoConstraints = false
        moral.numberOfLines = 0
        moral.font = UIFont(name: "GillSans-LightItalic", size: 18)
        moral.text = "Moral : \(story.moral ?? "")"
        
        let author =  UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        author.font =  UIFont(name: "Avenir-Light", size: 15.0)
        author.text = "~ \(story.author ?? "")"
        
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(title)
        scrollView.addSubview(description)
        scrollView.addSubview(moral)
        scrollView.addSubview(author)
        
        view.addSubview(scrollView)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            title.topAnchor.constraint(equalTo: scrollView.topAnchor),
            title.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            title.widthAnchor.constraint(equalTo: view.widthAnchor , constant: -32),
            
            description.topAnchor.constraint(equalTo: title.bottomAnchor ,constant: 20),
            description.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            description.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            moral.topAnchor.constraint(equalTo: description.bottomAnchor ,constant: 20),
            moral.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            moral.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            author.topAnchor.constraint(equalTo: moral.bottomAnchor ,constant: 20),
            author.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            author.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -16)
        ])
    }

}
