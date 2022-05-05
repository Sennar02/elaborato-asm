CC = gcc
CC_FLAGS = -m32 -g

TARGET = bin/prog
SOURCE = src/main.s
OBJECT = $(patsubst src/%.s,obj/%.o,$(SOURCE))

all: $(TARGET)

$(TARGET): $(OBJECT)
	@mkdir -p bin
	$(CC) $(CC_FLAGS) $^ -o $@

$(OBJECT): $(SOURCE)
	@mkdir -p obj
	$(CC) $(CC_FLAGS) -c $^ -o $@

clean:
	rm -rf $(OBJECT)
	rm -rf $(TARGET)
