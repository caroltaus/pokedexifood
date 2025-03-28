//
//  PokemonDetailViewController.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import UIKit

protocol PokemonDetailViewControllerProtocol: AnyObject {
    
}

final class PokemonDetailViewController: UIViewController, PokemonDetailViewControllerProtocol {
    private let interactor: PokemonDetailInteractorProtocol
    
    init(interactor: PokemonDetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .purple
    }
}
