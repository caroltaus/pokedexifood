//
//  LoadingView.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import UIKit
import FLAnimatedImage

class LoadingView: UIView {
    private lazy var loadingViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    
    private lazy var imageLoadingContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .cellBackground
        return view
    }()
    
    private lazy var loadingGif: FLAnimatedImageView = {
        let image = FLAnimatedImageView()
        image.contentMode = .scaleAspectFit
        image.animatedImage = .gif(named: "loadingPikachu")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHierarchy() {
        addSubview(loadingViewContainer)
        loadingViewContainer.addSubview(imageLoadingContainer)
        imageLoadingContainer.addSubview(loadingGif)
    }
    
    func setUpConstraints() {
        loadingViewContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageLoadingContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        imageLoadingContainer.layer.cornerRadius = 100
        
        loadingGif.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(32)
        }
    }
    
    func loading(_ loading: Bool) {
        self.isHidden = !loading
    }
}
