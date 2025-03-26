//
//  PokemonListViewController.swift
//  pokedex
//
//  Created by Caroline Taus on 25/03/25.
//

import UIKit

protocol PokemonListViewControllerProtocol: AnyObject {
    
}

final class PokemonListViewController: UIViewController, PokemonListViewControllerProtocol {
    private let interactor: PokemonListInteractorProtocol
    
    init(interactor: PokemonListInteractorProtocol) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemPink
    }
    
}
