ProjectName := basic-sfml-project
ExecName := exec

.PHONY: all clean validate debug release

all: debug

debug: validate
	cmake -D CMAKE_BUILD_TYPE=Debug -B build -S .
	cd build && make
	cp build/exec dest/$(ProjectName)/$(ExecName)-debug
	cp -R data dest/$(ProjectName)

release: validate
	cmake -D CMAKE_BUILD_TYPE=Release -B build -S .
	cd build && make
	cp build/exec dest/$(ProjectName)/$(ExecName)
	cp -R data dest/$(ProjectName)
	zip -r dest/$(ProjectName).zip dest/$(ProjectName)

validate:
	rm -rf dest/$(ProjectName) dest/$(ProjectName).zip
	mkdir -p build dest/$(ProjectName)

clean:
	rm -rf build dest
