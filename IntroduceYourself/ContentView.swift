//
//  ContentView.swift
//  IntroduceYourself
//
//  Created by Bipu on 8/27/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    // Inputs
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var schoolName = ""

    // Year segmented control
    private let years = ["First", "Second", "Third", "Fourth"]
    @State private var selectedYearIndex = 0

    // Pets stepper
    @State private var numberOfPets = 0

    // More pets switch (not required by checklist, but common in prework)
    @State private var wantsMorePets = false

    // Alert
    @State private var showAlert = false
    @State private var introduction = ""

    // Try to load a real school logo from Assets.xcassets named "SchoolLogo"
    private var schoolLogoImage: UIImage? { UIImage(named: "SchoolLogo") }

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - School Logo / Name (image on screen)
                Section(header: Text("Your School")) {
                    VStack(spacing: 12) {
                        if let logo = schoolLogoImage {
                            Image(uiImage: logo)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200, maxHeight: 120)
                                .cornerRadius(12)
                                .accessibilityLabel(Text("School logo"))
                        } else {
                            // Fallback icon if you haven't added a SchoolLogo asset yet
                            Image(systemName: "building.columns.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 120, maxHeight: 80)
                                .opacity(0.7)
                                .accessibilityLabel(Text("School icon"))
                        }

                        // Show the school name prominently under the image
                        if !schoolName.trimmingCharacters(in: .whitespaces).isEmpty {
                            Text(schoolName)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        } else {
                            Text("Add your school name below")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    TextField("School name", text: $schoolName)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                }

                // MARK: - About You (three text fields)
                Section(header: Text("About You")) {
                    TextField("First name", text: $firstName)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()

                    TextField("Last name", text: $lastName)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                }

                // MARK: - Year (segmented control)
                Section(header: Text("Academic Year")) {
                    Picker("Year", selection: $selectedYearIndex) {
                        ForEach(years.indices, id: \.self) { i in
                            Text(years[i]).tag(i)
                        }
                    }
                    .pickerStyle(.segmented)
                    .accessibilityLabel(Text("Academic year"))
                }

                // MARK: - Pets (stepper updates label)
                Section(header: Text("Pets")) {
                    Stepper(value: $numberOfPets, in: 0...50) {
                        HStack {
                            Text("Number of pets")
                            Spacer()
                            Text("\(numberOfPets)") // label reflecting stepper value
                                .monospacedDigit()
                                .accessibilityLabel(Text("\(numberOfPets) pets"))
                        }
                    }

                    Toggle("I want more pets", isOn: $wantsMorePets)
                }

                // MARK: - Introduce Button (shows alert)
                Section {
                    Button(role: .none) {
                        let year = years[selectedYearIndex]
                        introduction =
                        """
                        My name is \(firstName) \(lastName) and I attend \(schoolName).
                        I am currently in my \(year) year and I own \(numberOfPets) \(numberOfPets == 1 ? "dog" : "dogs").
                        It is \(wantsMorePets) that I want more pets.
                        """
                        showAlert = true
                    } label: {
                        Text("Introduce Self")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Introduce Yourself")
            .alert("My Introduction", isPresented: $showAlert) {
                Button("Nice to meet you!") { }
            } message: {
                Text(introduction)
            }
        }
    }
}

#Preview {
    ContentView()
}
