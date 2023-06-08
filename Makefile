BUILD_PATH := FLAnimatedImage/build
PROJECT_NAME := FLAnimatedImage
PROJECT_PATH := FLAnimatedImage/$(PROJECT_NAME).xcodeproj
BINDINGS_PATH := Bindings
IOS_SDK_VERSION := 16.4

clean: clean-project

build-project: clean-project
	xcodebuild -sdk iphonesimulator$(IOS_SDK_VERSION) -project "$(PROJECT_PATH)" -configuration Release EXCLUDED_ARCHS="arm64" ENABLE_BITCODE=NO
	xcodebuild -sdk iphoneos$(IOS_SDK_VERSION) -project "$(PROJECT_PATH)" -configuration Release ENABLE_BITCODE=NO

	cp -R "$(BUILD_PATH)/Release-iphoneos" "$(BUILD_PATH)/Release-fat"

	lipo -create "$(BUILD_PATH)/Release-iphoneos/$(PROJECT_NAME).framework/$(PROJECT_NAME)" "$(BUILD_PATH)/Release-iphonesimulator/$(PROJECT_NAME).framework/$(PROJECT_NAME)" -output "$(BUILD_PATH)/Release-fat/$(PROJECT_NAME).framework/$(PROJECT_NAME)"

	cp -Rf "$(BUILD_PATH)/Release-fat/$(PROJECT_NAME).framework" "./"

clean-project:
	xcodebuild clean -project "$(PROJECT_PATH)"
	rm -Rf "./Frameworks/$(PROJECT_NAME).framework"
	rm -Rf "$(BUILD_PATH)"

build-bindings: clean-bindings
	sharpie bind --sdk=iphoneos$(IOS_SDK_VERSION) --output="$(BINDINGS_PATH)" --namespace="Flipboard.$(PROJECT_NAME)" --scope="./$(PROJECT_NAME).framework/Headers" "./$(PROJECT_NAME).framework/Headers/$(PROJECT_NAME).h"
	
clean-bindings:
	rm -Rf $(BINDINGS_PATH)

build: build-project build-bindings

.PHONY: clean build
