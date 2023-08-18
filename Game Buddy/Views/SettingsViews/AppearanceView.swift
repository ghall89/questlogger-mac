import SwiftUI

func sameColor(_ color1: Color, _ color2: Color) -> Bool {
	return color1 == color2
}

struct AppearanceView: View {
	@AppStorage("preferredColorScheme") var preferredColorScheme: String = "system"
	@AppStorage("blurBackground") var blurBackground = true
	
	internal struct ColorTheme: Identifiable {
		let id: UUID = UUID()
		var title: String
		var color: Color
	}
	
	var colors = AccentColor.allCases.map { "\($0)" }
	
	var body: some View {
		Form {
			Toggle("Blur Game Backgrounds", isOn: $blurBackground)
			Picker(selection: $preferredColorScheme, content: {
				Text("System").tag("system")
				Text("Light").tag("light")
				Text("Dark").tag("dark")
			}, label: {
				Text("Light/Dark Mode")
			})
		}
	}
}
