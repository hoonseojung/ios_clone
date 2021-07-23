import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        self.emailTextfield.delegate = self
        self.passwordTextfield.delegate = self
        title = K.appName
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        //login 버튼 클릭 시
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    let failToLoginAlert = UIAlertController(title: "Error", message: "이메일 혹은 비밀번호를 잘못 입력하셨습니다.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title:"확인", style: UIAlertAction.Style.default, handler:nil)
                    failToLoginAlert.addAction(okAction)
                    self.present(failToLoginAlert, animated: true, completion: nil)
                }
                else {
                    //navigate to the chatviewcontroller
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //키보드의 enter 버튼 클릭 시
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    let failToLoginAlert = UIAlertController(title: "Error", message: "이메일 혹은 비밀번호를 잘못 입력하셨습니다.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title:"확인", style: UIAlertAction.Style.default, handler:nil)
                    failToLoginAlert.addAction(okAction)
                    self.present(failToLoginAlert, animated: true, completion: nil)
                }
                else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
        return true
    }
}
