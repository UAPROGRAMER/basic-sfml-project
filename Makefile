PROJECT_NAME := project
EXEC_NAME := exec
CMAKE_EXIT_NAME := exit

BUILD_TYPE := Debug # Release

BUILD_FOLDER := build
DEST_FOLDER := dest
DATA_FOLDER := data

PROJECT_FOLDER := $(DEST_FOLDER)/$(PROJECT_NAME)
EXEC := $(PROJECT_FOLDER)/$(EXEC_NAME)
CMAKE_EXIT := $(BUILD_FOLDER)/$(CMAKE_EXIT_NAME)

.PHONY: all clean cmake zip

all: $(EXEC)

zip: $(EXEC)
	cd $(DEST_FOLDER) && zip -r $(PROJECT_NAME).zip $(PROJECT_NAME)

$(EXEC): $(CMAKE_EXIT) $(PROJECT_FOLDER)/
	cp $(CMAKE_EXIT) $(EXEC)
	test -d $(DATA_FOLDER) && cp -R $(DATA_FOLDER) $(PROJECT_FOLDER)

$(CMAKE_EXIT): cmake
	cd build && make

cmake: $(BUILD_FOLDER)/
	cmake -D CMAKE_BUILD_TYPE=$(BUILD_TYPE) -B $(BUILD_FOLDER) -S .

$(BUILD_FOLDER)/:
	mkdir -p $(BUILD_FOLDER)

$(PROJECT_FOLDER)/: $(DEST_FOLDER)/
	mkdir -p $(PROJECT_FOLDER)

$(DEST_FOLDER)/:
	mkdir -p $(DEST_FOLDER)

clean:
	rm -rf $(BUILD_FOLDER) $(DEST_FOLDER)
