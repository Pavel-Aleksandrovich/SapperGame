import UIKit
import FlagPhoneNumber
import FirebaseAuth

final class PhoneNumberViewController: UIViewController {
    
    private let phoneNumberTextField = FPNTextField()
    private var listController: FPNCountryListViewController!
    private var phoneNumberString = String()
    private let phoneNumberButton = PhoneNumberButton()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configureLayoutHierarchy()
    }
    
    private func configView() {
        view.backgroundColor = .red
        view.addSubview(phoneNumberTextField)
        view.addSubview(phoneNumberButton)
        
        phoneNumberButton.customButton(title: "tap", action: #selector(tap), view: self, color: .green)
        
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        phoneNumberTextField.delegate = self
        phoneNumberTextField.displayMode = .list
        listController = FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: phoneNumberTextField.countryRepository)
        listController.didSelect = { [ weak self ] country in
            self?.phoneNumberTextField.setFlag(countryCode: country.code)
            
        }
        
        phoneNumberButton.alpha = 0.5
        phoneNumberButton.isEnabled = false
    }
    
    @objc private func tap() {
        val()
    }
    
    private func val() {
//        guard phoneNumberString != nil else { return }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberString, uiDelegate: nil) { (verificationID, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "is empty")
            } else {
                let vc = CodeValidViewController()
                vc.setId(id: verificationID!)
                self.present(vc, animated: false)
            }
        }
    }
    
    
    private func configureLayoutHierarchy() {
        NSLayoutConstraint.activate([
//            vStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
//            vStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
//            vStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            
            phoneNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            phoneNumberTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phoneNumberButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            phoneNumberButton.heightAnchor.constraint(equalToConstant: 60),
            phoneNumberButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 30),
            phoneNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension PhoneNumberViewController: FPNTextFieldDelegate {
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        //erfer
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            phoneNumberButton.alpha = 1
            phoneNumberButton.isEnabled = true
            
            guard let textField = textField.getFormattedPhoneNumber(format: .International) else { return }
            phoneNumberString = textField
        } else {
            phoneNumberButton.alpha = 0.5
            phoneNumberButton.isEnabled = false
        }
    }
    
    func fpnDisplayCountryList() {
        let navigationController = UINavigationController(rootViewController: listController)
        listController.title = "Counties"
        phoneNumberTextField.text = ""
        present(navigationController, animated: false)
    }
    
    
}
