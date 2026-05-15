TARGET ?= ../assignment-template

.PHONY: test

test:
	bash run_hidden.sh $(TARGET)