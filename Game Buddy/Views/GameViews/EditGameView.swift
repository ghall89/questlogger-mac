import SwiftUI

struct PlatformPickerView: View {
	@Binding var selectedPlatform: String
	var game: Game
	var gameDetails: GameDetails?
	
	var body: some View {
		Picker("Platform", selection: $selectedPlatform, content: {
			if gameDetails != nil {
				ForEach(gameDetails?.platforms ?? []) { platform in
					Text(platform.abbreviation ?? platform.name).tag(platform.abbreviation ?? platform.name)
				}
			} else if game.platform != nil {
				Text(game.platform!).tag(game.platform!)
			}
		})
	}
}

struct EditGameView: View {
	@EnvironmentObject var observableCollection: ObservableCollection
	
	var game: Game
	
	@Binding var show: Bool
	
	@State var gameDetails: GameDetails?
	@State private var gameTitle: String = ""
	@State private var selectedPlatform: String = ""
	@State private var noteBody: String = ""
	
	var body: some View {
		VStack(spacing: 20) {
			TextField("Title", text: $gameTitle)
			Picker("Platform", selection: $selectedPlatform, content: {
				if gameDetails != nil {
					ForEach(gameDetails?.platforms ?? []) { platform in
						Text(platform.abbreviation ?? platform.name).tag(platform.abbreviation ?? platform.name)
					}
				} else if game.platform != nil {
					Text(game.platform!).tag(game.platform!)
				}
			})
			TextField("Notes", text: $noteBody, axis: .vertical)
				.lineLimit(4, reservesSpace: true)
			
			HStack {
				Spacer()
				Button(action: {
					show.toggle()
				}, label: {
					Text("Cancel")
				})
				Button(action: saveChanges, label: {
					Text("Save")
				})
				.keyboardShortcut(.defaultAction)
				.disabled(gameTitle.isEmpty)
			}
		}
		.frame(width: 300)
		.padding()
		.onAppear {
			getGameDetails()
			
			gameTitle = game.name
			selectedPlatform = game.platform ?? ""
			noteBody = game.notes ?? ""
		}
	}
	
	private func saveChanges() {
		if selectedPlatform != game.platform {
			updateGame(id: game.id, collection: &observableCollection.collection, platform: selectedPlatform)
		}
		if noteBody != game.notes {
			updateGame(id: game.id, collection:  &observableCollection.collection, note: noteBody)
		}
		
		show.toggle()
	}
	
	private func getGameDetails() {
		print("Loading game details...")
		getGameById(id: game.id) {result in
			gameDetails = result
		}
	}
}
