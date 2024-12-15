import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var inputCity: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter city name", text: $inputCity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                Button(action: {
                    viewModel.fetchWeather(for: inputCity)
                    inputCity = ""
                }) {
                    Text("Get Weather")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    VStack {
                        Text("City: \(viewModel.cityName)")
                            .font(.title2)
                            .padding(.top)
                        
                        Text("Temperature: \(viewModel.temperature)")
                            .font(.largeTitle)
                            .bold()
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Simple Weather App")
        }
    }
}

#Preview {
    ContentView()
}
