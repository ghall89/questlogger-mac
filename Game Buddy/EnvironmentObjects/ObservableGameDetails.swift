import Foundation

class ObservableGameDetails: ObservableObject {
	@Published var selectedGame: Game?
	@Published var detailSliderOpen: Bool = false
}
