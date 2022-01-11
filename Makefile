bundle:
	rm -rf build
	rm -f payload.zip
	mkdir build
	cp -r app/* build
	pip install --target ./build -r ./app/requirements.txt
	cd build; zip -r ../payload.zip *
