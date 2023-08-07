//
//  NewsTableViewCell.swift
//  DailyToastApp
//
//  Created by jothi on 05/08/23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier:String = "NewsTableViewCell"
    
    private lazy var previewImage: UIImageView = {
        var imageView = UIImageView()
        imageView = UIImageView(image: UIImage(named: "loading_animation"))
        return imageView
    }()
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.layer.masksToBounds = true
        label.contentMode = .scaleToFill
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var newsSnippetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = italicFont(for: label.font)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var newsDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = italicFont(for: label.font)
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        setPreviewImage()
        setVideoTitleLabel()
        setSnippetLabel()
        setDateLabel()
    }
    
    private func setPreviewImage() {
        contentView.addSubview(previewImage)
        setPreviewImageConstraints()
    }
    
    private func setVideoTitleLabel() {
        contentView.addSubview(newsTitleLabel)
        setNewsTitleLabelConstraints()
    }
    
    func setSnippetLabel() {
        contentView.addSubview(newsSnippetLabel)
        setNewsSnippetLabelConstraints()
    }
    
    func setDateLabel() {
        contentView.addSubview(newsDateLabel)
        setNewsDateLabelConstraints()
    }
    
    private func setPreviewImageConstraints() {
        previewImage.translatesAutoresizingMaskIntoConstraints = false
        let previewImageConstraints : [NSLayoutConstraint] = [
            previewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            previewImage.widthAnchor.constraint(equalToConstant: 130),
            previewImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            previewImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(previewImageConstraints)
    }
    
    private func setNewsTitleLabelConstraints() {
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let newsTitleLabelConstraints : [NSLayoutConstraint] = [
            newsTitleLabel.leadingAnchor.constraint(equalTo: previewImage.trailingAnchor,constant: 16),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            newsTitleLabel.heightAnchor.constraint(equalToConstant: 60)
        ]
        NSLayoutConstraint.activate(newsTitleLabelConstraints)
    }
    
    private func setNewsSnippetLabelConstraints() {
        newsSnippetLabel.translatesAutoresizingMaskIntoConstraints = false
        let newsSnippetLabelConstraints: [NSLayoutConstraint] = [
            newsSnippetLabel.leadingAnchor.constraint(equalTo: previewImage.trailingAnchor, constant: 16),
            newsSnippetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsSnippetLabel.heightAnchor.constraint(equalToConstant: 50),
            newsSnippetLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor,constant: -8)
        ]
        NSLayoutConstraint.activate(newsSnippetLabelConstraints)
    }
    
    private func setNewsDateLabelConstraints() {
        newsDateLabel.translatesAutoresizingMaskIntoConstraints = false
        let newsSnippetLabelConstraints: [NSLayoutConstraint] = [
            newsDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            newsDateLabel.heightAnchor.constraint(equalToConstant: 20),
            newsDateLabel.topAnchor.constraint(equalTo: newsSnippetLabel.bottomAnchor, constant: 0)
            
        ]
        NSLayoutConstraint.activate(newsSnippetLabelConstraints)
    }
    
    func setItemInfo(newsItem: Article?) {
        newsTitleLabel.text = newsItem?.headline?.main
        newsSnippetLabel.text = newsItem?.snippet
        newsDateLabel.text = String((newsItem?.publishedDate?[..<10] ?? "Date Unavilable"))
        previewImage.image = newsItem?.articleImage
        downloadAndGetImage(newsItem: newsItem)
        setBoldFont(newsItem: newsItem)
    }
    
    func downloadAndGetImage(newsItem: Article?) {
        DownloadImageNS.shared.downloadImageFromAPI(url:(newsItem?.multimedia?.first?.imageURL)) { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.previewImage.image = image
                }
            } else {
                        
            }
        }
    }
    
    private func setBoldFont(newsItem: Article?) {
        let boldFont = UIFont.boldSystemFont(ofSize: newsTitleLabel.font.pointSize)
        let attributedString = NSAttributedString(string: (newsItem?.headline?.main) ?? NewsL10N(key: .headlineError), attributes: [.font: boldFont])
        newsTitleLabel.attributedText = attributedString
    }
    
    func italicFont(for font: UIFont) -> UIFont {
        if let italicDescriptor = font.fontDescriptor.withSymbolicTraits(.traitItalic) {
            return UIFont(descriptor: italicDescriptor, size: 0)
        } else {
            return font
        }
    }

}
