cc := gcc
aflags := -m32
lflags := -m32 -no-pie

trg := bin/program.out
src := $(shell ls src/*.s src/*/*.s src/*.c)
tmp1 := $(subst src/,obj/,$(src))
tmp2 := $(subst .c,.o,$(tmp1))
obj := $(subst .s,.o,$(tmp2))

all: $(trg)

$(trg): $(obj)
	@mkdir -p bin/
	$(cc) $(lflags) $^ -o $@

obj/%.o: src/%.s
	@mkdir -p obj/asm
	$(cc) $(aflags) -c $< -o $@

obj/%.o: src/%.c
	@mkdir -p obj/
	$(cc) $(aflags) -c $< -o $@

clean:
	rm -rf obj/*.o obj/*/*.o bin/*.out

test:
	cp src/*.s test/src
	cd test/
	make && clear
	cd ..
