import Foundation
import UIKit
import PlaygroundSupport

struct Person { // Model
    let firstName: String
    let lastName: String
}

class GreetingViewController : UIViewController { // View + Controller
    var person: Person!
    lazy var showGreetingButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 200, y: 200, width: 70, height: 70))
        btn.setTitle("Tap me", for: .normal)
        btn.backgroundColor = .green
        return btn
    }()
    
    lazy var greetingLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 100, width: 350, height: 60))
        label.backgroundColor = .red
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(greetingLabel)
        view.addSubview(showGreetingButton)
        
        showGreetingButton.addTarget(self,
                                     action: #selector(didTapButton(button:)),
                                     for: .touchUpInside)
    }
    
    @objc func didTapButton(button: UIButton) {
        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
        self.greetingLabel.text = greeting
        
    }
    // layout code goes here
}
// Assembling of MVC
let model = Person(firstName: "David", lastName: "Blaine")
let view = GreetingViewController()
view.person = model;
view.view.backgroundColor = .lightGray

PlaygroundPage.current.liveView = view.view
