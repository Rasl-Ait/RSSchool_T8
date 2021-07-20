//
//  TimerViewController.swift
//  RSSchool_T8
//
//  Created by rasul on 7/18/21.
//

import UIKit

 @objc protocol TimerViewControllerDelegate: NSObjectProtocol {
	@objc func didSaveButton()
	func didChangeValue(_ value: Float);
}

class TimerViewController: UIViewController {

	private let slider = UISlider()
	private let minLabel = UILabel()
	private let maxLabel = UILabel()
	private let valueLabel = UILabel()
	private let saveButton = CustomButton(type: "Save")
	
	@objc var progressValue: Float = 1.0
	
	private let step: Float = 5
	
	@objc weak var delegate: TimerViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
			setupLabel()
			setupSlider()
			setupButton()
			setupStack()
			
			slider.setValue(progressValue, animated: true)
			valueLabel.text = "\(progressValue) s"
    }
	
	private func setupSlider() {
		slider.translatesAutoresizingMaskIntoConstraints = false
		slider.minimumValue = 1
		slider.maximumValue = 5
		
		slider.isContinuous = true
		slider.tintColor = UIColor.lightGreenSea(1.0)
		slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
	}

	private func setupLabel() {
		minLabel.text = "1.0"
		minLabel.font = .montserratRegular(18)
		
		maxLabel.text = "5.0"
		maxLabel.font = .montserratRegular(18)
		
		valueLabel.text = "1.00 s"
		valueLabel.textAlignment = .center
		valueLabel.font = .montserratRegular(18)
		
		valueLabel.translatesAutoresizingMaskIntoConstraints = false
		maxLabel.translatesAutoresizingMaskIntoConstraints = false
		minLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupButton() {
		saveButton.translatesAutoresizingMaskIntoConstraints = false
		saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
		view.addSubview(saveButton)
		[
			saveButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 10),
			saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
			saveButton.widthAnchor.constraint(equalToConstant: 85),
			saveButton.heightAnchor.constraint(equalToConstant: 32)
		].forEach { $0.isActive = true }
	}
	
	func setupStack() {
		let vStack = UIStackView()
		vStack.translatesAutoresizingMaskIntoConstraints = false
		vStack.axis = .vertical
		vStack.alignment = .fill
		vStack.distribution = .fill
		vStack.spacing = 20;
		
		let hStack = UIStackView()
		hStack.axis = .horizontal
		hStack.alignment = .fill
		hStack.distribution = .fill
		hStack.spacing = 20;
		
		hStack.addArrangedSubview(minLabel)
		hStack.addArrangedSubview(slider)
		hStack.addArrangedSubview(maxLabel)
		vStack.addArrangedSubview(hStack)
		vStack.addArrangedSubview(valueLabel)
		view.addSubview(vStack)
		
		[
			vStack.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 30),
			vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
		].forEach { $0.isActive = true }
	}
	
	// MARK: Action
	@objc private func sliderValueDidChange(_ sender: UISlider) {
		let roundedStepValue = (sender.value / step) * step
		sender.value = roundedStepValue
		let value = String(format: "%.01f", roundedStepValue)
		print("Slider step value \(value)")
		valueLabel.text = "\(value) s"
		progressValue = Float(value) ?? 0.0
	}
	
	@objc private func saveButtonTapped() {
		delegate?.didChangeValue(progressValue)
		delegate?.didSaveButton()
	}
}
