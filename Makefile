SRC = $(wildcard nbs/*.ipynb)

all: fastai2_audio docs

fastai2_audio: $(SRC)
	nbdev_build_lib
	touch fastai2_audio

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: bump clean
	$(DIST)
	twine upload --repository pypi dist/*

pypi: dist
	twine upload --repository pypi dist/*

bump:
	nbdev_bump_version

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist