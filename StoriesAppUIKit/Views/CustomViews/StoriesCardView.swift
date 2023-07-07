//
//  CustomCardView.swift
//  StoriesAppUIKit
//
//  Created by swostik gautam on 07/07/2023.
//
import UIKit

class StoryTitleCardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupCardView()
        setupGestureRecognizer()

    }
    
    var title : String = .init() {
        didSet {
            label.text = title
        }
    }
    
    var author : String = .init() {
        didSet{
            authorName.text = author
        }
    }
    
    var color : UIColor = .init(){
        didSet {
            cardView.backgroundColor = color
        }
    }
    
    var onPressed: (() -> Void)?
    
    private func setupCardView() {
        cardView.addSubview(label)
        cardView.addSubview(authorName)
        self.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -16),
            
            authorName.topAnchor.constraint(equalTo: label.bottomAnchor , constant: 16),
            authorName.trailingAnchor.constraint(equalTo: cardView.trailingAnchor , constant: -16),
            authorName.bottomAnchor.constraint(equalTo: cardView.bottomAnchor , constant: -16),
        ])
    }
    
    lazy var cardView : UIView = {
        let cardView = UIView()
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 10.0, height: 0.0)
        cardView.layer.shadowRadius = 6.0
        cardView.layer.shadowOpacity = 0.7
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let authorName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font =  UIFont(name: "Avenir-Light", size: 15.0)
        return label
    }()
    
    private func setupGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onCardPressed(_:)))
        cardView.addGestureRecognizer(gesture)
    }
    
    
    @objc private func onCardPressed(_ sender: UITapGestureRecognizer) {
        onPressed?()
    }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
