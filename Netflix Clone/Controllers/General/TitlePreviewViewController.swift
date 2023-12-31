//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Sasha Maksyutenko on 30.07.2023.
//

import UIKit
import WebKit
class TitlePreviewViewController: UIViewController {
    private let titleLabel:UILabel={
        let label=UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.font = .systemFont(ofSize: 22,weight: .bold)
        label.text="Harry Potter"
        return label
    }()
    private let overViewLabel:UILabel={
        let label=UILabel()
        label.font = .systemFont(ofSize: 18,weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints=false
        label.numberOfLines=0
        label.text="best movie for kids"
        return label
    }()
    private let downloadButton:UIButton={
        let button=UIButton()
        button.translatesAutoresizingMaskIntoConstraints=false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius=8
        button.layer.masksToBounds=true
        return button
    }()
    private let webView:WKWebView={
        let webView=WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints=false
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overViewLabel)
        view.addSubview(downloadButton)
        view.backgroundColor = .systemBackground
        configureConstraints()
    }
    func configureConstraints(){
        let webViewConstraints=[
            webView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        let titleLabelconstraints=[
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
        ]
        let overViewLabelConstraints=[
            overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        let downloadButtonConstraints=[
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor,constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelconstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    func configure(with model:TitlePreviewViewModel){
        titleLabel.text=model.title
        overViewLabel.text=model.titleOverView
        guard let url=URL(string:"https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else{return}
        webView.load(URLRequest(url: url))
    }
}
