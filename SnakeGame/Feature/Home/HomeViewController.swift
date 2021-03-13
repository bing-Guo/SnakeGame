import UIKit

class HomeViewController: UIViewController {
    let startButton: UIButton = {
        let button = UIButton(frame: .zero)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "GillSans-Bold", size: 17)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("PRESS START", for: .normal)

        return button
    }()

    // MARK: - Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(rgb: 0x253645)

        startButton.addTarget(self, action: #selector(showGameView), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupStartButton()
    }

    private func setupStartButton() {
        view.addSubview(startButton)

        let startButtonConstraints = [
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            startButton.heightAnchor.constraint(equalToConstant: 40),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]

        NSLayoutConstraint.activate(startButtonConstraints)
    }

    @objc private func showGameView(_ sender: UIButton) {
        let viewModel = GameViewModel()
        let viewController = GameViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen

        self.present(viewController, animated: false, completion: nil)
    }
}
