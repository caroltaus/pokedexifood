//
//  PokemonDetailViewController.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import UIKit

protocol PokemonDetailViewControllerProtocol: AnyObject {
    func displayData(sections: [PokemonDetailSection])
    func displayLoadingScreen(value: Bool)
    func displayErrorAlert(title: String, message: String, buttonTitle: String)
    func displayPokemonName(name: String)
}

final class PokemonDetailViewController: UIViewController {
    private let interactor: PokemonDetailInteractorProtocol
    private var loadingView = LoadingView(frame: .zero)
    
    init(interactor: PokemonDetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .viewBackground
        setUpHierarchy()
        setUpConstraints()
        
        Task {
            await interactor.loadData()
        }
        loadingView.loading(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIBarButtonItem.appearance().tintColor = .white
    }
    
    private func setUpHierarchy() {
        view.addSubview(loadingView)
    }
    
    private func setUpConstraints() {
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension PokemonDetailViewController: PokemonDetailViewControllerProtocol {
    func displayPokemonName(name: String) {
        navigationItem.title = name
    }
    
    func displayData(sections: [PokemonDetailSection]) {
        print(sections)
    }
    
    func displayLoadingScreen(value: Bool) {
        loadingView.loading(value)
    }
    
    func displayErrorAlert(title: String, message: String, buttonTitle: String) {}
}
