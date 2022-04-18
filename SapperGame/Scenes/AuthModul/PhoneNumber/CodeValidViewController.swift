import UIKit
import FirebaseAuth

final class CodeValidViewController: UIViewController {
    
    private var verificationID = String()
    private let codeTextView = UITextView()
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
    
    func setId(id: String) {
        verificationID = id
    }
    
    private func configView() {
        view.backgroundColor = .orange
        view.addSubview(codeTextView)
        view.addSubview(phoneNumberButton)
        
        codeTextView.translatesAutoresizingMaskIntoConstraints = false
        
        phoneNumberButton.customButton(title: "tap", action: #selector(tap), view: self, color: .green)
        
        codeTextView.delegate = self
        
        phoneNumberButton.alpha = 0.5
        phoneNumberButton.isEnabled = false
    }
    
    @objc private func tap() {
        guard let code = codeTextView.text else { return }
        
        let credetional = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        Auth.auth().signIn(with: credetional) { (_, error) in
            if error != nil {
                let ac = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Отмена", style: .cancel)
                ac.addAction(cancel)
                self.present(ac, animated: true)
            } else {
//                self.showContentVC()
                print("success")
            }
        }
    }
    
    private func configureLayoutHierarchy() {
        NSLayoutConstraint.activate([
//            vStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
//            vStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
//            vStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            
            codeTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            codeTextView.heightAnchor.constraint(equalTo: codeTextView.widthAnchor),
            codeTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            codeTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phoneNumberButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            phoneNumberButton.heightAnchor.constraint(equalToConstant: 60),
            phoneNumberButton.topAnchor.constraint(equalTo: codeTextView.bottomAnchor, constant: 30),
            phoneNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension CodeValidViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + text.count - range.length
        return newLength <= 6
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 6 {
            phoneNumberButton.alpha = 1
            phoneNumberButton.isEnabled = true
        } else {
            phoneNumberButton.alpha = 0.5
            phoneNumberButton.isEnabled = false
        }
        
    }
}
