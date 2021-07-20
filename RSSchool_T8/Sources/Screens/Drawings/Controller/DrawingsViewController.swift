//
//  DrawingsViewController.swift
//  RSSchool_T8
//
//  Created by rasul on 7/19/21.
//

import UIKit

@objc protocol DrawingsViewDelegate: NSObjectProtocol {
	func didSelect(_ index: Int)
}

class DrawingsViewController: UIViewController {
	
	private var buttons: [UIButton] = []
	private let titles = ["Planet", "Head", "Tree", "Landscape"]
	
	@objc var currentPlanet = 1
	
	@objc weak var delegate: DrawingsViewDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		configureNavigationBar()
		setupButton()
		
		buttons[currentPlanet].isSelected = true
	}
	
	private func configureNavigationBar() {
		title = "Drawings"
		
		let backBarButtonItem = UIBarButtonItem(title: "Artist",
																						style: .done,
																						target: self,
																						action: nil)
		navigationItem.backBarButtonItem = backBarButtonItem
		
		navigationItem.backBarButtonItem?.setTitleTextAttributes([.font: UIFont.montserratMedium(17),
																															.foregroundColor: UIColor.lightGreenSea(1.0)],
																														 for: .normal);
	}
	
	private func setupButton() {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .center
		stack.spacing = 20
		
		for i in titles.indices {
			let button = CustomButton(type: titles[i])
			button.tag = i
			buttons.append(button)
			button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
			
			NSLayoutConstraint.activate([
				button.heightAnchor.constraint(equalToConstant: 40),
				button.widthAnchor.constraint(equalToConstant: 200)
			])
			
			stack.addArrangedSubview(button)
			
		}
		
		view.addSubview(stack)
		
		[
			stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
			stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		].forEach { $0.isActive = true }
	}
	
	// MARK: Action
	@objc private func buttonTapped (_ sender: UIButton) {
		let index = sender.tag
		
		if currentPlanet == index {
			buttons[currentPlanet].isSelected = true;
		} else {
			buttons[currentPlanet].isSelected = false;
			buttons[index].isSelected = true;
			currentPlanet = index
		}
		delegate?.didSelect(index)
		back()
	}
	
	func back() {
		navigationController?.popViewController(animated: true)
	}
}
