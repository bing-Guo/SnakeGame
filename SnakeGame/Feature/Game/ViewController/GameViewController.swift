import UIKit

class GameViewController: UIViewController {
    let viewModel: GameViewModel
    let snakeGameView = SnakeGameView()
    let swipLeftGesture = UISwipeGestureRecognizer()
    let swipRightGesture = UISwipeGestureRecognizer()
    let swipUpGesture = UISwipeGestureRecognizer()
    let swipDownGesture = UISwipeGestureRecognizer()

    var timer: Timer?

    // MARK: - Initializer
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(rgb: 0x253645)

        setupGestureConfig()
        setupViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.start()
    }

    override func viewDidDisappear(_ animated: Bool) {
         if self.timer != nil {
              self.timer?.invalidate()
         }
    }

    override func viewDidLayoutSubviews() {
        setupSnakeGameView()
    }
}

extension GameViewController {
    // MARK: - Setup
    private func setupSnakeGameView() {
        snakeGameView.layer.borderWidth = 1
        snakeGameView.layer.borderColor = UIColor.white.cgColor
        snakeGameView.translatesAutoresizingMaskIntoConstraints = false
        snakeGameView.backgroundColor = UIColor(rgb: 0x253645)
        snakeGameView.delegate = self

        self.view.addSubview(snakeGameView)

        let frame = getSnakeGameFrame()
        snakeGameView.frame = frame
        viewModel.area = Area(leftTop: Point(x: 0, y: 0),
                              rightTop: Point(x: Int(frame.width), y: 0),
                              leftBottom: Point(x: 0, y: Int(frame.height)),
                              rightBottom: Point(x: Int(frame.width), y: Int(frame.height)))
    }

    private func getSnakeGameFrame() -> CGRect {
        let canvasHeight = Int(self.view.frame.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom)
        let canvasWidth = Int(self.view.frame.width)
        let moduloCanvasHeight = canvasHeight % viewModel.gridUnit
        let moduloCanvasWidth = canvasWidth % viewModel.gridUnit

        let height = canvasHeight - moduloCanvasHeight
        let width = canvasWidth - moduloCanvasWidth
        let yOffset = Int(self.view.safeAreaInsets.top) + (moduloCanvasHeight / 2)
        let xOffset = moduloCanvasWidth / 2

        return CGRect(x: xOffset, y: yOffset, width: width, height: height)
    }

    private func setupGestureConfig() {
        swipLeftGesture.addTarget(self, action: #selector(turnDirection))
        swipLeftGesture.direction = .left

        swipRightGesture.addTarget(self, action: #selector(turnDirection))
        swipRightGesture.direction = .right

        swipUpGesture.addTarget(self, action: #selector(turnDirection))
        swipUpGesture.direction = .up

        swipDownGesture.addTarget(self, action: #selector(turnDirection))
        swipDownGesture.direction = .down

        view.addGestureRecognizer(swipLeftGesture)
        view.addGestureRecognizer(swipRightGesture)
        view.addGestureRecognizer(swipUpGesture)
        view.addGestureRecognizer(swipDownGesture)
    }

    private func setupViewModel() {
        viewModel.startGame = { [unowned self] in
            self.timer = Timer.scheduledTimer(timeInterval: viewModel.timeInterval, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
        }

        viewModel.updateView = { [unowned self] in
            self.snakeGameView.draw(.zero)
        }

        viewModel.showGameOverView = { [unowned self] in
            self.timer?.invalidate()
            self.timer = nil

            showGameOverAlert()
        }
    }

    private func showGameOverAlert() {
        let alert = UIAlertController(title: "Game Over", message: nil, preferredStyle: .alert)

        let tryAgainButton = UIAlertAction(title: "Try Again", style: .default) { [weak viewModel] _ in
            viewModel?.start()
        }

        let backButton = UIAlertAction(title: "Back", style: .default) { [weak self] _ in
            self?.dismiss(animated: false, completion: nil)
        }

        alert.addAction(tryAgainButton)
        alert.addAction(backButton)

        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Action
    @objc private func turnDirection(_ sender: UISwipeGestureRecognizer) {
        viewModel.turnDirection(sender.direction.asDirection())
    }

    @objc private func updateView(_ sender: Timer) {
        viewModel.checkGameState()
    }
}

// MARK: - SnakeGameProtocol
extension GameViewController: SnakeGameProtocol {
    func getArea() -> Area {
        return viewModel.area
    }

    func getUnit() -> Int {
        return viewModel.gridUnit
    }
    
    func getSnakePath() -> [Point] {
        return viewModel.snake.path
    }

    func getFoodPosition() -> Point {
        return viewModel.food.position
    }
}
